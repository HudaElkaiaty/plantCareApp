class PlantModel {
  final String name;
  final String image;
  final String description;
  final String category;

  final String size;
  final String plantType;
  final double height;
  final int humidity;


  PlantModel({
    required this.name,
    required this.image,
    required this.description,
    required this.category,
  
    required this.size,
    required this.plantType,
    required this.height,
    required this.humidity,
   
  });

  factory PlantModel.fromJson(
      Map<String, dynamic> json, String id) {
    return PlantModel(
      name: json['name'],
      image: json['image'],
      description: json['description'],
      category: json['category'],
      
      size: json['size'],
      plantType: json['plantType'],
      height: (json['height'] as num).toDouble(),
      humidity: json['humidity'],
      
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'description': description,
      'category': category,
    
      'size': size,
      'plantType': plantType,
      'height': height,
      'humidity': humidity,
    };
  }
}