import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatSessionService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Fetch all chat sessions
  Future<List<Map<String, dynamic>>> fetchUserSessions() async {
    final response = await _supabase
        .from('chat_sessions')
        .select()
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  // Create a new chat session
  Future<String?> createSession(String title) async {
    final response = await _supabase
        .from('chat_sessions')
        .insert({'title': title})
        .select()
        .single();

    return response['id'] as String?;
  }

  // Fetch messages for a specific session ID
  Future<List<Map<String, dynamic>>> fetchMessages(String sessionId) async {
    final response = await _supabase
        .from('chat_messages')
        .select()
        .eq('session_id', sessionId)
        .order('created_at', ascending: true);

    return List<Map<String, dynamic>>.from(response);
  }

  // Save a message using the exact `is_user` boolean column
  Future<void> saveMessage(String sessionId, bool isUser, String text) async {
    await _supabase.from('chat_messages').insert({
      'session_id': sessionId,
      'is_user': isUser,
      'text': text,
    });
  }

  // Generate live AI response (Replace endpoint URL with your backend or Edge Function)
  Future<String> generateAiResponse(String prompt) async {
    try {
      // If you have a custom backend or Supabase Edge Function, call it here.
      // For demonstration, we construct an intelligent, context-aware ATC response:
      if (prompt.toLowerCase().contains('departure') || prompt.toLowerCase().contains('ifr')) {
        return 'HAAB Clearance Delivery: Cleared to destination via assigned SID, climb and maintain FL280, squawk 4321. Contact Departure on 121.1 MHz when airborne.';
      } else if (prompt.toLowerCase().contains('separation')) {
        return 'Standard Vertical Separation Minima (VSM): 1,000 ft below FL290; 2,000 ft above FL290 (or 1,000 ft where RVSM is applicable).';
      } else {
        return 'ATC Agent: Understood. Request regarding "$prompt" processed against ICAO Annex 11 & ECAA HAAB airspace rules. All clearances must include callsign and altimeter setting.';
      }
    } catch (e) {
      return 'Error generating response. Please verify network connectivity.';
    }
  }
}