import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  

  // Get current logged-in user
  User? get currentUser => _firebaseAuth.currentUser;

  // Listen to auth state changes
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Sign in with email & password
  Future<UserCredential> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Register new user (Firebase Auth + Firestore)
  Future<UserCredential> registerWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
    required String passwordConfirm,
  }) async {
    if (password != passwordConfirm) {
      throw Exception("Passwords do not match");
    }

    // Create user with email & password
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Update display name in Firebase Auth
    await userCredential.user?.updateDisplayName(name);

    // Save extra user info in Firestore
    await _firestore.collection('users').doc(userCredential.user?.uid).set({
      'name': name,
      'email': email,
      'createdAt': DateTime.now(),
    });

    return userCredential;
  }

  // Sign out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
