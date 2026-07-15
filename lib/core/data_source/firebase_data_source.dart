import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plantcare/features/home/model/plant_model.dart';

class FirebaseDataSource {
  
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addPlant() async {
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
            'racaena is an easy-care indoor plant with long glossy green leaves. It prefers bright indirect light and moderate watering.',
        category: 'Indoor',
        size: 'Medium',
        plantType: ' Corn Plant',
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
      print(e);
    }
  }

  Future<List<PlantModel>> getData() async {
    List<PlantModel> plants = [];
    try {
      QuerySnapshot snapshot = await _firestore.collection('plants').get();
      for (var doc in snapshot.docs) {
        plants.add(PlantModel.fromJson(doc.data() as Map<String, dynamic>));
      }
      return plants;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}


