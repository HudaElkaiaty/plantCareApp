import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plantcare/features/home/model/plant_model.dart';

class FirebaseDataSource {
  // Firebase Instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ==================== AUTHENTICATION METHODS ====================

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

  // ==================== PLANTS METHODS ====================

  /// Add multiple plants to Firestore (for seeding data)
  Future<void> addPlants() async {
    final List<PlantModel> plantData = [
      PlantModel(
        name: 'Peperomia Plant',
        image: 'assets/Peperomia.png',
        description:
            'The leaves of Peperomia species are sometimes attractively coloured with veins or spots and are usually oval-shaped, thick, fleshy, and smooth-edged.',
        category: 'Indoor',
        size: 'Medium',
        plantType: 'Orchid',
        height: 12.6,
        humidity: 82,
      ),
      PlantModel(
        name: 'Green Potted Plant',
        image: 'assets/BirdofParadise.png',
        description:
            'A lovely topic! Green potted plants are great way to bring some natural beauty and freshness into your home or office. They come in a variety of shapes, sizes, and species, such as succulents, ferns, and peace lilies...Read More',
        category: 'Indoor',
        size: 'Medium',
        plantType: 'Palm',
        height: 40,
        humidity: 70,
      ),
      PlantModel(
        name: 'Red Anthurium',
        image: 'assets/red-anthurium.png',
        description:
            "Anthurium is a tropical flowering plant known for its glossy heart-shaped leaves and colorful blooms. It thrives in warm, humid environments with bright indirect light.",
        category: 'Indoor',
        size: 'Medium',
        plantType: 'Anthurium',
        height: 35,
        humidity: 80,
      ),
      PlantModel(
        name: 'Licuala grandis',
        image: 'assets/Licuala-grandis.png',
        description:
            'A tropical palm with large fan-shaped leaves. It thrives in bright indirect light and high humidity.',
        category: 'Indoor',
        size: 'Medium',
        plantType: 'Ruffled Fan Palm',
        height: 120,
        humidity: 60,
      ),
      PlantModel(
        name: 'Dracaena',
        image: 'assets/Dracaena.png',
        description:
            'Dracaena is an easy-care indoor plant with long glossy green leaves. It prefers bright indirect light and moderate watering.',
        category: 'Indoor',
        size: 'Medium',
        plantType: 'Corn Plant',
        height: 100,
        humidity: 40,
      ),
      PlantModel(
        name: 'Peace Lily',
        image: 'assets/PeaceLily.png',
        description:
            'Peace Lily is a popular indoor plant with elegant green leaves. It thrives in bright indirect light and helps improve indoor air quality.',
        category: 'Outdoor',
        size: 'Medium',
        plantType: 'Peace Lily',
        height: 45,
        humidity: 65,
      ),
      PlantModel(
        name: 'Eucalyptus',
        image: 'assets/Eucalyptus.png',
        description:
            'Eucalyptus is known for its round aromatic leaves and fresh appearance. It can be displayed in water or planted in soil with bright natural light.',
        category: 'Outdoor',
        size: 'Medium',
        plantType: 'Eucalyptus',
        height: 35,
        humidity: 55,
      ),
      PlantModel(
        name: 'Alocasia',
        image: 'assets/Alocasia.png',
        description:
            'Alocasia is a tropical plant recognized for its large arrow-shaped leaves. It grows best in warm conditions with high humidity and indirect sunlight.',
        category: 'Outdoor',
        size: 'Medium',
        plantType: 'Elephant Ear',
        height: 60,
        humidity: 75,
      ),
      PlantModel(
        name: 'Dried Flower Arrangement',
        image: 'assets/dried-flowers.png',
        description:
            'A decorative arrangement of naturally dried flowers that adds warmth and elegance to indoor spaces without requiring maintenance.',
        category: 'Outdoor',
        size: 'Small',
        plantType: 'Dried Flowers',
        height: 30,
        humidity: 0,
      ),
      PlantModel(
        name: 'Green Potted Plant',
        image: 'assets/BirdofParadise.png',
        description:
            'A lovely topic! Green potted plants are great way to bring some natural beauty and freshness into your home or office. They come in a variety of shapes, sizes, and species, such as succulents, ferns, and peace lilies...Read More',
        category: 'Outdoor',
        size: 'Medium',
        plantType: 'Palm',
        height: 40,
        humidity: 70,
      ),
    ];

    try {
      for (PlantModel plant in plantData) {
        await _firestore.collection('plants').add(plant.toJson());
      }
    } catch (e) {
      print('Error adding plants: $e');
      rethrow;
    }
  }

  /// Get all plants from Firestore
  Future<List<PlantModel>> getPlants() async {
    List<PlantModel> plants = [];
    try {
      QuerySnapshot snapshot = await _firestore.collection('plants').get();
      for (var doc in snapshot.docs) {
        plants.add(PlantModel.fromJson(doc.data() as Map<String, dynamic>));
      }
      return plants;
    } catch (e) {
      print('Error getting plants: $e');
      rethrow;
    }
  }

  /// Get plants by category
  Future<List<PlantModel>> getPlantsByCategory(String category) async {
    List<PlantModel> plants = [];
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('plants')
          .where('category', isEqualTo: category)
          .get();

      for (var doc in snapshot.docs) {
        plants.add(PlantModel.fromJson(doc.data() as Map<String, dynamic>));
      }
      return plants;
    } catch (e) {
      print('Error getting plants by category: $e');
      rethrow;
    }
  }

  /// Add a single plant
  Future<void> addPlant(PlantModel plant) async {
    try {
      await _firestore.collection('plants').add(plant.toJson());
    } catch (e) {
      print('Error adding plant: $e');
      rethrow;
    }
  }

  /// Update a plant
  Future<void> updatePlant(String docId, PlantModel plant) async {
    try {
      await _firestore.collection('plants').doc(docId).update(plant.toJson());
    } catch (e) {
      print('Error updating plant: $e');
      rethrow;
    }
  }

  /// Delete a plant
  Future<void> deletePlant(String docId) async {
    try {
      await _firestore.collection('plants').doc(docId).delete();
    } catch (e) {
      print('Error deleting plant: $e');
      rethrow;
    }
  }

  // ==================== ERROR HANDLING ====================

  /// Handle Firebase Authentication Errors
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
