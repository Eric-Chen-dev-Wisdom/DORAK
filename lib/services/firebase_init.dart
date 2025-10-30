// services/firebase_init.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseInit {
  static bool _initialized = false;
  static bool useEmulators = true;

  static Future<void> initialize() async {
    if (_initialized) return;
    
    try {
      await Firebase.initializeApp();
      
      if (useEmulators) {
        await _connectToEmulators();
      }
      
      _initialized = true;
      print('✅ Firebase initialized ${useEmulators ? 'with EMULATORS' : 'with LIVE PROJECT'}');
    } catch (e) {
      print('❌ Firebase initialization failed: $e');
    }
  }

  static Future<void> _connectToEmulators() async {
    try {
      // Use 10.0.2.2 for Android emulator to access host machine
      const host = '10.0.2.2';
      
      // Firestore Emulator
      FirebaseFirestore.instance.useFirestoreEmulator(host, 8080);

      // Auth Emulator  
      await FirebaseAuth.instance.useAuthEmulator(host, 9099);
      
      print('✅ Connected to Firebase Emulators');
      print('   - Firestore: $host:8080');
      print('   - Auth: $host:9099');
      print('   - Emulator UI: http://localhost:4000');
    } catch (e) {
      print('❌ Error connecting to emulators: $e');
    }
  }

  // Test connection method
  static Future<bool> testConnection() async {
    try {
      await FirebaseFirestore.instance
          .collection('test')
          .doc('connection')
          .set({'test': true, 'timestamp': DateTime.now()});
      return true;
    } catch (e) {
      print('❌ Firebase test failed: $e');
      return false;
    }
  }
}