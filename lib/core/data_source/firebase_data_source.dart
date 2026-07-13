import 'package:plantcare/features/home/model/plant_model.dart';

class FirebaseDataSource {
  final FirebaseDataSource firebaseDataSource = FirebaseDataSource();
  Future<void> addPlant() async {
    final List<PlantModel> plantData =[
  PlantModel(
 
   name: 'Peperomia Plant',
    image: 'assets/Peperomia.png',
     description: 'The leaves of Peperomia species are sometimes attractively coloured with veins or spots and are usually oval-shaped, thick, fleshy, and smooth-edged.',
      category: 'Indoor',
       size: 'Medium',
        plantType:'Orchid' ,
         height: 12.6,
          humidity: 82,
           ),
    PlantModel(
      name: 'Green Potted Plant',
       image: '',
        description: 'A lovely topic! Green potted plants are great way to bring some natural beauty and freshness into your home or office. They come in a variety of shapes, sizes, and species, such as succulents, ferns, and peace lilies...Read More',
         category:'Indoor',
          size: 'Medium',
           plantType: plantType, height: height, humidity: humidity)
    ];
  }
}
