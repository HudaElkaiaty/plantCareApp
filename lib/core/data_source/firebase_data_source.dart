import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Login
  Future<User?> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    }
  }

  /// Sign Up
  Future<User?> signUpWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password,
          );

      await _saveUserData(user: userCredential.user!, email: email.trim());

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    }
  }

  /// Save User Data
  Future<void> _saveUserData({
    required User user,
    required String email,
  }) async {
    await _firestore.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Get User Data
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(String uid) async {
    return _firestore.collection('users').doc(uid).get();
  }

  /// Reset Password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    }
  }

  /// Logout
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Auth State Changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Current User
  User? get currentUser => _auth.currentUser;

  /// Handle Firebase Errors
  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'invalid-credential':
        return 'Invalid email or password.';
      case 'email-already-in-use':
        return 'Email already in use.';
      case 'invalid-email':
        return 'Invalid email address.';
      case 'weak-password':
        return 'Password is too weak.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'network-request-failed':
        return 'Check your internet connection.';
      default:
        return e.message ?? 'Something went wrong.';
    }
  }
}
