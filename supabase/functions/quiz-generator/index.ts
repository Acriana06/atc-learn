import { serve } from "https://deno.land/std@0.168.0/http/server.ts";

const GROQ_API_KEY = Deno.env.get('GROQ_API_KEY');
const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};

serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const { courseTitle, courseContent } = await req.json();

    if (!courseContent) {
      return new Response(
        JSON.stringify({ error: "Course content is required to generate a quiz." }),
        { status: 400, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    if (!GROQ_API_KEY) {
      console.error("GROQ_API_KEY environment variable is missing in Supabase secrets.");
      return new Response(
        JSON.stringify({ error: "Server configuration error: Missing Groq API key." }),
        { status: 500, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    const systemPrompt = `
    You are an expert aviation examiner and ICAO curriculum instructor.
    Generate a 10-question multiple-choice quiz based strictly on the provided course material.

    Output MUST be a valid JSON object with a "quiz" key containing an array of 10 objects. Format:
    {
      "quiz": [
        {
          "question": "Question text here?",
          "options": ["Option A", "Option B", "Option C", "Option D"],
          "correctIndex": 0
        }
      ]
    }
    `;

    const userPrompt = `Course Title: ${courseTitle}\n\nContent:\n${courseContent}`;

    const response = await fetch("https://api.groq.com/openai/v1/chat/completions", {
      method: "POST",
      headers: {
        "Authorization": `Bearer ${GROQ_API_KEY}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        model: "openai/gpt-oss-20b",
        messages: [
          { role: "system", content: systemPrompt },
          { role: "user", content: userPrompt }
        ],
        temperature: 0.3,
        response_format: { type: "json_object" }
      }),
    });

    const data = await response.json();

    if (!response.ok) {
      console.error("Groq API Error:", JSON.stringify(data));
      return new Response(
        JSON.stringify({ error: data.error?.message || "Failed to communicate with AI model." }),
        { status: response.status, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    let rawReply = data.choices?.[0]?.message?.content || "{}";

    rawReply = rawReply.trim();
    if (rawReply.startsWith("```json")) {
      rawReply = rawReply.replace(/^```json/, "").replace(/```$/, "").trim();
    } else if (rawReply.startsWith("```")) {
      rawReply = rawReply.replace(/^```/, "").replace(/```$/, "").trim();
    }

    let parsedQuiz;
    try {
      parsedQuiz = JSON.parse(rawReply);
    } catch (parseErr) {
      console.error("JSON Parse Error on rawReply:", rawReply);
      throw new Error("AI returned malformed JSON format.");
    }

    if (!parsedQuiz.quiz || !Array.isArray(parsedQuiz.quiz)) {
      parsedQuiz = {
        quiz: [
          {
            question: `According to ${courseTitle}, what is a core operational priority?`,
            options: ["Safety assurance and efficiency", "Unrestricted taxi routing", "Manual radar vectoring only", "Altitude disregard"],
            correctIndex: 0
          }
        ]
      };
    }

    return new Response(JSON.stringify(parsedQuiz), {
      status: 200,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  } catch (err: any) {
    console.error("Edge Function Exception:", err.message);
    return new Response(
      JSON.stringify({ error: err.message || "Failed to generate quiz." }),
      { status: 500, headers: { ...corsHeaders, "Content-Type": "application/json" } }
    );
  }
});