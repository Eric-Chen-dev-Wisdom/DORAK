import 'package:shared_preferences/shared_preferences.dart';

class GuestService {
  static String? _guestId;
  static String? _guestName;
  static const String _guestIdKey = 'guest_id';
  static const String _guestNameKey = 'guest_name';

  // Initialize guest data from local storage
  static Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    _guestId = prefs.getString(_guestIdKey);
    _guestName = prefs.getString(_guestNameKey);
  }

  // Generate or retrieve guest ID
  static Future<String> getGuestId() async {
    if (_guestId == null) {
      await initialize();
      if (_guestId == null) {
        _guestId = 'guest_${DateTime.now().millisecondsSinceEpoch}';
        // Save to local storage
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_guestIdKey, _guestId!);
      }
    }
    return _guestId!;
  }

  // Generate or retrieve guest name
  static Future<String> getGuestName() async {
    if (_guestName == null) {
      await initialize();
      if (_guestName == null) {
        // Use different calculation for name vs ID
        final randomSuffix = DateTime.now().microsecondsSinceEpoch % 10000;
        _guestName = 'Guest$randomSuffix';
        // Save to local storage
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_guestNameKey, _guestName!);
      }
    }
    return _guestName!;
  }

  // Check if user is guest
  static bool isGuest() {
    return _guestId != null;
  }

  // Get guest user data
  static Future<Map<String, dynamic>> getGuestUser() async {
    return {
      'id': await getGuestId(),
      'name': await getGuestName(),
      'isGuest': true,
      'joinedAt': DateTime.now().toIso8601String(),
    };
  }

  // Clear guest session (for logout)
  static Future<void> clearGuestSession() async {
    _guestId = null;
    _guestName = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_guestIdKey);
    await prefs.remove(_guestNameKey);
  }
}