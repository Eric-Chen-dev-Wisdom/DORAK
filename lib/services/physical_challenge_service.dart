import 'dart:async';
import 'dart:math';
import 'package:sensors_plus/sensors_plus.dart';

/// Service to detect physical challenges using device sensors
class PhysicalChallengeService {
  StreamSubscription? _accelerometerSubscription;
  StreamSubscription? _gyroscopeSubscription;

  // Shake detection parameters
  static const double shakeThreshold = 15.0; // m/s²
  DateTime? _lastShakeTime;
  int _shakeCount = 0;

  // Tilt detection parameters
  double _currentTiltX = 0;
  double _currentTiltY = 0;

  /// Start detecting shake gestures
  /// [onShakeDetected] callback when shake is detected
  /// [requiredShakes] number of shakes needed (default: 3)
  void startShakeDetection({
    required Function() onShakeDetected,
    int requiredShakes = 3,
  }) {
    _shakeCount = 0;
    _accelerometerSubscription = accelerometerEventStream().listen((event) {
      final now = DateTime.now();

      // Calculate total acceleration (magnitude)
      final acceleration =
          sqrt(event.x * event.x + event.y * event.y + event.z * event.z);

      // Check if acceleration exceeds threshold
      if (acceleration > shakeThreshold) {
        // Prevent multiple counts within 500ms
        if (_lastShakeTime == null ||
            now.difference(_lastShakeTime!).inMilliseconds > 500) {
          _shakeCount++;
          _lastShakeTime = now;
          print('🎯 Shake detected! Count: $_shakeCount/$requiredShakes');

          if (_shakeCount >= requiredShakes) {
            onShakeDetected();
            stopShakeDetection();
          }
        }
      }
    });
  }

  /// Stop shake detection
  void stopShakeDetection() {
    _accelerometerSubscription?.cancel();
    _accelerometerSubscription = null;
    _shakeCount = 0;
    _lastShakeTime = null;
  }

  /// Start detecting tilt gestures
  /// [onTiltDetected] callback when device is tilted beyond threshold
  /// [tiltThreshold] angle threshold in degrees (default: 45)
  void startTiltDetection({
    required Function(String direction) onTiltDetected,
    double tiltThreshold = 45.0,
  }) {
    _gyroscopeSubscription = gyroscopeEventStream().listen((event) {
      // Update current tilt
      _currentTiltX = event.x;
      _currentTiltY = event.y;

      // Convert to degrees (approximate)
      final tiltXDegrees = _currentTiltX * 57.2958; // radians to degrees
      final tiltYDegrees = _currentTiltY * 57.2958;

      String? direction;

      if (tiltXDegrees.abs() > tiltThreshold) {
        direction = tiltXDegrees > 0 ? 'right' : 'left';
      } else if (tiltYDegrees.abs() > tiltThreshold) {
        direction = tiltYDegrees > 0 ? 'forward' : 'backward';
      }

      if (direction != null) {
        onTiltDetected(direction);
      }
    });
  }

  /// Stop tilt detection
  void stopTiltDetection() {
    _gyroscopeSubscription?.cancel();
    _gyroscopeSubscription = null;
  }

  /// Clean up all subscriptions
  void dispose() {
    stopShakeDetection();
    stopTiltDetection();
  }

  /// Check if sensors are available on this device
  Future<bool> areSensorsAvailable() async {
    try {
      // Try to get one reading from accelerometer
      await accelerometerEventStream()
          .first
          .timeout(const Duration(seconds: 2));
      return true;
    } catch (e) {
      print('⚠️ Sensors not available: $e');
      return false;
    }
  }
}
