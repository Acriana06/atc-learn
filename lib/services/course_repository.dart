
class CourseRepository {
  static final List<Map<String, dynamic>> modules = [
    {
      'id': '1',
      'title': '1. Air Law & ATC Regulations',
      'code': 'ICAO Doc 4444 / Annex 2',
      'description': 'Master the fundamental rules of the air, ATS safety objectives, and flight plan submission standards across global and regional FIRs.',
      'lessons': [
        'Introduction to ICAO Annex 2 (Rules of the Air)',
        'Flight Plan (FPL) Formatting & Submission Directives',
        'Air Traffic Services (ATS) Safety Objectives & Separation Criteria',
      ],
      'quiz': [
        {
          'question': 'What is the primary objective of Air Traffic Services according to ICAO Doc 4444?',
          'options': [
            'To collect navigation taxes from airlines',
            'To prevent collisions between aircraft and expedite air traffic flow',
            'To provide commercial weather routing for private jets',
            'To manage airport baggage and ground crew logistics'
          ],
          'correctIndex': 1,
        },
        {
          'question': 'Which ICAO Annex governs the baseline international "Rules of the Air"?',
          'options': ['Annex 2', 'Annex 11', 'Annex 14', 'Annex 10'],
          'correctIndex': 0,
        }
      ]
    },
    {
      'id': '2',
      'title': '2. Aerodrome Control (TWR)',
      'code': 'PANS-ATM Chapter 7 (HAAB Focus)',
      'description': 'Learn runway separation minima, visual circuit procedures, and surface movement control for tower controllers at major hubs like Addis Ababa Bole International (HAAB).',
      'lessons': [
        'Runway Separation Minima for Departing & Arriving Aircraft',
        'Visual Circuit Entry, Downwind, Base, and Final Protocols',
        'Low Visibility Procedures (LVP) & Ground Movement Control',
      ],
      'quiz': [
        {
          'question': 'Under standard radar separation, what is the minimum longitudinal separation required for aircraft on the same track?',
          'options': ['3 NM', '5 NM', '10 NM', '15 NM'],
          'correctIndex': 1,
        },
        {
          'question': 'At Addis Ababa Bole International (HAAB), which runway configuration is standard for prevailing westerly operations?',
          'options': ['Runway 07R / 07L', 'Runway 25L / 25R', 'Runway 12 / 30', 'Runway 01 / 19'],
          'correctIndex': 1,
        }
      ]
    },
    {
      'id': '3',
      'title': '3. Approach Control Procedures',
      'code': 'Procedural & Radar Approach',
      'description': 'Understand arrival sequencing, holding patterns, Initial Approach Fix (IAF) transitions, and non-radar separation parameters.',
      'lessons': [
        'Arrival Sequencing & Standard Terminal Arrival Routes (STARs)',
        'Holding Pattern Entry Procedures (Teardrop, Parallel, Direct)',
        'Non-Radar Procedural Approach Separation Standards',
      ],
      'quiz': [
        {
          'question': 'What are the three standard holding entry sectors?',
          'options': [
            'Direct, Teardrop, Parallel',
            'Vertical, Horizontal, Diagonal',
            'Primary, Secondary, Contingency',
            'Entry, Orbit, Exit'
          ],
          'correctIndex': 0,
        }
      ]
    },
    {
      'id': '4',
      'title': '4. Area (En-Route) Control',
      'code': 'RVSM & Sector Management',
      'description': 'Explore Reduced Vertical Separation Minimum (RVSM) implementation standards, sector hand-offs, and upper airspace management across the Addis Ababa FIR.',
      'lessons': [
        'RVSM Implementation Standards (FL290 to FL410)',
        'Upper Airspace Sector Hand-offs & Frequency Management',
        'Emergency Interception & Contingency Routing in Oceanic/Remote Airspace',
      ],
      'quiz': [
        {
          'question': 'What is the vertical separation minimum within RVSM airspace (FL290 to FL410)?',
          'options': ['500 ft', '1,000 ft', '2,000 ft', '4,000 ft'],
          'correctIndex': 1,
        }
      ]
    },
  ];
}