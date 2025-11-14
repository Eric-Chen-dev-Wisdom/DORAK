import 'package:flutter/material.dart';

class AppConstants {
  // Colors inspired by Kuwaiti flag
  static const Color primaryRed = Color(0xFFCE1126);
  static const Color primaryGreen = Color(0xFF007A3D);
  static const Color primaryBlack = Color(0xFF000000);
  static const Color primaryWhite = Color(0xFFFFFFFF);
  static const Color backgroundColor = Color(0xFFF8F9FA);
  static const Color textColor = Color(0xFF333333);

  // Game constants
  static const int defaultRoundTime = 60; // seconds
  static const int maxPlayersPerTeam = 5;
  static const int roomCodeLength = 6;

  // Font sizes
  static const double headingSize = 28.0;
  static const double titleSize = 22.0;
  static const double bodySize = 16.0;
  static const double captionSize = 14.0;

  // Sample categories for prototype
  static const List<Map<String, dynamic>> sampleCategories = [
    {
      'id': 'movies_foreign',
      'name': '🎬 Foreign Movies',
      'type': 'trivia',
    },
    {
      'id': 'movies_arabic',
      'name': '🎞 Arabic Movies',
      'type': 'trivia',
    },
    {
      'id': 'karaoke',
      'name': '🎤 Karaoke',
      'type': 'karaoke',
    },
    {
      'id': 'animals',
      'name': '🐘 Animals',
      'type': 'trivia',
    },
    {
      'id': 'physical',
      'name': '💪 Physical Challenges',
      'type': 'physical',
    },
  ];
}
