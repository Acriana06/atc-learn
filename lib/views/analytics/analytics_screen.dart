import 'package:flutter/material.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDarkMode ? const Color(0xFF141936) : Colors.white;
    final primaryTxt = isDarkMode ? Colors.white : Colors.black87;
    final secondaryTxt = isDarkMode ? Colors.white54 : Colors.black54;

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Card(
          color: const Color(0xFF090C9B),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Text(
                  'INDIVIDUAL COURSE PROFICIENCY',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.cyanAccent, letterSpacing: 1.2),
                ),
                const SizedBox(height: 12),
                Stack(
                  alignment: Alignment.center,
                  children: const [
                    SizedBox(
                      width: 90,
                      height: 90,
                      child: CircularProgressIndicator(
                        value: 0.88,
                        strokeWidth: 7,
                        backgroundColor: Colors.white12,
                        color: Colors.cyanAccent,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('88%', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                        Text('ON TRACK', style: TextStyle(fontSize: 8, color: Colors.greenAccent, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const Text(
                  'Tracked across 9 ICAO training modules, exam quizzes, and study hours.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11, color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),

        Row(
          children: [
            Expanded(child: _metricTile('Quiz Pass Rate', '94.2%', Icons.quiz_outlined, Colors.green, cardBg, primaryTxt)),
            const SizedBox(width: 10),
            Expanded(child: _metricTile('Uploaded Docs', '12', Icons.file_present_rounded, Colors.orangeAccent, cardBg, primaryTxt)),
            const SizedBox(width: 10),
            Expanded(child: _metricTile('Study Hours', '48.5h', Icons.timer_outlined, Colors.blueAccent, cardBg, primaryTxt)),
          ],
        ),
        const SizedBox(height: 24),

        Text('ICAO Course Completion', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: secondaryTxt)),
        const SizedBox(height: 12),

        _courseProgressTile('1. Air Law & ATC Regulations (Doc 4444)', 1.0, '100%', cardBg, primaryTxt),
        _courseProgressTile('2. Aerodrome Control (TWR)', 0.88, '88%', cardBg, primaryTxt),
        _courseProgressTile('3. Approach Control Procedures', 0.50, '50%', cardBg, primaryTxt),
        _courseProgressTile('4. Area Radar Control & RVSM', 0.20, '20%', cardBg, primaryTxt),
        _courseProgressTile('5. Aviation Meteorology (METAR)', 0.0, '0%', cardBg, primaryTxt),
      ],
    );
  }

  Widget _metricTile(String label, String value, IconData icon, Color accent, Color cardBg, Color txtColor) {
    return Card(
      color: cardBg,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: accent, size: 20),
            const SizedBox(height: 8),
            Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: txtColor)),
            const SizedBox(height: 2),
            Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey), overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }

  Widget _courseProgressTile(String courseName, double progress, String percentText, Color cardBg, Color txtColor) {
    return Card(
      color: cardBg,
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(courseName, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: txtColor))),
                Text(percentText, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF3D52D5))),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.black12,
              color: const Color(0xFF3D52D5),
              minHeight: 6,
            ),
          ],
        ),
      ),
    );
  }
}