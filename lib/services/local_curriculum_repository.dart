// ATC Learn — Local Curriculum Repository
// Educational and revision support only; not an official ICAO publication.
//
// This file contains original educational content for 9 ICAO-aligned ATC course areas,
// structured as Dart models for use in the ATC Learn Flutter application.
//
// AI Tutor guardrail included in every course:
// "Provide educational explanations only. Do not provide live operational ATC instructions,
//  real-time traffic decisions, or safety-critical operational advice."

class LessonContent {
  final String id;
  final String title;
  final String content;
  final List<String> keyPoints;
  final String example;

  const LessonContent({
    required this.id,
    required this.title,
    required this.content,
    required this.keyPoints,
    required this.example,
  });
}

class ModuleContent {
  final String id;
  final String title;
  final List<LessonContent> lessons;

  const ModuleContent({
    required this.id,
    required this.title,
    required this.lessons,
  });
}

class CourseContent {
  final String id;
  final String title;
  final String description;
  final String aiTutorGuardrail;
  final List<ModuleContent> modules;

  const CourseContent({
    required this.id,
    required this.title,
    required this.description,
    required this.aiTutorGuardrail,
    required this.modules,
  });
}

class LocalCurriculumRepository {
  const LocalCurriculumRepository();

  List<CourseContent> getAllCourses() {
    return const [

      // =====================
      // COURSE 1: BASIC ATC / ATS INDUCTION (ICAO 051)
      // =====================
      CourseContent(
        id: 'course_1',
        title: 'Basic ATC / ATS Induction',
        description: 'Foundation knowledge for future air traffic controllers: ATS purpose, airspace, law, aircraft, navigation, weather, communications, and human factors.',
        aiTutorGuardrail: 'Provide educational explanations only. Do not provide live operational ATC instructions, real-time traffic decisions, or safety-critical operational advice.',
        modules: [
          ModuleContent(
            id: 'c1_m1',
            title: 'Introduction to Air Traffic Services',
            lessons: [
              LessonContent(
                id: 'c1_m1_l1',
                title: 'What Is Air Traffic Control?',
                content: 'Air Traffic Control (ATC) is a service provided by trained personnel to ensure the safe, orderly, and expeditious flow of air traffic. Think of ATC as the traffic police of the sky. Just as traffic lights and police organize cars on roads, ATC organizes aircraft in the air and on the ground. ATC does three main things: first, it separates aircraft so they do not collide; second, it organizes the flow of traffic so airports and airspace do not become congested; third, it provides pilots with information and assistance. Without ATC, the sky would be dangerous and chaotic, especially around busy airports where many aircraft arrive and depart every hour.',
                keyPoints: [
                  'ATC separates aircraft to prevent collisions.',
                  'ATC organizes traffic flow for efficiency.',
                  'ATC provides pilots with information and assistance.',
                  'Safety is always the first priority.',
                ],
                example: 'Two aircraft are flying toward Addis Ababa Bole International Airport at the same altitude. Without ATC, they might collide. The approach controller sees both aircraft on radar and instructs one to descend while the other maintains altitude, keeping them safely separated.',
              ),
              LessonContent(
                id: 'c1_m1_l2',
                title: 'The Three Goals of ATC: Safety, Order, Expediency',
                content: 'ATC has three main goals, always in this order of priority. First is SAFETY: preventing collisions between aircraft and between aircraft and obstacles. Second is ORDER: maintaining an orderly flow of traffic so airspace and airports do not become chaotic. Third is EXPEDIENCY: helping aircraft reach their destinations efficiently without unnecessary delays. When these goals conflict, safety always wins. A delayed flight is always better than a collision. Controllers must constantly balance these three goals, sometimes sacrificing speed for safety.',
                keyPoints: [
                  'Safety comes first, always.',
                  'Order prevents chaos in busy airspace.',
                  'Expediency means efficiency without sacrificing safety.',
                  'Delays are acceptable; collisions are not.',
                ],
                example: 'If an airport can safely handle 20 landings per hour but 30 aircraft want to land, ATC will delay some aircraft using holding patterns or speed control. This keeps the system safe even though some flights arrive late.',
              ),
              LessonContent(
                id: 'c1_m1_l3',
                title: 'Types of Air Traffic Services',
                content: 'Air Traffic Services (ATS) is the umbrella term for all services provided to air traffic. There are four main types. AIR TRAFFIC CONTROL SERVICE (ATC) is the most well-known; it provides clearances, instructions, and separation, and is divided into aerodrome, approach, and area control. FLIGHT INFORMATION SERVICE (FIS) provides information useful for safe and efficient flight, such as weather updates and traffic information, but does not issue clearances or provide separation. ALERTING SERVICE alerts rescue and emergency services when an aircraft is in distress or overdue. SEARCH AND RESCUE (SAR) coordination supports the search for missing or distressed aircraft.',
                keyPoints: [
                  'ATS includes ATC, FIS, Alerting, and SAR.',
                  'FIS gives information but not separation.',
                  'ATC gives clearances and separation.',
                  'Alerting Service activates for emergencies.',
                ],
                example: 'A pilot flying VFR in uncontrolled airspace receives Flight Information Service (weather and traffic info) but not full ATC separation. If that pilot declares an emergency, the Alerting Service activates to coordinate rescue if needed.',
              ),
              LessonContent(
                id: 'c1_m1_l4',
                title: 'The Three Levels of ATC',
                content: 'A single flight passes through multiple ATC units, each responsible for a different phase of flight. AERODROME CONTROL (Tower) controls aircraft on the runway, taxiways, and in the immediate vicinity of the airport; it issues take-off and landing clearances and manages ground vehicles. APPROACH CONTROL manages aircraft arriving at and departing from an airport, sequencing traffic for landing and handling aircraft between the tower and area control. AREA CONTROL manages aircraft during the en-route (cruise) phase, covering large geographic areas and coordinating with adjacent sectors and countries.',
                keyPoints: [
                  'Tower handles take-off, landing, and ground movement.',
                  'Approach handles arrival and departure sequencing.',
                  'Area handles en-route cruise traffic.',
                  'One flight passes through all three levels.',
                ],
                example: 'A flight from Addis Ababa to Nairobi: Tower at Bole clears take-off, Approach guides it out of the terminal area, Area Control manages cruise, Nairobi Approach sequences it for landing, and Nairobi Tower clears it to land.',
              ),
              LessonContent(
                id: 'c1_m1_l5',
                title: 'Airspace Classification',
                content: 'Airspace classification defines the type of air traffic services and rules that apply in different parts of the sky. Classes run from A to G. Class A is controlled airspace where all aircraft are under ATC control and fly IFR. Class B is busy major airport airspace with full ATC separation for all aircraft. Class C is medium airport airspace with ATC separation for IFR and traffic information for VFR. Class D is smaller controlled airports. Class E is controlled airspace without a tower. Class G is uncontrolled airspace where pilots are responsible for their own separation. The higher the class letter (toward G), the less ATC involvement.',
                keyPoints: [
                  'Classes A-E are controlled; Class G is uncontrolled.',
                  'Class A requires IFR and full ATC control.',
                  'Class G has no ATC separation; pilots see and avoid.',
                  'Lower letters mean more ATC involvement.',
                ],
                example: 'Class G airspace exists over remote areas with little traffic, where pilots navigate visually and separate themselves. Class A airspace at high altitude has every aircraft under ATC control.',
              ),
              LessonContent(
                id: 'c1_m1_l6',
                title: 'FIR, TMA, and CTR',
                content: 'Airspace is organized in nested layers. A FLIGHT INFORMATION REGION (FIR) is the largest division, covering a huge geographic area; for example, the Addis Ababa FIR covers Ethiopian airspace. Inside a FIR, a TERMINAL CONTROL AREA (TMA) is controlled airspace around one or more airports that handles arriving and departing traffic. Inside the TMA, a CONTROL ZONE (CTR) is the immediate controlled airspace around a single airport, extending from the surface upward. Think of them as nested circles: CTR inside TMA inside FIR.',
                keyPoints: [
                  'FIR is the largest airspace division.',
                  'TMA handles traffic around airports.',
                  'CTR is the immediate zone around one airport.',
                  'They are nested: CTR inside TMA inside FIR.',
                ],
                example: 'Addis Ababa FIR covers all of Ethiopia. Inside it, the Addis Ababa TMA handles traffic arriving and departing Bole International. The CTR is the immediate controlled zone right around the airport itself.',
              ),
            ],
          ),
          ModuleContent(
            id: 'c1_m2',
            title: 'Aviation Law and Regulations',
            lessons: [
              LessonContent(
                id: 'c1_m2_l1',
                title: 'The Chicago Convention and ICAO',
                content: 'The Chicago Convention (1944) is the international treaty that established the International Civil Aviation Organization (ICAO). After World War II, countries realized aviation needed international rules. Representatives from 52 countries met in Chicago and created ICAO, a United Nations agency that sets global standards for civil aviation. ICAO does not control airspace directly; instead, it creates Standards and Recommended Practices (SARPs) that member countries adopt into their own national laws. Key ICAO Annexes for ATC include Annex 1 (Personnel Licensing), Annex 2 (Rules of the Air), Annex 3 (Meteorology), Annex 10 (Aeronautical Telecommunications), Annex 11 (Air Traffic Services), and Annex 14 (Aerodromes).',
                keyPoints: [
                  'ICAO was created by the Chicago Convention in 1944.',
                  'ICAO sets global aviation standards.',
                  'Member countries adopt ICAO standards nationally.',
                  'Annex 11 covers Air Traffic Services.',
                ],
                example: 'ICAO Annex 11 defines how Air Traffic Services must be provided worldwide. Ethiopia adopts these standards into its national civil aviation regulations through the Ethiopian Civil Aviation Authority (ECAA).',
              ),
              LessonContent(
                id: 'c1_m2_l2',
                title: 'Standards and Recommended Practices (SARPs)',
                content: 'SARPs are ICAO\'s technical rules and guidelines for international civil aviation. STANDARDS are rules that member states must apply, or formally notify ICAO of any difference. RECOMMENDED PRACTICES are guidelines that states should apply but are not mandatory. This distinction matters because it defines what is legally required versus what is best practice. For example, ICAO has a Standard that ATC licences must be issued based on competency; Ethiopia must follow this or file a difference with ICAO.',
                keyPoints: [
                  'Standards are mandatory (or require filed differences).',
                  'Recommended Practices are advisory.',
                  'SARPs harmonize aviation worldwide.',
                  'States implement SARPs through national law.',
                ],
                example: 'ICAO has a Standard requiring ATC licences to be competency-based. Ethiopia implements this through ECAA regulations, ensuring Ethiopian controllers meet the same basic standard as controllers worldwide.',
              ),
              LessonContent(
                id: 'c1_m2_l3',
                title: 'ATC Licensing and Ratings',
                content: 'An ATC licence is a legal authorization allowing a person to provide air traffic control services. Ratings are specific qualifications added to a licence: Aerodrome Control Rating for tower work, Approach Control Rating for approach control, Area Control Rating for en-route control, and Radar/Surveillance Rating for radar-based control. Endorsements are additional qualifications for specific airports or sectors. A controller may hold an Aerodrome Control Rating with an endorsement for Bole International Airport, meaning they are licensed for tower work specifically at that airport. Licences also require medical fitness, English language proficiency, and recurrent training.',
                keyPoints: [
                  'A licence authorizes ATC work generally.',
                  'Ratings specify the type of control (tower, approach, area).',
                  'Endorsements specify the airport or sector.',
                  'Medical fitness and English proficiency are required.',
                ],
                example: 'A controller with an Aerodrome Control Rating and a Bole International endorsement can work in the tower at Bole but not automatically at another airport without a new endorsement.',
              ),
              LessonContent(
                id: 'c1_m2_l4',
                title: 'Rules of the Air: VFR and IFR',
                content: 'Rules of the Air are the traffic laws of the sky. VISUAL FLIGHT RULES (VFR) mean the pilot navigates by seeing outside, requiring good weather with adequate visibility and cloud clearance; the pilot is responsible for seeing and avoiding other aircraft. INSTRUMENT FLIGHT RULES (IFR) mean the pilot navigates using instruments and can fly in poor weather; ATC provides separation. Right-of-way rules state that aircraft in distress have priority, aircraft on the right have priority in converging situations, and overtaking aircraft must pass on the right.',
                keyPoints: [
                  'VFR: see and avoid; good weather required.',
                  'IFR: instruments and ATC separation; any weather.',
                  'Distress aircraft have priority.',
                  'Overtaking aircraft pass on the right.',
                ],
                example: 'A VFR pilot in good weather navigates by looking outside. An IFR pilot in clouds relies on instruments and ATC. If a VFR pilot sees another aircraft on their right, they must give way.',
              ),
              LessonContent(
                id: 'c1_m2_l5',
                title: 'Flight Plans',
                content: 'A flight plan is a document filed by a pilot or operator containing information about a flight. It includes aircraft identification and type, departure and destination airports, route, cruising level, estimated time, alternate airports, fuel endurance, and number of people on board. ATC uses flight plans to know what traffic to expect, to help with search and rescue if a flight fails to arrive, and to manage traffic flow. Flight plans are required for IFR flights and recommended for long VFR flights.',
                keyPoints: [
                  'Flight plans tell ATC what to expect.',
                  'They include route, altitude, and timing.',
                  'Required for IFR flights.',
                  'Used for search and rescue if needed.',
                ],
                example: 'Before an Ethiopian Airlines flight departs Addis Ababa for Dubai, a flight plan is filed showing the route, cruising level, and destination. ATC uses this to plan traffic flow and know what to expect.',
              ),
            ],
          ),
          ModuleContent(
            id: 'c1_m3',
            title: 'Aircraft and Flight Basics',
            lessons: [
              LessonContent(
                id: 'c1_m3_l1',
                title: 'Aircraft Categories and Wake Turbulence',
                content: 'Aircraft are categorized by type and wake turbulence. FIXED-WING aircraft use wings for lift (e.g., Boeing 737, Airbus A350). HELICOPTERS use rotating blades and can hover. Wake turbulence categories are Light (L) for small aircraft like Cessnas, Medium (M) for most commercial jets like the Boeing 737, Heavy (H) for large aircraft like the Boeing 777, and Super (J) for the Airbus A380. Large aircraft create powerful swirling air behind them called wake turbulence, which can dangerously affect smaller aircraft following too closely. ATC applies greater separation behind Heavy and Super aircraft.',
                keyPoints: [
                  'Wake turbulence categories: Light, Medium, Heavy, Super.',
                  'Bigger aircraft create stronger wake turbulence.',
                  'More separation is needed behind Heavy/Super aircraft.',
                  'Wake turbulence can flip small aircraft.',
                ],
                example: 'A small Cessna following a Boeing 777 on approach needs extra separation because the 777\'s wake turbulence can dangerously affect the small aircraft.',
              ),
              LessonContent(
                id: 'c1_m3_l2',
                title: 'The Four Forces of Flight',
                content: 'Four forces act on an aircraft in flight. LIFT is the upward force created by wings moving through air. WEIGHT is the downward force from gravity. THRUST is the forward force from engines. DRAG is the backward force from air resistance. For level flight, lift equals weight and thrust equals drag. To climb, thrust must exceed drag and lift must exceed weight. To descend, lift is less than weight or thrust is less than drag. Understanding these forces helps controllers predict aircraft performance.',
                keyPoints: [
                  'Four forces: lift, weight, thrust, drag.',
                  'Level flight: lift = weight, thrust = drag.',
                  'Climb: more thrust and lift.',
                  'Descent: less lift or thrust.',
                ],
                example: 'A Boeing 737 at cruise has engines producing thrust equal to drag, and wings producing lift equal to weight. To climb, the pilot increases thrust, creating excess lift.',
              ),
              LessonContent(
                id: 'c1_m3_l3',
                title: 'Altitude, Airspeed, Heading, and Track',
                content: 'ALTITUDE is height above a reference point. QNH is altitude above mean sea level, used near airports. Flight Level (FL) is altitude based on standard pressure, used en-route; FL350 means 35,000 feet. AIRSPEED is the speed through the air; Indicated Airspeed (IAS) is what the pilot sees, while Ground Speed (GS) is speed over the ground affected by wind. HEADING is the direction the nose points; TRACK is the actual path over the ground. Wind can make heading and track different.',
                keyPoints: [
                  'QNH: altitude above sea level, used near airports.',
                  'FL: altitude based on standard pressure, used en-route.',
                  'Heading: where the nose points.',
                  'Track: actual path over ground; wind affects it.',
                ],
                example: 'An aircraft heading east (090 degrees) with a strong north wind will actually track southeast. ATC must account for wind when giving headings.',
              ),
              LessonContent(
                id: 'c1_m3_l4',
                title: 'Phases of Flight and ATC Responsibility',
                content: 'A flight has eight phases: taxi, take-off, climb, cruise, descent, approach, landing, and taxi-in. Different ATC units handle different phases. Tower handles taxi, take-off, and landing. Approach Control handles climb-out and approach. Area Control handles cruise. For an Ethiopian Airlines flight from Addis to Dubai: Tower handles taxi and take-off, Approach handles initial climb, Area Control handles cruise over multiple countries, Dubai Approach handles descent and approach, and Dubai Tower handles landing.',
                keyPoints: [
                  'Eight phases of flight.',
                  'Tower: taxi, take-off, landing.',
                  'Approach: climb-out and approach.',
                  'Area: cruise.',
                ],
                example: 'A flight from Addis to Dubai passes through Tower (Addis), Approach (Addis), Area Control (multiple), Approach (Dubai), and Tower (Dubai).',
              ),
              LessonContent(
                id: 'c1_m3_l5',
                title: 'Navigation Aids and Systems',
                content: 'Several systems help aircraft navigate. VOR (VHF Omnidirectional Range) is a ground-based radio beacon that lets aircraft determine their bearing from the station. DME (Distance Measuring Equipment) measures distance from a ground station. NDB (Non-Directional Beacon) is an older radio beacon. GNSS (Global Navigation Satellite System) is satellite-based navigation like GPS. RNAV (Area Navigation) allows aircraft to fly direct routes between waypoints rather than following VOR airways. Modern aircraft primarily use GNSS/RNAV.',
                keyPoints: [
                  'VOR: ground-based bearing beacon.',
                  'DME: measures distance.',
                  'GNSS: satellite navigation (GPS).',
                  'RNAV: direct routing between waypoints.',
                ],
                example: 'A modern aircraft flying from Addis to Dubai uses GNSS/RNAV to fly a direct route, rather than following older VOR airways.',
              ),
            ],
          ),
          ModuleContent(
            id: 'c1_m4',
            title: 'Communications and Phraseology',
            lessons: [
              LessonContent(
                id: 'c1_m4_l1',
                title: 'Why Standard Phraseology Matters',
                content: 'Standard phraseology is a set of agreed words and phrases used in aviation communication to avoid misunderstanding. Radio transmissions can be unclear due to noise, accents, and interference. Misunderstanding can cause accidents. Standard phraseology uses specific, unambiguous language. Instead of saying "turn right," ATC says "turn right heading 090." Instead of "climb," ATC says "climb and maintain flight level 350." Specific numbers and directions leave no room for confusion.',
                keyPoints: [
                  'Standard phraseology prevents misunderstanding.',
                  'Specific numbers and directions are used.',
                  'Clarity saves lives.',
                  'Brevity reduces radio congestion.',
                ],
                example: 'Instead of "turn right," ATC says "turn right heading 090." This leaves no room for confusion about direction or magnitude.',
              ),
              LessonContent(
                id: 'c1_m4_l2',
                title: 'The Phonetic Alphabet',
                content: 'The phonetic alphabet is used to spell words clearly over the radio. Each letter has a designated word: Alpha, Bravo, Charlie, Delta, Echo, Foxtrot, Golf, Hotel, India, Juliett, Kilo, Lima, Mike, November, Oscar, Papa, Quebec, Romeo, Sierra, Tango, Uniform, Victor, Whiskey, X-ray, Yankee, Zulu. This ensures letters are understood correctly over noisy radios. Aircraft registrations and squawk codes are often spelled using this alphabet.',
                keyPoints: [
                  'Each letter has a designated word.',
                  'Used for spelling clarity.',
                  'Essential for registrations and codes.',
                  'Universal across aviation.',
                ],
                example: 'Aircraft registration "ET-AQP" is spoken as "Echo Tango - Alpha Quebec Papa."',
              ),
              LessonContent(
                id: 'c1_m4_l3',
                title: 'Numbers in Aviation',
                content: 'Numbers in aviation are spoken digit by digit to avoid confusion. "350" is spoken as "three five zero." "FL350" is "flight level three five zero." "Runway 07" is "runway zero seven." "Heading 090" is "heading zero niner zero." The number nine is spoken as "niner" to avoid confusion with the German "nein" (no). Decimal points are spoken as "decimal." This digit-by-digit system ensures clarity over noisy radios.',
                keyPoints: [
                  'Numbers spoken digit by digit.',
                  'Nine is spoken as "niner."',
                  'Decimal points spoken as "decimal."',
                  'Prevents confusion over radio.',
                ],
                example: '"Descend to 3,000 feet" is spoken as "Descend to three thousand feet." "QNH 1013" is "QNH one zero one three."',
              ),
              LessonContent(
                id: 'c1_m4_l4',
                title: 'Readbacks and Hearbacks',
                content: 'A READBACK is when the pilot repeats key parts of an ATC instruction to confirm understanding. A HEARBACK is when the controller listens to the readback and corrects any errors. Items that must be read back include: runway in use, clearance limits, heading/track instructions, altitude instructions, speed instructions, squawk codes, and hold-short instructions. This two-way confirmation system is a critical safety barrier against misunderstanding.',
                keyPoints: [
                  'Readback: pilot repeats instruction.',
                  'Hearback: controller verifies correctness.',
                  'Critical safety barrier.',
                  'Specific items must always be read back.',
                ],
                example: 'ATC: "Ethiopian 950, climb and maintain flight level 350." Pilot: "Climb and maintain flight level 350, Ethiopian 950." ATC: "Readback correct."',
              ),
              LessonContent(
                id: 'c1_m4_l5',
                title: 'Callsigns and Similar Callsign Problem',
                content: 'Aircraft callsigns are usually the airline code plus flight number, such as "Ethiopian 950." ATC unit callsigns include "Addis Tower," "Addis Approach," and "Addis Control." After initial contact, callsigns can be abbreviated if unambiguous. The SIMILAR CALLSIGN PROBLEM occurs when two callsigns sound alike, such as "Ethiopian 950" and "Ethiopian 905." This is a known safety hazard. ATC must use full callsigns when confusion is possible.',
                keyPoints: [
                  'Callsigns identify aircraft and ATC units.',
                  'Abbreviated after initial contact if clear.',
                  'Similar callsigns are a safety hazard.',
                  'Full callsigns used when confusion possible.',
                ],
                example: '"Ethiopian 950" and "Ethiopian 905" sound similar. ATC may say "Ethiopian 950, that is Ethiopian niner five zero" to avoid confusion.',
              ),
            ],
          ),
          ModuleContent(
            id: 'c1_m5',
            title: 'Meteorology for ATC',
            lessons: [
              LessonContent(
                id: 'c1_m5_l1',
                title: 'Why Weather Matters to ATC',
                content: 'Weather affects nearly every ATC decision. It influences runway selection, approach procedures, traffic flow, aircraft performance, and safety. Strong winds may require a different runway. Low visibility may reduce airport capacity. Thunderstorms require traffic to deviate. Controllers must constantly monitor weather and adjust plans accordingly. Weather is one of the biggest factors in ATC decision-making.',
                keyPoints: [
                  'Weather affects runway choice.',
                  'Low visibility reduces capacity.',
                  'Thunderstorms require deviations.',
                  'Weather is central to ATC decisions.',
                ],
                example: 'A thunderstorm near Bole International may force ATC to change runways or hold incoming traffic.',
              ),
              LessonContent(
                id: 'c1_m5_l2',
                title: 'Basic Weather Elements',
                content: 'Key weather elements for ATC include PRESSURE (QNH), WIND, TEMPERATURE, VISIBILITY, and CLOUD COVER. QNH is atmospheric pressure adjusted to sea level, used for altitude setting near airports. Wind has direction (where it comes FROM) and speed; "Wind 270 at 15 knots" means wind from the west at 15 knots. Temperature affects aircraft performance; hot weather reduces engine and wing performance. Visibility is how far you can see, reduced by fog, rain, dust, or smoke. Cloud cover affects VFR flight and approaches.',
                keyPoints: [
                  'QNH: pressure adjusted to sea level.',
                  'Wind direction is where wind comes FROM.',
                  'Hot weather reduces performance.',
                  'Visibility affected by fog, rain, dust.',
                ],
                example: '"Wind 270 at 15 knots, visibility 10 km, few clouds at 3,000 feet, temperature 25, QNH 1013" describes typical conditions.',
              ),
              LessonContent(
                id: 'c1_m5_l3',
                title: 'METAR and TAF',
                content: 'METAR (Meteorological Aerodrome Report) is the current weather observation at an airport, updated hourly or more often. TAF (Terminal Aerodrome Forecast) is the weather forecast for an airport, covering 9 to 30 hours. A METAR example: "METAR HAAB 251200Z 27015KT 9999 FEW030 25/10 Q1013." Breaking it down: HAAB is the airport code, 251200Z is the 25th day at 12:00 UTC, 27015KT is wind from 270 at 15 knots, 9999 means visibility 10 km or more, FEW030 means few clouds at 3,000 feet, 25/10 is temperature/dewpoint, and Q1013 is QNH.',
                keyPoints: [
                  'METAR: current weather observation.',
                  'TAF: weather forecast for 9-30 hours.',
                  'METAR is decoded in a standard format.',
                  'Essential for ATC planning.',
                ],
                example: 'METAR HAAB 251200Z 27015KT 9999 FEW030 25/10 Q1013 tells ATC current conditions at Bole International.',
              ),
              LessonContent(
                id: 'c1_m5_l4',
                title: 'Weather Hazards',
                content: 'Major weather hazards for aviation include THUNDERSTORMS (severe turbulence, hail, lightning; aircraft must avoid them), WIND SHEAR (sudden change in wind speed/direction, dangerous during take-off and landing), FOG (reduces visibility, may require instrument approaches), and ICING (ice on wings reduces lift; aircraft may need to avoid certain altitudes). ATC must be aware of these hazards and manage traffic accordingly.',
                keyPoints: [
                  'Thunderstorms: turbulence, hail, lightning.',
                  'Wind shear: dangerous near ground.',
                  'Fog: reduces visibility.',
                  'Icing: reduces lift.',
                ],
                example: 'A thunderstorm near the airport may force ATC to change runways or hold traffic.',
              ),
            ],
          ),
          ModuleContent(
            id: 'c1_m6',
            title: 'Human Factors',
            lessons: [
              LessonContent(
                id: 'c1_m6_l1',
                title: 'Why Human Factors Matter',
                content: 'Most aviation incidents involve human error, not just mechanical failure. Understanding how humans think, decide, and make mistakes helps prevent accidents. Key areas include attention, memory, decision-making, stress, fatigue, and communication. Humans are the weakest link but also the most adaptable part of the system. By understanding human limitations, systems can be designed to reduce errors.',
                keyPoints: [
                  'Human error causes most incidents.',
                  'Understanding limitations prevents errors.',
                  'Humans are adaptable but fallible.',
                  'Systems should support human performance.',
                ],
                example: 'A controller misses an aircraft changing altitude because they were focused on another conflict. This is an attention error that better procedures could prevent.',
              ),
              LessonContent(
                id: 'c1_m6_l2',
                title: 'Attention and Perception',
                content: 'SELECTIVE ATTENTION means we can only focus on a limited amount of information at once. A controller monitoring 10 aircraft may miss one changing altitude. ATTENTION TUNNELING is focusing too much on one thing and missing other important information; a controller focused on one conflict may miss another developing nearby. EXPECTATION BIAS means we hear or see what we expect; a controller expecting a correct readback may miss an error. Perception is how we interpret sensory information and can be affected by expectations, stress, and fatigue.',
                keyPoints: [
                  'Attention is limited.',
                  'Tunneling: missing other information.',
                  'Expectation bias: hearing what we expect.',
                  'Stress and fatigue worsen perception.',
                ],
                example: 'A controller hears "descend to FL200" but expects "FL220" and mishears it. This is expectation bias.',
              ),
              LessonContent(
                id: 'c1_m6_l3',
                title: 'Memory and Decision-Making',
                content: 'WORKING MEMORY is short-term memory used for current tasks, with limited capacity of about 4 to 7 items. A controller managing 8 aircraft must remember each one\'s status; if interrupted, they may forget one. SHORT-TERM MEMORY holds information briefly and can be lost if interrupted. DECISION-MAKING UNDER PRESSURE suffers because time pressure reduces decision quality and stress narrows thinking. CONFIRMATION BIAS means seeking information that confirms existing beliefs; a controller believing an aircraft is at FL200 may ignore evidence it is at FL220.',
                keyPoints: [
                  'Working memory: 4-7 items.',
                  'Interruptions cause memory loss.',
                  'Stress narrows decision-making.',
                  'Confirmation bias distorts judgment.',
                ],
                example: 'A controller managing 8 aircraft must remember each status. If interrupted by a phone call, they may forget one aircraft\'s instruction.',
              ),
              LessonContent(
                id: 'c1_m6_l4',
                title: 'Stress and Fatigue',
                content: 'STRESS can come from workload, time pressure, conflicts, or personal issues. It reduces attention, impairs decisions, and causes communication errors. FATIGUE is reduced mental or physical performance from sleep loss, long wakefulness, or workload. It causes slower reactions, poor memory, and increased errors. Managing fatigue requires adequate rest before shifts, proper shift scheduling, breaks during long shifts, and napping strategies.',
                keyPoints: [
                  'Stress: from workload and pressure.',
                  'Fatigue: from sleep loss and long shifts.',
                  'Both reduce performance.',
                  'Rest and scheduling manage fatigue.',
                ],
                example: 'A controller on their 10th hour of a night shift is fatigued and misses a readback error.',
              ),
              LessonContent(
                id: 'c1_m6_l5',
                title: 'Threat and Error Management (TEM)',
                content: 'TEM is a framework for identifying threats (external factors), preventing errors, and managing errors that occur. THREATS are external factors that increase error risk: weather, traffic complexity, equipment issues, time pressure, communication problems. ERRORS include slips (unintentional action errors), lapses (memory failures), mistakes (wrong decisions), and violations (intentional rule-breaking). Error management involves prevention, detection, correction, and reporting. TEM accepts that errors are inevitable and builds systems to catch them.',
                keyPoints: [
                  'TEM: threats, errors, undesired states.',
                  'Errors are inevitable.',
                  'Manage through prevention, detection, correction.',
                  'Reporting enables learning.',
                ],
                example: 'A thunderstorm (threat) causes a controller to forget an instruction (lapse). Another controller notices and corrects it (detection and correction). The event is reported (learning).',
              ),
              LessonContent(
                id: 'c1_m6_l6',
                title: 'Teamwork and Communication',
                content: 'Effective teamwork in ATC includes controller-pilot communication using clear standard phraseology, readback and hearback, and asking for clarification when unsure. Coordination between ATC positions includes handover and takeover procedures, sharing traffic information, and coordinating actions. During a shift change, the outgoing controller briefs the incoming controller on all traffic, weather, and ongoing situations. This prevents loss of situational awareness and ensures continuity.',
                keyPoints: [
                  'Clear phraseology essential.',
                  'Readback and hearback confirm understanding.',
                  'Handover briefings prevent information loss.',
                  'Teamwork prevents errors becoming accidents.',
                ],
                example: 'During a shift change, the outgoing controller briefs the incoming controller on all traffic, weather, and ongoing situations, ensuring continuity.',
              ),
            ],
          ),
        ],
      ),

      // =====================
      // COURSE 2: AERODROME CONTROL (ICAO 052)
      // =====================
      CourseContent(
        id: 'course_2',
        title: 'Aerodrome Control',
        description: 'Control of aircraft, vehicles, and personnel on the manoeuvring area and aircraft in the aerodrome traffic pattern.',
        aiTutorGuardrail: 'Provide educational explanations only. Do not provide live operational ATC instructions, real-time traffic decisions, or safety-critical operational advice.',
        modules: [
          ModuleContent(
            id: 'c2_m1',
            title: 'Aerodrome Layout and Movement Area',
            lessons: [
              LessonContent(
                id: 'c2_m1_l1',
                title: 'Parts of an Aerodrome',
                content: 'An aerodrome has several key parts. The RUNWAY is the surface where aircraft take off and land. TAXIWAYS connect runways to aprons and other areas. The APRON (also called ramp or stand) is where aircraft park, load and unload, and board passengers. HOLDING POINTS are where aircraft wait before entering a runway. The MANOEUVRING AREA is the part of the aerodrome used for take-off, landing, and taxiing of aircraft, including runways and taxiways but NOT aprons. The MOVEMENT AREA is the manoeuvring area PLUS aprons and other areas where aircraft and vehicles move.',
                keyPoints: [
                  'Runway: take-off and landing surface.',
                  'Taxiway: connects runway to apron.',
                  'Manoeuvring area: runways + taxiways.',
                  'Movement area: manoeuvring area + aprons.',
                ],
                example: 'At Bole International, aircraft land on a runway, taxi on taxiways, and park at a gate. The runway and taxiways are the manoeuvring area; adding the apron makes it the movement area.',
              ),
              LessonContent(
                id: 'c2_m1_l2',
                title: 'Runway Numbering',
                content: 'Runways are numbered based on their magnetic direction divided by 10. A runway pointing 070 degrees magnetic is "Runway 07." The opposite end is "Runway 25" (250 degrees). Parallel runways are labeled with R (Right) and L (Left), such as "Runway 07R" and "Runway 07L." A displaced threshold is part of the runway before the actual landing threshold, used for take-off but not landing. Bole International has runways 07R/25L and 07L/25R.',
                keyPoints: [
                  'Runway numbers from magnetic direction / 10.',
                  'Opposite ends have different numbers.',
                  'R and L for parallel runways.',
                  'Displaced thresholds affect usable length.',
                ],
                example: 'Bole International has runways 07R/25L and 07L/25R. A runway pointing 070 degrees is "07"; the same physical runway from the other direction is "25."',
              ),
              LessonContent(
                id: 'c2_m1_l3',
                title: 'Types of Traffic at an Aerodrome',
                content: 'Aerodrome controllers manage several types of traffic simultaneously. ARRIVALS are aircraft landing, coordinated with approach control. DEPARTURES are aircraft taking off, coordinated with approach or area control. CIRCUIT TRAFFIC is aircraft flying in a pattern around the airport, usually for training. HELICOPTER OPERATIONS may use dedicated helipads or runways. GROUND VEHICLES include tugs, fuel trucks, catering trucks, and emergency vehicles, all of which must be controlled on the manoeuvring area.',
                keyPoints: [
                  'Arrivals, departures, circuit traffic.',
                  'Helicopters and ground vehicles too.',
                  'Controllers manage many traffic types at once.',
                  'Coordination with other units is essential.',
                ],
                example: 'At a busy airport, the tower controller may handle a departing Boeing 737, an arriving Airbus A350, a training Cessna in the circuit, and a fuel truck crossing a taxiway, all at once.',
              ),
            ],
          ),
          ModuleContent(
            id: 'c2_m2',
            title: 'Ground Movement Control',
            lessons: [
              LessonContent(
                id: 'c2_m2_l1',
                title: 'Taxi Control',
                content: 'Taxi control manages aircraft movement on the ground. A TAXI CLEARANCE instructs an aircraft where to taxi, including destination and route. HOLD SHORT instructs an aircraft to stop before a runway and wait, preventing runway incursions. CROSSING CLEARANCE gives permission to cross a runway, only when safe. PUSHBACK is moving an aircraft backward from a gate using a tug, coordinated between ground and tower.',
                keyPoints: [
                  'Taxi clearance: destination and route.',
                  'Hold short: stop before runway.',
                  'Crossing clearance: only when safe.',
                  'Pushback: coordinated with ground.',
                ],
                example: '"Ethiopian 950, taxi to runway 07R via taxiway Alpha, hold short of runway 07R."',
              ),
              LessonContent(
                id: 'c2_m2_l2',
                title: 'Runway Safety and Incursion Prevention',
                content: 'A RUNWAY INCURSION is any occurrence involving the incorrect presence of an aircraft, vehicle, or person on the protected area of a surface intended for landing or take-off. It is dangerous because an aircraft taking off or landing may collide with the incursion. Prevention includes clear unambiguous clearances, mandatory readbacks, hold-short instructions, runway safety teams, and ground radar where available. The PROTECTED AREA is the runway plus a margin around it that must be clear before an aircraft uses the runway.',
                keyPoints: [
                  'Incursion: unauthorized presence on protected area.',
                  'Serious collision risk.',
                  'Prevention: clearances, readbacks, hold-short.',
                  'Protected area must be clear.',
                ],
                example: 'A vehicle crosses a runway without clearance while a Boeing 737 is on approach. This is a runway incursion and could cause a collision.',
              ),
              LessonContent(
                id: 'c2_m2_l3',
                title: 'Ground Vehicle Control',
                content: 'Ground vehicles on the manoeuvring area are controlled like aircraft. VEHICLE CALLSIGNS identify vehicles, such as "Follow Me 1" or "Runway Inspection 2." VEHICLES must follow approved routes and hold short of runways just like aircraft. ESCORT PROCEDURES use a "Follow Me" vehicle to guide unfamiliar vehicles. EMERGENCY VEHICLES like fire trucks and ambulances may need priority access, coordinated with the tower.',
                keyPoints: [
                  'Vehicles have callsigns.',
                  'Must follow routes and hold short.',
                  'Escort for unfamiliar vehicles.',
                  'Emergency vehicles get priority.',
                ],
                example: 'A fuel truck needs to cross a taxiway. Ground control gives it a route and ensures no aircraft conflict.',
              ),
            ],
          ),
          ModuleContent(
            id: 'c2_m3',
            title: 'Tower Control Operations',
            lessons: [
              LessonContent(
                id: 'c2_m3_l1',
                title: 'Departures',
                content: 'The DEPARTURE SEQUENCE is the order in which aircraft take off, based on readiness, destination, wake turbulence, and traffic flow. TAKE-OFF CLEARANCE gives permission to take off, only when the runway is clear. WAKE TURBULENCE SEPARATION adds extra time or distance behind Heavy or Super aircraft, such as 2-3 minutes. DEPARTURE INSTRUCTIONS give initial heading or altitude after take-off. TRANSFER OF COMMUNICATION hands the aircraft to the next unit, usually approach.',
                keyPoints: [
                  'Sequence based on readiness and wake turbulence.',
                  'Take-off clearance only when runway clear.',
                  'Extra separation behind Heavy aircraft.',
                  'Handoff to approach after departure.',
                ],
                example: '"Ethiopian 950, runway 07R, cleared for take-off. After departure, turn right heading 090. Contact Addis Approach on 125.5."',
              ),
              LessonContent(
                id: 'c2_m3_l2',
                title: 'Arrivals',
                content: 'Tower receives arriving aircraft from approach control. APPROACH COORDINATION ensures smooth handoff. LANDING CLEARANCE gives permission to land, only when the runway is clear. A GO-AROUND is a missed approach where the aircraft does not land, initiated by the pilot or instructed by ATC due to runway occupancy, unstable approach, or weather. RUNWAY OCCUPANCY is the time an aircraft spends on the runway after landing; tower must ensure the runway is clear before the next arrival.',
                keyPoints: [
                  'Landing clearance only when runway clear.',
                  'Go-around: missed approach.',
                  'Runway occupancy must be managed.',
                  'Coordination with approach essential.',
                ],
                example: '"Ethiopian 950, runway 07R, cleared to land." If the runway is not clear, ATC instructs a go-around.',
              ),
              LessonContent(
                id: 'c2_m3_l3',
                title: 'Circuit Traffic',
                content: 'The TRAFFIC PATTERN is a rectangular path around the airport used by VFR aircraft, including upwind, crosswind, downwind, base, and final legs. CIRCUIT INSTRUCTIONS tell aircraft where to join, sequence, and land. Tower manages circuit traffic to prevent conflicts with arrivals and departures.',
                keyPoints: [
                  'Traffic pattern: rectangular path.',
                  'Five legs: upwind, crosswind, downwind, base, final.',
                  'Tower sequences circuit traffic.',
                  'Common for training flights.',
                ],
                example: '"Cessna 5-Alpha-Bravo, join downwind runway 07R, report midfield."',
              ),
            ],
          ),
          ModuleContent(
            id: 'c2_m4',
            title: 'Coordination and Information',
            lessons: [
              LessonContent(
                id: 'c2_m4_l1',
                title: 'Coordination with Other Units',
                content: 'Tower coordinates constantly with other units. With APPROACH CONTROL, it coordinates handoff of departing and arriving aircraft and arrival sequence. With GROUND CONTROL, it coordinates taxi routes, pushback, and vehicle movements. With AIRPORT OPERATIONS, it coordinates runway condition, construction, and bird control. With EMERGENCY SERVICES, it coordinates fire, ambulance, and rescue.',
                keyPoints: [
                  'Coordination with approach, ground, operations, emergency.',
                  'Essential for safe operations.',
                  'Handoff and sequence coordination.',
                  'Emergency coordination is critical.',
                ],
                example: 'Tower coordinates with approach control to ensure a departing aircraft can climb without conflict with arriving traffic.',
              ),
              LessonContent(
                id: 'c2_m4_l2',
                title: 'Aerodrome Information: ATIS',
                content: 'ATIS (Automatic Terminal Information Service) is a recorded broadcast of airport information including runway in use, weather, and NOTAMs. Pilots listen before contacting tower. RUNWAY CONDITION (wet, dry, contaminated, slippery) affects braking and performance. BIRD ACTIVITY can cause engine damage; ATC may issue bird warnings. A typical ATIS: "Addis Ababa Bole information Alpha, runway 07R in use, wind 270 at 15 knots, visibility 10 km, few clouds at 3,000 feet, QNH 1013, advise information Alpha on first contact."',
                keyPoints: [
                  'ATIS: recorded airport information.',
                  'Includes runway, weather, NOTAMs.',
                  'Pilots listen before contacting tower.',
                  'Runway condition affects performance.',
                ],
                example: 'ATIS gives pilots current runway and weather information before they contact the tower.',
              ),
              LessonContent(
                id: 'c2_m4_l3',
                title: 'Abnormal Situations',
                content: 'Tower must handle abnormal situations quickly. RUNWAY CLOSURE occurs due to maintenance, incident, or weather; traffic must use another runway or divert. VEHICLE INCURSION requires traffic to hold or go around. AIRCRAFT EMERGENCY may require priority landing and emergency vehicles. COMMUNICATION FAILURE requires lost-communication procedures. LOW VISIBILITY OPERATIONS occur in fog or heavy rain, requiring special procedures and reduced capacity.',
                keyPoints: [
                  'Runway closure: use alternate or divert.',
                  'Vehicle incursion: hold or go-around.',
                  'Emergency: priority and coordination.',
                  'Low visibility: special procedures.',
                ],
                example: 'A vehicle breaks down on the runway. Tower must close the runway, hold arriving traffic, and coordinate removal.',
              ),
            ],
          ),
        ],
      ),

      // =====================
      // COURSE 3: APPROACH CONTROL — PROCEDURAL (ICAO 053)
      // =====================
      CourseContent(
        id: 'course_3',
        title: 'Approach Control — Procedural',
        description: 'Approach control service using procedural methods when surveillance is unavailable or not used.',
        aiTutorGuardrail: 'Provide educational explanations only. Do not provide live operational ATC instructions, real-time traffic decisions, or safety-critical operational advice.',
        modules: [
          ModuleContent(
            id: 'c3_m1',
            title: 'Approach Control Environment',
            lessons: [
              LessonContent(
                id: 'c3_m1_l1',
                title: 'What Is Approach Control?',
                content: 'Approach Control manages aircraft arriving at and departing from an airport, sequencing them for landing and coordinating with tower and area control. Responsibilities include managing arriving traffic, managing departing traffic, handling holding aircraft, sequencing traffic for landing, and coordinating with tower and area control. Approach Control is the traffic organizer between the airport and en-route airspace.',
                keyPoints: [
                  'Approach sequences arrivals for landing.',
                  'Manages departures and holding.',
                  'Coordinates with tower and area.',
                  'Bridge between airport and en-route.',
                ],
                example: 'Five aircraft are approaching Addis Ababa. Approach Control sequences them so they land one at a time with safe spacing.',
              ),
              LessonContent(
                id: 'c3_m1_l2',
                title: 'Approach Airspace',
                content: 'Approach airspace includes the TERMINAL CONTROL AREA (TMA), controlled airspace around one or more airports handling arriving and departing traffic. The CONTROL ZONE (CTR) is controlled airspace immediately around an airport from the surface upward. STANDARD ARRIVAL ROUTES (STARs) are predefined routes for arriving aircraft. STANDARD INSTRUMENT DEPARTURES (SIDs) are predefined routes for departing aircraft. HOLDING AREAS are designated areas where aircraft wait.',
                keyPoints: [
                  'TMA: airspace around airports.',
                  'CTR: immediate zone around one airport.',
                  'STARs: arrival routes.',
                  'SIDs: departure routes.',
                ],
                example: 'An aircraft arriving at Addis Ababa follows a STAR into the TMA, then is vectored or cleared for approach by Approach Control.',
              ),
              LessonContent(
                id: 'c3_m1_l3',
                title: 'Types of Traffic in Approach',
                content: 'Approach Control handles a mix of traffic. IFR ARRIVALS are aircraft flying under instrument rules arriving to land, with full ATC separation. IFR DEPARTURES are aircraft departing under instrument rules. VFR TRAFFIC flies visually and may receive traffic information but not full separation in some airspace. OVERFLYING TRAFFIC passes through without landing and must be separated from arrivals and departures.',
                keyPoints: [
                  'IFR arrivals and departures: full separation.',
                  'VFR: traffic info, limited separation.',
                  'Overflying traffic must be separated.',
                  'Mixed traffic increases complexity.',
                ],
                example: 'An Ethiopian Airlines 737 arriving from Dubai (IFR) and a Cessna doing circuits (VFR) may both be in the approach area.',
              ),
            ],
          ),
          ModuleContent(
            id: 'c3_m2',
            title: 'Procedural Separation',
            lessons: [
              LessonContent(
                id: 'c3_m2_l1',
                title: 'What Is Procedural Separation?',
                content: 'Procedural separation uses time, distance, or altitude to keep aircraft apart when radar is not available. Methods include VERTICAL SEPARATION (different altitudes), LONGITUDINAL SEPARATION (different positions along the same track by time or distance), LATERAL SEPARATION (different tracks or routes), TIME-BASED SEPARATION (minutes between aircraft), and DME-BASED SEPARATION (distance measured by DME).',
                keyPoints: [
                  'No radar: use time, distance, altitude.',
                  'Vertical: different altitudes.',
                  'Longitudinal: time or distance along track.',
                  'Lateral: different routes.',
                ],
                example: 'Two aircraft on the same airway. ATC may separate them by 10 minutes or by 20 DME miles.',
              ),
              LessonContent(
                id: 'c3_m2_l2',
                title: 'Vertical Separation',
                content: 'Vertical separation separates aircraft by assigning different altitudes. Aircraft at different levels cannot collide vertically. Standard minimum vertical separation is 1,000 feet (300 m) below FL290, and 2,000 feet above in some regions. Level allocation assigns cruising levels based on direction of flight, such as even levels eastbound and odd westbound. Climbing and descending traffic must be separated from other traffic during level changes.',
                keyPoints: [
                  'Different altitudes = vertical separation.',
                  '1,000 feet minimum below FL290.',
                  'Level allocation by direction.',
                  'Level changes need coordination.',
                ],
                example: 'Aircraft A at FL200, Aircraft B at FL210 on the same track. They are vertically separated.',
              ),
              LessonContent(
                id: 'c3_m2_l3',
                title: 'Longitudinal Separation',
                content: 'Longitudinal separation keeps aircraft apart along the same track by time or distance. TIME-BASED separation requires aircraft to be X minutes apart, such as 10 minutes. DISTANCE-BASED (DME) separation requires X DME miles apart, such as 20 DME miles. MACH NUMBER TECHNIQUE is used for same-track, same-speed aircraft based on Mach number differences. Same-track and crossing-track situations have different rules.',
                keyPoints: [
                  'Time-based: minutes apart.',
                  'DME-based: distance apart.',
                  'Mach number technique for same speed.',
                  'Different rules for same vs crossing track.',
                ],
                example: 'Two aircraft on the same airway. ATC ensures they are at least 10 minutes apart before the second one reaches the same point.',
              ),
              LessonContent(
                id: 'c3_m2_l4',
                title: 'Lateral Separation',
                content: 'Lateral separation separates aircraft by putting them on different tracks or routes. Aircraft on different airways or tracks that do not intersect, or intersect at safe angles, are laterally separated. This uses geography: different routes mean no conflict.',
                keyPoints: [
                  'Different routes = lateral separation.',
                  'Non-intersecting tracks are safe.',
                  'Geography-based method.',
                  'Simple when routes differ.',
                ],
                example: 'Aircraft A on airway W1, Aircraft B on airway W2, which do not cross. They are laterally separated.',
              ),
              LessonContent(
                id: 'c3_m2_l5',
                title: 'Conflict Detection Without Radar',
                content: 'Without radar, controllers use flight progress strips (paper or electronic), flight-plan data, estimated times at reporting points, and pilot position reports to detect conflicts. The controller tracks each aircraft\'s estimated position, compares estimates to find potential conflicts, and plans separation before a conflict occurs. For example, if Aircraft A is estimated at waypoint X at 10:15 and Aircraft B at X at 10:20, ATC sees they will be 5 minutes apart and may need adjustment.',
                keyPoints: [
                  'Strips and estimates replace radar.',
                  'Predict conflicts before they happen.',
                  'Position reports update estimates.',
                  'Planning ahead is essential.',
                ],
                example: 'Aircraft A estimated at waypoint X at 10:15, Aircraft B at X at 10:20. ATC sees 5 minutes apart and may adjust.',
              ),
            ],
          ),
          ModuleContent(
            id: 'c3_m3',
            title: 'Arrival Management',
            lessons: [
              LessonContent(
                id: 'c3_m3_l1',
                title: 'Arrival Sequence',
                content: 'The ARRIVAL SEQUENCE is the order in which aircraft will land, based on arrival time, aircraft type, runway, and traffic. The fastest and most efficient sequence is preferred. Tools include speed control, level assignment, vectoring (if radar available), and holding. For example, three aircraft arriving: A (fast, 10 min out), B (slow, 15 min out), C (medium, 12 min out). ATC sequences A, C, B.',
                keyPoints: [
                  'Sequence based on arrival time and type.',
                  'Efficient order preferred.',
                  'Speed, level, vectors, holding as tools.',
                  'Balance efficiency and safety.',
                ],
                example: 'Three aircraft arriving at different times and speeds. ATC sequences them for efficient landing.',
              ),
              LessonContent(
                id: 'c3_m3_l2',
                title: 'Holding',
                content: 'A HOLDING PATTERN is a racetrack-shaped path where an aircraft waits until cleared to continue. Holding is used when airport capacity is reached, weather delays occur, traffic is congested, or a slot is awaited. Holding instructions include the fix (where to hold), direction (right or left turns), inbound track, time or distance, and Expected Approach Time (EAT).',
                keyPoints: [
                  'Holding: racetrack pattern.',
                  'Used for delays and congestion.',
                  'Instructions include fix, direction, track, time.',
                  'EAT: expected approach time.',
                ],
                example: '"Ethiopian 950, hold at BOLE, left turns, inbound track 090, 1 minute legs, expect approach clearance at 35."',
              ),
              LessonContent(
                id: 'c3_m3_l3',
                title: 'Approach Clearance',
                content: 'An APPROACH CLEARANCE is permission for an aircraft to begin an instrument approach. Types include ILS (Instrument Landing System), VOR approach, RNAV/GNSS approach, and visual approach. Approach clearance phraseology includes "Cleared ILS runway 07R approach" or "Cleared visual approach runway 07R." The APPROACH GATE is a point where the aircraft must be at a certain altitude and speed before final approach. After approach clearance, the aircraft is handed to tower for landing clearance.',
                keyPoints: [
                  'Approach clearance: permission to begin approach.',
                  'Types: ILS, VOR, RNAV, visual.',
                  'Approach gate: altitude/speed check.',
                  'Handoff to tower after clearance.',
                ],
                example: '"Ethiopian 950, cleared ILS runway 07R approach, contact Addis Tower on 118.1."',
              ),
            ],
          ),
          ModuleContent(
            id: 'c3_m4',
            title: 'Departure and Coordination',
            lessons: [
              LessonContent(
                id: 'c3_m4_l1',
                title: 'Departures in Approach',
                content: 'DEPARTURE RELEASE is permission from the next sector or unit for an aircraft to depart, ensuring no conflict with en-route traffic. CLIMB INSTRUCTIONS give initial altitude and heading after take-off, such as "Climb to FL100, after departure turn right heading 090." DEPARTURE SEPARATION ensures departing aircraft do not conflict with each other or arrivals. HANDOFF TO AREA CONTROL occurs after the aircraft leaves approach airspace.',
                keyPoints: [
                  'Departure release: next sector permission.',
                  'Climb instructions: initial altitude/heading.',
                  'Separation from other traffic.',
                  'Handoff to area after approach airspace.',
                ],
                example: '"Ethiopian 950, climb to FL100, contact Addis Control on 128.5."',
              ),
              LessonContent(
                id: 'c3_m4_l2',
                title: 'Coordination',
                content: 'Approach Control coordinates with TOWER for arrival sequence and handoff, and departure release. With AREA CONTROL, it coordinates handoff of departing aircraft and arrival of en-route traffic. With ADJACENT SECTORS, it coordinates traffic crossing boundaries and climbing/descending traffic. Approach Control is a coordination hub between tower and area control.',
                keyPoints: [
                  'Coordination with tower and area.',
                  'Arrival sequence and handoff.',
                  'Departure release coordination.',
                  'Hub between airport and en-route.',
                ],
                example: 'Approach Control coordinates with Area Control to ensure a departing aircraft can climb to cruising level without conflict.',
              ),
            ],
          ),
        ],
      ),

      // =====================
      // COURSE 4: APPROACH CONTROL — SURVEILLANCE (ICAO 054)
      // =====================
      CourseContent(
        id: 'course_4',
        title: 'Approach Control — Surveillance',
        description: 'Approach control using surveillance systems such as radar or ADS-B-derived displays.',
        aiTutorGuardrail: 'Provide educational explanations only. Do not provide live operational ATC instructions, real-time traffic decisions, or safety-critical operational advice.',
        modules: [
          ModuleContent(
            id: 'c4_m1',
            title: 'Surveillance Fundamentals',
            lessons: [
              LessonContent(
                id: 'c4_m1_l1',
                title: 'What Is Surveillance?',
                content: 'Surveillance is the ability to see the position and movement of aircraft in real time. Types include PRIMARY SURVEILLANCE RADAR (PSR), which detects aircraft by reflecting radio waves off the aircraft body; SECONDARY SURVEILLANCE RADAR (SSR), where the aircraft transponder responds to interrogation providing ID and altitude; ADS-B (Automatic Dependent Surveillance-Broadcast), where aircraft broadcast their position via satellite/GNSS; and MULTILATERATION (MLAT), which uses multiple ground stations to calculate position from transponder signals.',
                keyPoints: [
                  'Surveillance: real-time aircraft position.',
                  'PSR: radar reflection.',
                  'SSR: transponder response.',
                  'ADS-B: satellite broadcast.',
                ],
                example: 'A controller sees a Boeing 737 on the radar display at 15 miles from the airport, heading 090, at 5,000 feet, doing 250 knots.',
              ),
              LessonContent(
                id: 'c4_m1_l2',
                title: 'Radar Display Interpretation',
                content: 'The radar display shows several elements for each aircraft. The POSITION SYMBOL is the dot or shape representing the aircraft. The DATA BLOCK is text showing callsign, altitude (e.g., FL150), ground speed, rate of climb or descent, and squawk code. The SPEED VECTOR is a line showing predicted movement, with length indicating speed. TRACK HISTORY shows dots indicating where the aircraft has been. A typical data block: "ETH950 150 25" means Ethiopian 950 at FL150 doing 250 knots ground speed.',
                keyPoints: [
                  'Position symbol: aircraft location.',
                  'Data block: callsign, altitude, speed.',
                  'Speed vector: predicted movement.',
                  'Track history: past positions.',
                ],
                example: 'Data block "ETH950 150 25" tells the controller Ethiopian 950 is at FL150 doing 250 knots.',
              ),
              LessonContent(
                id: 'c4_m1_l3',
                title: 'Surveillance Limitations',
                content: 'Surveillance has limitations. COVERAGE GAPS occur in areas not covered by radar, such as mountains or remote areas. CLUTTER includes ground returns, weather, and birds appearing on radar. WEATHER EFFECTS such as heavy rain can attenuate radar signals. TRANSPONDER FAILURE means an aircraft may not appear on SSR but may still appear on PSR. DATA-BLOCK OVERLAP occurs when two aircraft are close together and their data blocks overlap.',
                keyPoints: [
                  'Coverage gaps in mountains/remote areas.',
                  'Clutter from ground, weather, birds.',
                  'Transponder failure affects SSR.',
                  'Controllers must know limitations.',
                ],
                example: 'In mountainous terrain, radar coverage may be blocked. ATC must rely on procedural methods in those areas.',
              ),
            ],
          ),
          ModuleContent(
            id: 'c4_m2',
            title: 'Radar Separation',
            lessons: [
              LessonContent(
                id: 'c4_m2_l1',
                title: 'Radar Separation Principles',
                content: 'Radar separation uses distance measured on the display. LATERAL RADAR SEPARATION keeps aircraft a certain distance apart horizontally, such as 5 nautical miles. LONGITUDINAL RADAR SEPARATION keeps aircraft separated along the same track, such as 5 nautical miles or time-based. VERTICAL SEPARATION uses different altitudes, with 1,000 feet minimum. WAKE TURBULENCE SEPARATION adds extra separation behind Heavy or Super aircraft, such as 4-6 nautical miles.',
                keyPoints: [
                  'Lateral: horizontal distance.',
                  'Longitudinal: along-track distance.',
                  'Vertical: altitude difference.',
                  'Wake turbulence: extra behind Heavy.',
                ],
                example: 'Two aircraft at the same altitude, 4 miles apart on the same track. ATC may need to increase separation to 5 miles.',
              ),
              LessonContent(
                id: 'c4_m2_l2',
                title: 'Conflict Detection',
                content: 'Conflict detection means predicting where aircraft will be, not just where they are. Controllers use SPEED VECTORS to see predicted movement and extrapolate current tracks. IDENTIFYING CONVERGING TRAFFIC means spotting aircraft heading toward the same point with speed vectors pointing toward each other. MANAGING CROSSING TRAFFIC requires ensuring separation at the crossing point.',
                keyPoints: [
                  'Predict future positions.',
                  'Speed vectors show movement.',
                  'Converging traffic: vectors toward each other.',
                  'Crossing traffic: ensure separation at crossing.',
                ],
                example: 'Aircraft A heading east, Aircraft B heading north. Their speed vectors cross. ATC must resolve before they meet.',
              ),
              LessonContent(
                id: 'c4_m2_l3',
                title: 'Conflict Resolution',
                content: 'Conflict resolution uses three main tools. HEADING VECTORS change track, such as "Turn right heading 090." SPEED CONTROL adjusts timing, such as "Reduce speed to 250 knots." LEVEL CHANGES separate vertically, such as "Descend to FL150." PRIORITY DECISIONS determine which aircraft to move, usually the one with more flexibility or less disruption.',
                keyPoints: [
                  'Vectors: change heading.',
                  'Speed: adjust timing.',
                  'Level: vertical separation.',
                  'Move the more flexible aircraft.',
                ],
                example: 'Two aircraft converging. ATC vectors one right and descends the other, resolving the conflict.',
              ),
            ],
          ),
          ModuleContent(
            id: 'c4_m3',
            title: 'Radar Approach Control',
            lessons: [
              LessonContent(
                id: 'c4_m3_l1',
                title: 'Arrival Handling',
                content: 'Radar approach control manages arrivals using several steps. INITIAL CONTACT is when the aircraft checks in and the controller establishes radar contact. TRAFFIC INFORMATION informs the pilot of other traffic, such as "Traffic, 12 o\'clock, 5 miles, Boeing 737, descending." DESCENT CLEARANCE instructs descent, such as "Descend to 5,000 feet." VECTORING changes heading, such as "Turn right heading 090." APPROACH CLEARANCE gives permission for the approach.',
                keyPoints: [
                  'Initial contact and radar identification.',
                  'Traffic information for awareness.',
                  'Descent and vectoring for sequencing.',
                  'Approach clearance final step.',
                ],
                example: '"Ethiopian 950, radar contact, descend to 5,000 feet, turn right heading 090, cleared ILS runway 07R approach."',
              ),
              LessonContent(
                id: 'c4_m3_l2',
                title: 'Sequencing',
                content: 'Sequencing keeps a smooth, safe flow of arrivals. FINAL APPROACH SPACING is the distance between aircraft on final approach, usually 5-6 nautical miles minimum. SPEED CONTROL adjusts spacing, such as "Reduce speed to 180 knots." MERGING TRAFFIC combines multiple aircraft arriving from different directions into one sequence. GO-AROUND HANDLING re-sequences an aircraft that missed the approach. RUNWAY CHANGE COORDINATION re-sequences all arrivals if the runway changes.',
                keyPoints: [
                  'Final approach spacing: 5-6 miles.',
                  'Speed control adjusts spacing.',
                  'Merging: combine multiple flows.',
                  'Go-around requires re-sequencing.',
                ],
                example: 'Three aircraft on approach. ATC uses speed control to maintain 6-mile spacing between each.',
              ),
              LessonContent(
                id: 'c4_m3_l3',
                title: 'Departure Handling',
                content: 'Radar approach control also manages departures. DEPARTURE RELEASE coordinates with the next sector before departure. INITIAL CLIMB INSTRUCTIONS give altitude and heading, such as "Climb to FL100, after departure turn right heading 090." TRAFFIC AVOIDANCE uses vectors to avoid other traffic. HANDOFF TO AREA CONTROL transfers the aircraft to en-route control.',
                keyPoints: [
                  'Departure release: next sector coordination.',
                  'Initial climb instructions.',
                  'Vectors for traffic avoidance.',
                  'Handoff to area control.',
                ],
                example: 'A departing 737 is given a heading to avoid an arriving aircraft, then handed to area control.',
              ),
            ],
          ),
          ModuleContent(
            id: 'c4_m4',
            title: 'Coordination and Degradation',
            lessons: [
              LessonContent(
                id: 'c4_m4_l1',
                title: 'Coordination',
                content: 'Coordination is constant in a surveillance environment. With TOWER, approach coordinates arrival sequence, handoff, and departure release. With AREA CONTROL, it coordinates handoff of departing aircraft and arrival of en-route traffic. With ADJACENT SECTORS, it coordinates traffic crossing boundaries. With FLOW MANAGEMENT, it coordinates traffic flow restrictions and delay programs.',
                keyPoints: [
                  'Coordination with tower, area, sectors, flow.',
                  'Constant communication.',
                  'Handoff and sequence coordination.',
                  'Flow management integration.',
                ],
                example: 'Approach Control coordinates with Area Control to ensure a departing aircraft can climb without conflict.',
              ),
              LessonContent(
                id: 'c4_m4_l2',
                title: 'Surveillance Degradation',
                content: 'When surveillance degrades, controllers must adapt. RADAR FAILURE means loss of the radar display, requiring reversion to procedural methods. TRANSPONDER FAILURE means an aircraft may not appear on SSR. LOSS OF SEPARATION WARNING alerts when separation is lost, requiring immediate action. REVERSION TO PROCEDURAL METHODS increases workload and reduces capacity but maintains safety.',
                keyPoints: [
                  'Radar failure: revert to procedural.',
                  'Transponder failure affects SSR.',
                  'Separation warnings need immediate action.',
                  'Procedural fallback maintains safety.',
                ],
                example: 'Radar fails. Approach Control must switch to procedural separation, increasing workload and reducing capacity.',
              ),
            ],
          ),
        ],
      ),

      // =====================
      // COURSE 5: AREA CONTROL — PROCEDURAL (ICAO 055)
      // =====================
      CourseContent(
        id: 'course_5',
        title: 'Area Control — Procedural',
        description: 'En-route traffic management in controlled airspace using procedural separation methods.',
        aiTutorGuardrail: 'Provide educational explanations only. Do not provide live operational ATC instructions, real-time traffic decisions, or safety-critical operational advice.',
        modules: [
          ModuleContent(
            id: 'c5_m1',
            title: 'Area Control Environment',
            lessons: [
              LessonContent(
                id: 'c5_m1_l1',
                title: 'What Is Area Control?',
                content: 'Area Control manages aircraft during the en-route (cruise) phase of flight in controlled airspace outside approach control areas. Responsibilities include maintaining separation, managing traffic flow, coordinating with adjacent sectors, handling climbing and descending traffic, and providing clearances. Area Control manages the longest phase of flight: cruise.',
                keyPoints: [
                  'Area Control: en-route cruise traffic.',
                  'Maintains separation.',
                  'Coordinates with adjacent sectors.',
                  'Longest phase of flight.',
                ],
                example: 'An Ethiopian Airlines 787 flying from Addis to London spends most of the flight in area control airspace, managed by multiple area control centres.',
              ),
              LessonContent(
                id: 'c5_m1_l2',
                title: 'Airspace Structure',
                content: 'Area airspace is organized into FLIGHT INFORMATION REGIONS (FIRs), the largest divisions covering huge geographic areas like the Addis Ababa FIR. UPPER and LOWER AIRSPACE divide by altitude, typically at FL245 or FL285. AIRWAYS are defined routes with names or numbers like "Airway W1." REPORTING POINTS are named waypoints where aircraft report position. SECTOR BOUNDARIES divide airspace into sectors, each with its own controller.',
                keyPoints: [
                  'FIR: largest airspace division.',
                  'Upper/lower airspace by altitude.',
                  'Airways: defined routes.',
                  'Sectors: divided for control.',
                ],
                example: 'Addis Ababa FIR is divided into sectors. An aircraft flying north crosses from one sector to another, requiring coordination.',
              ),
              LessonContent(
                id: 'c5_m1_l3',
                title: 'Flight Progress Information',
                content: 'In procedural control, controllers rely on FLIGHT PROGRESS STRIPS (paper or electronic) showing flight data, one per aircraft. FLIGHT-PLAN DATA includes route, altitude, speed, and destination. ESTIMATED TIMES predict arrival at reporting points. COORDINATION POINTS are where aircraft cross sector boundaries. TRANSFER OF CONTROL POINTS are where responsibility passes between sectors. These tools are the controller\'s "memory" in procedural control.',
                keyPoints: [
                  'Strips: one per aircraft.',
                  'Flight-plan data: route and altitude.',
                  'Estimated times: predict position.',
                  'Coordination points: sector boundaries.',
                ],
                example: 'A flight progress strip shows "ETH950, FL350, route A-B-C, ETA at B: 10:15." Controller uses this to plan.',
              ),
            ],
          ),
          ModuleContent(
            id: 'c5_m2',
            title: 'Procedural Separation',
            lessons: [
              LessonContent(
                id: 'c5_m2_l1',
                title: 'Vertical Separation',
                content: 'Vertical separation assigns different altitudes to aircraft. Standard minimum vertical separation is 1,000 feet below FL290 (300 m) and 2,000 feet above in some regions with Reduced Vertical Separation Minimum (RVSM). LEVEL ALLOCATION assigns cruising levels based on direction, such as even levels eastbound and odd westbound. Climbing and descending traffic must be separated from other traffic during level changes, requiring coordination.',
                keyPoints: [
                  '1,000 feet minimum below FL290.',
                  '2,000 feet above with RVSM.',
                  'Level allocation by direction.',
                  'Level changes need coordination.',
                ],
                example: 'Aircraft A at FL350, Aircraft B at FL370 on the same track. They are vertically separated by 2,000 feet.',
              ),
              LessonContent(
                id: 'c5_m2_l2',
                title: 'Longitudinal Separation',
                content: 'Longitudinal separation keeps aircraft apart along the same track. TIME-BASED separation requires X minutes apart, such as 10 minutes. DISTANCE-BASED separation requires X DME miles apart. MACH NUMBER TECHNIQUE is used for same-track, same-speed aircraft based on Mach number differences. Same-track and crossing-track situations have different rules.',
                keyPoints: [
                  'Time-based: minutes apart.',
                  'DME-based: distance apart.',
                  'Mach technique for same speed.',
                  'Same vs crossing track: different rules.',
                ],
                example: 'Two aircraft on the same airway. ATC ensures they are at least 10 minutes apart before the second reaches the same point.',
              ),
              LessonContent(
                id: 'c5_m2_l3',
                title: 'Lateral Separation',
                content: 'Lateral separation puts aircraft on different tracks or routes. Aircraft on different airways or tracks that do not intersect, or intersect at safe angles, are laterally separated. This geography-based method is simple when routes differ.',
                keyPoints: [
                  'Different routes = lateral separation.',
                  'Non-intersecting tracks are safe.',
                  'Geography-based.',
                  'Simple when routes differ.',
                ],
                example: 'Aircraft A on airway W1, Aircraft B on airway W2, which do not cross. They are laterally separated.',
              ),
            ],
          ),
          ModuleContent(
            id: 'c5_m3',
            title: 'Traffic Management',
            lessons: [
              LessonContent(
                id: 'c5_m3_l1',
                title: 'Traffic Flow',
                content: 'Traffic flow management keeps airspace from becoming overloaded. TRAFFIC ASSESSMENT understands how many aircraft are in the sector and predicts future traffic. FLOW PLANNING organizes how to handle traffic, possibly using level capping, speed control, or delays. LEVEL CAPPING restricts aircraft to a maximum altitude, such as "Do not climb above FL350." SPEED CONTROL adjusts timing, such as "Reduce speed to Mach 0.80." DELAY MANAGEMENT uses holding, rerouting, or speed control.',
                keyPoints: [
                  'Assess traffic and predict flow.',
                  'Level capping: max altitude.',
                  'Speed control: adjust timing.',
                  'Delays managed by holding or rerouting.',
                ],
                example: 'A sector is busy. ATC caps arrivals at FL350 and reduces speeds to manage the flow.',
              ),
              LessonContent(
                id: 'c5_m3_l2',
                title: 'Coordination',
                content: 'Coordination prevents conflicts at sector boundaries. ADJACENT-SECTOR COORDINATION is required before traffic crosses boundaries. TRANSFER OF CONTROL hands responsibility for an aircraft from one sector to another. TRANSFER OF COMMUNICATION hands the aircraft to the next frequency. COORDINATION OF CLIMBING/DESCENDING TRAFFIC is needed when aircraft change levels and may cross other traffic.',
                keyPoints: [
                  'Coordination before boundary crossing.',
                  'Transfer of control and communication.',
                  'Level changes need coordination.',
                  'Prevents boundary conflicts.',
                ],
                example: 'An aircraft climbing from FL250 to FL350 crosses another sector\'s airspace. ATC must coordinate before the climb.',
              ),
              LessonContent(
                id: 'c5_m3_l3',
                title: 'Special Traffic',
                content: 'Area Control handles many traffic types. MILITARY TRAFFIC may have different procedures and requires coordination with military units. VFR TRAFFIC may be in the same airspace with different separation rules. OVERFLYING TRAFFIC passes through without landing and must be separated. EMERGENCY TRAFFIC gets priority handling and coordination with emergency services.',
                keyPoints: [
                  'Military: different procedures.',
                  'VFR: different separation rules.',
                  'Overflying: must be separated.',
                  'Emergency: priority handling.',
                ],
                example: 'A military jet transits the sector. ATC coordinates with military control and separates it from civil traffic.',
              ),
            ],
          ),
        ],
      ),

      // =====================
      // COURSE 6: AREA CONTROL — SURVEILLANCE
      // =====================
      CourseContent(
        id: 'course_6',
        title: 'Area Control — Surveillance',
        description: 'En-route traffic management using surveillance displays and radar-based separation techniques.',
        aiTutorGuardrail: 'Provide educational explanations only. Do not provide live operational ATC instructions, real-time traffic decisions, or safety-critical operational advice.',
        modules: [
          ModuleContent(
            id: 'c6_m1',
            title: 'Surveillance Area Control',
            lessons: [
              LessonContent(
                id: 'c6_m1_l1',
                title: 'Display Interpretation',
                content: 'The radar display is the controller\'s "window" into the airspace. POSITION SYMBOLS represent aircraft. DATA BLOCKS show callsign, altitude, speed, and climb/descent rate. SPEED VECTORS show predicted movement with length indicating speed. FLIGHT-PLAN CORRELATION matches the radar track to the flight plan. The SECTOR TRAFFIC PICTURE is the overall view of all traffic in the sector.',
                keyPoints: [
                  'Position symbols: aircraft location.',
                  'Data blocks: flight information.',
                  'Speed vectors: predicted movement.',
                  'Sector picture: overall traffic view.',
                ],
                example: 'A controller sees 15 aircraft in the sector, each with a data block showing altitude and speed, building a mental picture of traffic flow.',
              ),
              LessonContent(
                id: 'c6_m1_l2',
                title: 'Traffic Assessment',
                content: 'Traffic assessment means predicting future conflicts, not just seeing current positions. IDENTIFYING TRAFFIC FLOW understands the general direction and density. DETECTING CONFLICTS uses speed vectors to predict conflicts and spot converging or crossing traffic. MANAGING CLIMBING/DESCENDING TRAFFIC monitors level changes that may conflict. MANAGING CROSSING/CONVERGING TRAFFIC ensures separation at crossing points.',
                keyPoints: [
                  'Predict future conflicts.',
                  'Speed vectors for prediction.',
                  'Monitor level changes.',
                  'Crossing traffic needs attention.',
                ],
                example: 'Two aircraft converging at the same altitude. The controller sees their speed vectors crossing and plans a resolution.',
              ),
              LessonContent(
                id: 'c6_m1_l3',
                title: 'Sector Management',
                content: 'Sector management coordinates traffic across boundaries. SECTOR BOUNDARIES divide airspace into sectors, each with its own controller. COORDINATION POINTS are where aircraft cross boundaries. TRANSFER OF CONTROL hands responsibility between sectors. TRANSFER OF COMMUNICATION hands the aircraft to the next frequency.',
                keyPoints: [
                  'Sectors divide airspace.',
                  'Coordination at boundaries.',
                  'Transfer of control and communication.',
                  'Smooth handoffs essential.',
                ],
                example: 'An aircraft crossing from Sector A to Sector B. Controllers coordinate, then transfer control and communication.',
              ),
            ],
          ),
          ModuleContent(
            id: 'c6_m2',
            title: 'Surveillance Separation',
            lessons: [
              LessonContent(
                id: 'c6_m2_l1',
                title: 'Radar Separation',
                content: 'Radar separation uses distance measured on the display. LATERAL SEPARATION keeps aircraft a certain distance apart horizontally, such as 5 nautical miles. LONGITUDINAL SEPARATION keeps aircraft separated along the same track. VERTICAL SEPARATION uses different altitudes with 1,000 feet minimum. WAKE TURBULENCE SEPARATION adds extra separation behind Heavy or Super aircraft, such as 4-6 nautical miles.',
                keyPoints: [
                  'Lateral: horizontal distance.',
                  'Longitudinal: along-track.',
                  'Vertical: altitude difference.',
                  'Wake turbulence: extra behind Heavy.',
                ],
                example: 'Two aircraft at the same altitude, 4 miles apart on the same track. ATC may need to increase separation to 5 miles.',
              ),
              LessonContent(
                id: 'c6_m2_l2',
                title: 'Conflict Resolution',
                content: 'Conflict resolution uses VECTORS ("Turn right heading 090"), SPEED ADJUSTMENTS ("Reduce speed to Mach 0.80"), and LEVEL CHANGES ("Descend to FL150"). PRIORITY RULES determine which aircraft to move, usually the one with more flexibility.',
                keyPoints: [
                  'Vectors: change heading.',
                  'Speed: adjust timing.',
                  'Level: vertical separation.',
                  'Move the flexible aircraft.',
                ],
                example: 'Two aircraft converging. ATC vectors one right and descends the other.',
              ),
              LessonContent(
                id: 'c6_m2_l3',
                title: 'Traffic Complexity',
                content: 'Traffic complexity increases workload and risk. MERGING TRAFFIC combines multiple flows from different directions. CROSSING TRAFFIC crosses other paths, requiring separation. OPPOSITE-DIRECTION TRAFFIC has high closing speeds. HIGH-DENSITY TRAFFIC means many aircraft in a small area.',
                keyPoints: [
                  'Merging: combine flows.',
                  'Crossing: ensure separation.',
                  'Opposite direction: high closing speed.',
                  'High density: high workload.',
                ],
                example: 'A sector with merging traffic from three directions, plus opposite-direction traffic, is high complexity.',
              ),
            ],
          ),
          ModuleContent(
            id: 'c6_m3',
            title: 'Coordination and Unusual Situations',
            lessons: [
              LessonContent(
                id: 'c6_m3_l1',
                title: 'Coordination',
                content: 'Coordination is constant in surveillance area control. ADJACENT SECTORS coordinate traffic crossing boundaries. APPROACH CONTROL coordinates handoff of descending traffic. MILITARY UNITS coordinate military traffic. FLOW-MANAGEMENT UNITS coordinate restrictions and delay programs.',
                keyPoints: [
                  'Adjacent sectors: boundary traffic.',
                  'Approach: descending traffic.',
                  'Military: special coordination.',
                  'Flow management: restrictions.',
                ],
                example: 'A sector coordinates with the next sector to ensure a climbing aircraft can proceed without conflict.',
              ),
              LessonContent(
                id: 'c6_m3_l2',
                title: 'Unusual Situations',
                content: 'Controllers must be ready for unusual situations. EMERGENCY DESCENT requires rapid descent due to emergency, with traffic separation and coordination. COMMUNICATION FAILURE requires lost-communication procedures. SURVEILLANCE DEGRADATION requires reversion to procedural methods. WEATHER AVOIDANCE means aircraft deviating around weather, possibly creating conflicts. AIRSPACE CLOSURE requires rerouting traffic.',
                keyPoints: [
                  'Emergency descent: clear the path.',
                  'Communication failure: procedures.',
                  'Surveillance degradation: procedural fallback.',
                  'Weather and closure: reroute.',
                ],
                example: 'An aircraft declares an emergency descent. ATC clears the path, coordinates with other sectors, and manages other traffic.',
              ),
            ],
          ),
        ],
      ),

      // =====================
      // COURSE 7: AVIATION ENGLISH AND RADIOTELEPHONY
      // =====================
      CourseContent(
        id: 'course_7',
        title: 'Aviation English and Radiotelephony',
        description: 'Clear, standard, and safe controller-pilot communication using aviation English and standard phraseology.',
        aiTutorGuardrail: 'Provide educational explanations only. Do not provide live operational ATC instructions, real-time traffic decisions, or safety-critical operational advice.',
        modules: [
          ModuleContent(
            id: 'c7_m1',
            title: 'Aviation English Foundations',
            lessons: [
              LessonContent(
                id: 'c7_m1_l1',
                title: 'Why Aviation English Matters',
                content: 'Aviation English is the standardized form of English used in international aviation communication. English is the international language of aviation, allowing pilots and controllers from different countries to understand each other. Miscommunication can cause accidents. Standard phraseology and clear pronunciation are essential.',
                keyPoints: [
                  'English: international aviation language.',
                  'Standard phraseology prevents misunderstanding.',
                  'Clear pronunciation essential.',
                  'Miscommunication can cause accidents.',
                ],
                example: 'A Chinese pilot and an Ethiopian controller communicate in aviation English, using standard phraseology to ensure understanding.',
              ),
              LessonContent(
                id: 'c7_m1_l2',
                title: 'The Phonetic Alphabet',
                content: 'The phonetic alphabet spells words clearly over the radio. Each letter has a designated word: Alpha, Bravo, Charlie, Delta, Echo, Foxtrot, Golf, Hotel, India, Juliett, Kilo, Lima, Mike, November, Oscar, Papa, Quebec, Romeo, Sierra, Tango, Uniform, Victor, Whiskey, X-ray, Yankee, Zulu. This ensures letters are understood correctly over noisy radios.',
                keyPoints: [
                  'Each letter has a word.',
                  'Used for spelling clarity.',
                  'Essential for registrations and codes.',
                  'Universal across aviation.',
                ],
                example: 'Aircraft registration "ET-AQP" is spoken as "Echo Tango - Alpha Quebec Papa."',
              ),
              LessonContent(
                id: 'c7_m1_l3',
                title: 'Numbers in Aviation',
                content: 'Numbers are spoken digit by digit. "350" is "three five zero." "FL350" is "flight level three five zero." "Runway 07" is "runway zero seven." "Heading 090" is "heading zero niner zero." Nine is spoken as "niner" to avoid confusion with German "nein." Decimal points are spoken as "decimal."',
                keyPoints: [
                  'Digit by digit.',
                  'Nine = "niner".',
                  'Decimal = "decimal".',
                  'Prevents confusion.',
                ],
                example: '"Descend to 3,000 feet" is "Descend to three thousand feet." "QNH 1013" is "QNH one zero one three."',
              ),
              LessonContent(
                id: 'c7_m1_l4',
                title: 'Standard Phraseology',
                content: 'Standard phraseology is a set of agreed words and phrases used in aviation communication. It reduces misunderstanding, saves time, and improves safety. Common phrases include "Cleared for take-off," "Cleared to land," "Descend and maintain," "Climb and maintain," "Turn left/right heading," "Hold short," "Line up and wait," and "Contact [unit] on [frequency]."',
                keyPoints: [
                  'Agreed words and phrases.',
                  'Reduces misunderstanding.',
                  'Saves time.',
                  'Improves safety.',
                ],
                example: '"Ethiopian 950, runway 07R, cleared for take-off, after departure turn right heading 090."',
              ),
              LessonContent(
                id: 'c7_m1_l5',
                title: 'Readbacks and Hearbacks',
                content: 'A READBACK is when the pilot repeats key parts of an ATC instruction. A HEARBACK is when the controller listens and corrects errors. Items requiring readback include runway in use, clearance limits, heading/track, altitude, speed, squawk codes, and hold-short instructions. This two-way confirmation is a critical safety barrier.',
                keyPoints: [
                  'Readback: pilot repeats.',
                  'Hearback: controller verifies.',
                  'Critical safety barrier.',
                  'Specific items must be read back.',
                ],
                example: 'ATC: "Ethiopian 950, climb and maintain FL350." Pilot: "Climb and maintain FL350, Ethiopian 950." ATC: "Readback correct."',
              ),
            ],
          ),
          ModuleContent(
            id: 'c7_m2',
            title: 'Operational Communication',
            lessons: [
              LessonContent(
                id: 'c7_m2_l1',
                title: 'Clearance Delivery',
                content: 'Clearance delivery gives the aircraft its route and initial instructions. ROUTE CLEARANCE: "Ethiopian 950, cleared to Dubai via [route], FL350." SQUAWK ASSIGNMENT: "Squawk 4521." DEPARTURE INSTRUCTIONS: "After departure, turn right heading 090."',
                keyPoints: [
                  'Route clearance.',
                  'Squawk assignment.',
                  'Departure instructions.',
                  'Initial flight setup.',
                ],
                example: '"Ethiopian 950, cleared to Dubai via [route], FL350, squawk 4521, after departure turn right heading 090."',
              ),
              LessonContent(
                id: 'c7_m2_l2',
                title: 'Ground Movement Communication',
                content: 'Ground communication moves aircraft safely on the ground. TAXI INSTRUCTIONS: "Ethiopian 950, taxi to runway 07R via Alpha." HOLD-SHORT: "Hold short of runway 07R." CROSSING: "Cross runway 07R." PUSHBACK: "Ethiopian 950, pushback approved."',
                keyPoints: [
                  'Taxi instructions.',
                  'Hold-short instructions.',
                  'Crossing instructions.',
                  'Pushback coordination.',
                ],
                example: '"Ethiopian 950, taxi to runway 07R via Alpha, hold short of runway 07R."',
              ),
              LessonContent(
                id: 'c7_m2_l3',
                title: 'Tower Communication',
                content: 'Tower communication handles take-off and landing. TAKE-OFF CLEARANCE: "Ethiopian 950, runway 07R, cleared for take-off." LANDING CLEARANCE: "Ethiopian 950, runway 07R, cleared to land." GO-AROUND: "Ethiopian 950, go around." TRAFFIC INFORMATION: "Traffic, 12 o\'clock, 5 miles, Boeing 737, descending."',
                keyPoints: [
                  'Take-off clearance.',
                  'Landing clearance.',
                  'Go-around instructions.',
                  'Traffic information.',
                ],
                example: '"Ethiopian 950, runway 07R, cleared to land, wind 270 at 15 knots."',
              ),
              LessonContent(
                id: 'c7_m2_l4',
                title: 'Approach and Area Communication',
                content: 'Approach and area communication manages the aircraft through its flight. DESCENT/CLIMB: "Descend to FL200" or "Climb to FL350." HEADING: "Turn right heading 090." SPEED: "Reduce speed to 250 knots." HANDOFF: "Contact Addis Control on 128.5."',
                keyPoints: [
                  'Descent and climb instructions.',
                  'Heading instructions.',
                  'Speed instructions.',
                  'Handoff instructions.',
                ],
                example: '"Ethiopian 950, descend to FL200, turn right heading 090, reduce speed to 250 knots."',
              ),
            ],
          ),
          ModuleContent(
            id: 'c7_m3',
            title: 'Communication Problems',
            lessons: [
              LessonContent(
                id: 'c7_m3_l1',
                title: 'Communication Errors',
                content: 'Communication errors must be caught and corrected immediately. READBACK ERRORS occur when the pilot repeats incorrectly; the controller must correct. BLOCKED TRANSMISSION occurs when two transmissions overlap; neither is heard clearly and must be repeated. SIMILAR CALLSIGNS like "Ethiopian 950" and "Ethiopian 905" can cause confusion; use full callsigns. AMBIGUOUS INSTRUCTIONS are unclear and must be clarified.',
                keyPoints: [
                  'Readback errors: correct immediately.',
                  'Blocked transmission: repeat.',
                  'Similar callsigns: use full callsigns.',
                  'Ambiguity: clarify.',
                ],
                example: 'ATC: "Ethiopian 950, descend to FL200." Pilot: "Descend to FL220, Ethiopian 950." ATC: "Negative, descend to FL200, Ethiopian 950."',
              ),
              LessonContent(
                id: 'c7_m3_l2',
                title: 'Communication Failure',
                content: 'Communication failure has defined procedures. LOST COMMUNICATION PROCEDURES: both pilot and controller follow procedures; the pilot may continue on last clearance or follow published procedures. ALTERNATIVE COMMUNICATION includes other frequencies, data link (CPDLC), and emergency squawk 7600. EMERGENCY COMMUNICATION uses Mayday/Pan-Pan with priority handling.',
                keyPoints: [
                  'Lost comm: follow procedures.',
                  'Alternative: other frequencies, CPDLC.',
                  'Emergency squawk: 7600.',
                  'Mayday/Pan-Pan: priority.',
                ],
                example: 'An aircraft loses communication. It squawks 7600 and follows the last clearance. ATC clears the airspace.',
              ),
            ],
          ),
        ],
      ),

      // =====================
      // COURSE 8: HUMAN FACTORS AND SAFETY MANAGEMENT
      // =====================
      CourseContent(
        id: 'course_8',
        title: 'Human Factors and Safety Management',
        description: 'Safe human performance, teamwork, and safety culture in ATC operations.',
        aiTutorGuardrail: 'Provide educational explanations only. Do not provide live operational ATC instructions, real-time traffic decisions, or safety-critical operational advice.',
        modules: [
          ModuleContent(
            id: 'c8_m1',
            title: 'Human Performance',
            lessons: [
              LessonContent(
                id: 'c8_m1_l1',
                title: 'Why Human Factors Matter',
                content: 'Human factors is the study of how humans interact with systems, equipment, and each other. Most aviation incidents involve human error, not just mechanical failure. Understanding human limitations helps design better systems and prevent accidents. Key areas include attention, memory, decision-making, stress, fatigue, and communication. Humans are the weakest link but also the most adaptable part of the system.',
                keyPoints: [
                  'Human error causes most incidents.',
                  'Understanding limitations prevents errors.',
                  'Humans adaptable but fallible.',
                  'Systems should support performance.',
                ],
                example: 'A controller misses an aircraft changing altitude because they were focused on another conflict. This is an attention error.',
              ),
              LessonContent(
                id: 'c8_m1_l2',
                title: 'Attention and Perception',
                content: 'SELECTIVE ATTENTION means limited focus; a controller monitoring 10 aircraft may miss one changing altitude. ATTENTION TUNNELING is focusing too much on one thing and missing other information. EXPECTATION BIAS means hearing or seeing what we expect. PERCEPTION is interpreting sensory information, affected by expectations, stress, and fatigue.',
                keyPoints: [
                  'Attention is limited.',
                  'Tunneling: missing other info.',
                  'Expectation bias: hearing what we expect.',
                  'Stress and fatigue worsen perception.',
                ],
                example: 'A controller hears "descend to FL200" but expects "FL220" and mishears it.',
              ),
              LessonContent(
                id: 'c8_m1_l3',
                title: 'Memory and Decision-Making',
                content: 'WORKING MEMORY is short-term memory for current tasks, limited to about 4-7 items. SHORT-TERM MEMORY holds information briefly and can be lost if interrupted. DECISION-MAKING UNDER PRESSURE suffers from time pressure and stress. CONFIRMATION BIAS means seeking information confirming existing beliefs.',
                keyPoints: [
                  'Working memory: 4-7 items.',
                  'Interruptions cause memory loss.',
                  'Stress narrows decisions.',
                  'Confirmation bias distorts judgment.',
                ],
                example: 'A controller managing 8 aircraft must remember each status. If interrupted, they may forget one.',
              ),
              LessonContent(
                id: 'c8_m1_l4',
                title: 'Stress and Fatigue',
                content: 'STRESS comes from workload, time pressure, conflicts, or personal issues, reducing attention and causing errors. FATIGUE is reduced performance from sleep loss, long wakefulness, or workload, causing slower reactions and poor memory. Managing fatigue requires adequate rest, proper shift scheduling, breaks, and napping strategies.',
                keyPoints: [
                  'Stress: workload and pressure.',
                  'Fatigue: sleep loss and long shifts.',
                  'Both reduce performance.',
                  'Rest and scheduling help.',
                ],
                example: 'A controller on their 10th hour of a night shift is fatigued and misses a readback error.',
              ),
            ],
          ),
          ModuleContent(
            id: 'c8_m2',
            title: 'Threat and Error Management (TEM)',
            lessons: [
              LessonContent(
                id: 'c8_m2_l1',
                title: 'What Is TEM?',
                content: 'TEM is a framework for identifying threats, preventing errors, and managing errors. THREATS are external factors increasing error risk. ERRORS are human actions deviating from intentions. UNDESIRED STATES are situations where safety margins are reduced. TEM accepts errors are inevitable and builds systems to catch them.',
                keyPoints: [
                  'TEM: threats, errors, undesired states.',
                  'Errors inevitable.',
                  'Manage through prevention, detection, correction.',
                  'Reporting enables learning.',
                ],
                example: 'A thunderstorm (threat) causes a controller to forget an instruction (lapse). Another controller corrects it. The event is reported.',
              ),
              LessonContent(
                id: 'c8_m2_l2',
                title: 'Threats',
                content: 'Threats are external factors increasing error risk: weather, traffic complexity, equipment limitations, communication issues, time pressure, and personal issues. Managing threats means anticipating them, planning for them, and using tools and procedures.',
                keyPoints: [
                  'External factors.',
                  'Anticipate and plan.',
                  'Use tools and procedures.',
                  'Reduces impact.',
                ],
                example: 'A controller knows a thunderstorm is approaching. They plan extra separation and prepare for deviations.',
              ),
              LessonContent(
                id: 'c8_m2_l3',
                title: 'Errors',
                content: 'Errors include SLIPS (unintentional action errors like pressing wrong button), LAPSES (memory failures like forgetting an instruction), MISTAKES (wrong decisions), and VIOLATIONS (intentional rule-breaking). Error management includes PREVENTION, DETECTION, CORRECTION, and REPORTING.',
                keyPoints: [
                  'Slips: action errors.',
                  'Lapses: memory failures.',
                  'Mistakes: wrong decisions.',
                  'Violations: intentional.',
                ],
                example: 'A controller presses the wrong button (slip). Another controller notices and corrects it. The event is reported.',
              ),
            ],
          ),
          ModuleContent(
            id: 'c8_m3',
            title: 'Safety Management',
            lessons: [
              LessonContent(
                id: 'c8_m3_l1',
                title: 'Safety Culture',
                content: 'Safety culture is shared values, beliefs, and behaviors regarding safety. JUST CULTURE allows people to report errors without fear of unfair punishment, distinguishing honest errors from reckless behavior. OPEN REPORTING encourages reporting errors and concerns. NON-PUNITIVE REPORTING uses reports for learning, not punishment.',
                keyPoints: [
                  'Just culture: report without fear.',
                  'Open reporting encouraged.',
                  'Non-punitive: learning focused.',
                  'Distinguish error from recklessness.',
                ],
                example: 'A controller makes an error and reports it. Instead of punishment, the organization learns and improves procedures.',
              ),
              LessonContent(
                id: 'c8_m3_l2',
                title: 'Safety Management Systems (SMS)',
                content: 'SMS is a systematic approach to managing safety. Four components: SAFETY POLICY (leadership commitment), RISK MANAGEMENT (identify and mitigate risks), SAFETY ASSURANCE (monitor and measure performance), and SAFETY PROMOTION (training, communication, culture).',
                keyPoints: [
                  'Four components: policy, risk, assurance, promotion.',
                  'Systematic safety approach.',
                  'Leadership commitment.',
                  'Continuous improvement.',
                ],
                example: 'An ATC organization has an SMS with regular safety meetings, incident reporting, risk assessments, and training.',
              ),
              LessonContent(
                id: 'c8_m3_l3',
                title: 'Incident Reporting',
                content: 'Incident reporting covers ERRORS, NEAR-MISSES, EQUIPMENT FAILURES, and SAFETY CONCERNS. Reporting enables learning from events, preventing future accidents, and improving procedures. CONFIDENTIAL REPORTING protects the reporter\'s identity and encourages honest reporting.',
                keyPoints: [
                  'Report errors and near-misses.',
                  'Learning from events.',
                  'Confidential reporting protects identity.',
                  'Improves procedures.',
                ],
                example: 'A controller reports a near-miss. The organization investigates, finds a procedure gap, and improves it.',
              ),
            ],
          ),
        ],
      ),

      // =====================
      // COURSE 9: ABNORMAL AND EMERGENCY PROCEDURES
      // =====================
      CourseContent(
        id: 'course_9',
        title: 'Abnormal and Emergency Procedures',
        description: 'Recognizing, communicating, coordinating, and supporting non-normal and emergency situations.',
        aiTutorGuardrail: 'Provide educational explanations only. Do not provide live operational ATC instructions, real-time traffic decisions, or safety-critical operational advice.',
        modules: [
          ModuleContent(
            id: 'c9_m1',
            title: 'Emergency Recognition',
            lessons: [
              LessonContent(
                id: 'c9_m1_l1',
                title: 'What Is an Emergency?',
                content: 'An emergency is a situation requiring immediate action to prevent danger to life, aircraft, or property. Emergencies are rare but high-risk; controllers must be prepared. Types include engine failure, fire, fuel emergency, pressurization problem, medical emergency, hydraulic failure, communication failure, and security-related emergency.',
                keyPoints: [
                  'Emergency: immediate action needed.',
                  'Rare but high-risk.',
                  'Controllers must be prepared.',
                  'Quick correct action saves lives.',
                ],
                example: 'An aircraft reports smoke in the cabin. This is an emergency requiring immediate priority handling.',
              ),
              LessonContent(
                id: 'c9_m1_l2',
                title: 'Pilot Declarations',
                content: 'MAYDAY indicates a distress situation requiring immediate assistance, life-threatening or serious danger: "Mayday, Mayday, Mayday, Ethiopian 950, engine fire." PAN-PAN indicates urgency but not immediate danger: "Pan-Pan, Pan-Pan, Ethiopian 950, medical emergency on board." FUEL EMERGENCY means insufficient fuel for safe landing. MINIMUM FUEL means enough fuel but no margin for delays. EMERGENCY DESCENT is rapid descent due to emergency.',
                keyPoints: [
                  'Mayday: distress.',
                  'Pan-Pan: urgency.',
                  'Fuel emergency: insufficient fuel.',
                  'Emergency descent: rapid descent.',
                ],
                example: '"Mayday, Mayday, Mayday, Ethiopian 950, we have lost an engine, request immediate landing."',
              ),
              LessonContent(
                id: 'c9_m1_l3',
                title: 'Controller Priorities During Emergencies',
                content: 'During emergencies, the controller\'s job is to assist, not add workload. Priorities: MAINTAIN SITUATIONAL AWARENESS (track the emergency and other traffic), PROVIDE NECESSARY ASSISTANCE (clearances, information, priority), AVOID ADDING WORKLOAD (ask only essential questions), COORDINATE with relevant units, and PROTECT OTHER TRAFFIC (separate and clear airspace).',
                keyPoints: [
                  'Situational awareness first.',
                  'Provide necessary assistance.',
                  'Avoid adding workload.',
                  'Coordinate and protect other traffic.',
                ],
                example: 'An aircraft declares an emergency. The controller gives priority, clears other traffic, coordinates with emergency services, and asks only essential questions.',
              ),
            ],
          ),
          ModuleContent(
            id: 'c9_m2',
            title: 'Emergency Handling',
            lessons: [
              LessonContent(
                id: 'c9_m2_l1',
                title: 'Communication During Emergencies',
                content: 'Emergency communication should be calm, clear, and minimal. Use CALM AND CLEAR PHRASEOLOGY, speaking slowly and clearly. CONFIRM THE NATURE of the emergency: "Ethiopian 950, confirm the nature of your emergency." ASK ONLY ESSENTIAL QUESTIONS, not burdening the pilot. PROVIDE RELEVANT INFORMATION such as runway availability, weather, and alternate airports.',
                keyPoints: [
                  'Calm and clear.',
                  'Confirm the emergency.',
                  'Essential questions only.',
                  'Provide relevant info.',
                ],
                example: '"Ethiopian 950, roger, mayday. Runway 07R is available. Wind 270 at 15 knots. Do you require emergency services?"',
              ),
              LessonContent(
                id: 'c9_m2_l2',
                title: 'Traffic Management During Emergencies',
                content: 'Traffic management during emergencies means giving priority and clearing the way. PRIORITY HANDLING gives the emergency aircraft priority; others may be delayed or rerouted. TRAFFIC SEPARATION ensures separation between the emergency aircraft and others. AIRSPACE RESTRICTION clears airspace around the emergency. HOLDING OTHER TRAFFIC delays other aircraft. RUNWAY AVAILABILITY ensures a runway is available.',
                keyPoints: [
                  'Priority for emergency aircraft.',
                  'Separate from other traffic.',
                  'Clear airspace if needed.',
                  'Ensure runway availability.',
                ],
                example: 'An aircraft declares an emergency. ATC holds three arriving aircraft and clears the airspace for the emergency aircraft to land.',
              ),
              LessonContent(
                id: 'c9_m2_l3',
                title: 'Coordination During Emergencies',
                content: 'Emergencies require coordination with many parties. AIRPORT EMERGENCY SERVICES (fire, ambulance, rescue) are notified and coordinated. TOWER COORDINATION ensures runway availability and landing clearance. APPROACH/AREA COORDINATION manages traffic separation and handoff. AIRLINE OPERATIONS are notified for ground support. SEARCH AND RESCUE is coordinated if the aircraft is missing or over remote areas.',
                keyPoints: [
                  'Emergency services: notify and coordinate.',
                  'Tower: runway and clearance.',
                  'Approach/area: separation.',
                  'Airline and SAR as needed.',
                ],
                example: 'An aircraft declares an emergency. ATC notifies airport fire services, coordinates with tower for runway availability, and informs the airline.',
              ),
            ],
          ),
          ModuleContent(
            id: 'c9_m3',
            title: 'Specific Emergency Situations',
            lessons: [
              LessonContent(
                id: 'c9_m3_l1',
                title: 'Communication Failure',
                content: 'Communication failure has defined procedures. LOST COMMUNICATION PROCEDURES: both pilot and controller follow procedures; the pilot may continue on last clearance or published procedures. ALTERNATIVE FREQUENCIES and GUARD FREQUENCY (121.5) are tried. EMERGENCY SQUAWK 7600 indicates communication failure. COORDINATION WITH OTHER SECTORS informs and clears airspace.',
                keyPoints: [
                  'Lost comm: follow procedures.',
                  'Guard frequency: 121.5.',
                  'Emergency squawk: 7600.',
                  'Coordinate with sectors.',
                ],
                example: 'An aircraft loses communication. It squawks 7600 and follows the last clearance. ATC sees the squawk, clears the airspace, and tries alternative frequencies.',
              ),
              LessonContent(
                id: 'c9_m3_l2',
                title: 'Emergency Descent',
                content: 'An EMERGENCY DESCENT is a rapid descent due to an emergency such as loss of pressurization or fire. Controller actions include CLEARING THE DESCENT PATH, COORDINATING WITH AFFECTED SECTORS, SEPARATING FROM OTHER TRAFFIC, and PROVIDING NECESSARY INFORMATION.',
                keyPoints: [
                  'Rapid descent: pressurization or fire.',
                  'Clear the descent path.',
                  'Coordinate with sectors.',
                  'Separate from traffic.',
                ],
                example: 'An aircraft at FL350 declares an emergency descent due to pressurization loss. ATC clears aircraft below and coordinates with sectors.',
              ),
              LessonContent(
                id: 'c9_m3_l3',
                title: 'Runway Emergency',
                content: 'Runway emergencies require quick action. RUNWAY CLOSURE occurs due to incident, maintenance, or weather; traffic uses another runway or diverts. EMERGENCY VEHICLE MOVEMENT coordinates fire trucks and ambulances. HOLDING DEPARTING/ARRIVING TRAFFIC manages the flow. RUNWAY RE-OPENING requires inspection before resuming operations.',
                keyPoints: [
                  'Closure: alternate or divert.',
                  'Emergency vehicles: coordinate.',
                  'Hold traffic as needed.',
                  'Inspect before re-opening.',
                ],
                example: 'An aircraft has a tire burst on landing, blocking the runway. Tower closes the runway, holds traffic, coordinates emergency vehicles, and manages diversions.',
              ),
            ],
          ),
        ],
      ),
    ];
  }

  CourseContent? getCourseById(String id) {
    try {
      return getAllCourses().firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  List<LessonContent> getLessonsForModule(String courseId, String moduleId) {
    final course = getCourseById(courseId);
    if (course == null) return [];
    for (final module in course.modules) {
      if (module.id == moduleId) return module.lessons;
    }
    return [];
  }

  List<LessonContent> getAllLessonsForCourse(String courseId) {
    final course = getCourseById(courseId);
    if (course == null) return [];
    final lessons = <LessonContent>[];
    for (final module in course.modules) {
      lessons.addAll(module.lessons);
    }
    return lessons;
  }
}
