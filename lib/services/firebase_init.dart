import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseInit {
  static bool _initialized = false;
  static bool useEmulators = true;

  static Future<void> initialize() async {
    if (_initialized) return;
    
    try {
      print('🟡 Starting Firebase initialization...');
      await Firebase.initializeApp();
      print('🟡 Firebase core initialized');
      
      if (useEmulators) {
        print('🟡 Setting up emulators...');
        await _connectToEmulators();
      }
      
      _initialized = true;
      print('✅ Firebase initialized ${useEmulators ? 'with EMULATORS' : 'with LIVE PROJECT'}');
      
      // Test the connection
      print('🟡 Testing Firebase connection...');
      final success = await testConnection();
      if (success) {
        print('✅ Firebase connection test PASSED');
      } else {
        print('❌ Firebase connection test FAILED');
      }
      
    } catch (e) {
      print('❌ Firebase initialization failed: $e');
      print('❌ Stack trace: ${e.toString()}');
      rethrow;
    }
  }

  static Future<void> _connectToEmulators() async {
    try {
      // Use 10.0.2.2 for Android emulator to access host machine
      const host = '10.0.2.2';
      
      print('🟡 Configuring Firestore emulator: $host:8080');
      
      // Firestore Emulator - CRITICAL: Clear any cached credentials
      await FirebaseAuth.instance.signOut(); // Clear any existing auth state
      
      FirebaseFirestore.instance.useFirestoreEmulator(host, 8080);
      FirebaseFirestore.instance.settings = const Settings(
        persistenceEnabled: false,
        sslEnabled: false,
      );

      print('🟡 Configuring Auth emulator: $host:9099');
      
      // Auth Emulator - Force clear any tokens
      await FirebaseAuth.instance.useAuthEmulator(host, 9099);
      
      // Clear any existing users and sign in fresh
      await FirebaseAuth.instance.signOut();
      
      print('✅ Connected to Firebase Emulators');
      print('   - Firestore: $host:8080');
      print('   - Auth: $host:9099');
      print('   - Emulator UI: http://localhost:4000');
      
    } catch (e) {
      print('❌ Error connecting to emulators: $e');
      print('❌ Stack trace: ${e.toString()}');
      rethrow;
    }
  }

  // Test connection method - WITHOUT authentication
  static Future<bool> testConnection() async {
    try {
      print('🟡 Testing Firestore connection without auth...');
      
      // Use a simple write/read operation that doesn't require complex auth
      final testDoc = FirebaseFirestore.instance.collection('__test_connection__').doc('test');
      await testDoc.set({
        'test': true,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
      
      final snapshot = await testDoc.get();
      if (snapshot.exists) {
        print('✅ Firestore connection test successful');
        await testDoc.delete(); // Clean up
        return true;
      } else {
        print('❌ Test document was not created properly');
        return false;
      }
      
    } catch (e) {
      print('❌ Firestore connection test failed: $e');
      return false;
    }
  }

  // Method to manually clear auth state if needed
  static Future<void> clearAuthState() async {
    try {
      await FirebaseAuth.instance.signOut();
      print('✅ Auth state cleared');
    } catch (e) {
      print('❌ Error clearing auth state: $e');
    }
  }
}