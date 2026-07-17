class PlantModel {
  final String name;
  final String image;
  final String description;
  final String category;

  final String size;
  final String plantType;
  final double height;
  final int humidity;

  final String? lastWatered;
  final int wateringIntervalInDays;
  final bool isReminderActive;

  PlantModel({
    required this.name,
    required this.image,
    required this.description,
    required this.category,

    required this.size,
    required this.plantType,
    required this.height,
    required this.humidity,

    this.lastWatered,
    this.wateringIntervalInDays = 3,
    this.isReminderActive = false,
  });

  factory PlantModel.fromJson(Map<String, dynamic> json) {
    return PlantModel(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',

      size: json['size'] ?? '',
      plantType: json['plantType'] ?? '',
      height: (json['height'] as num?)?.toDouble() ?? 0.0,
      humidity: json['humidity'] as int? ?? 0,

      lastWatered: json['lastWatered'] as String?, // ده عادي يقبل null
      // 👇 هنا بقى بنأمن المتغيرات اللي كانت بتضرب null
      wateringIntervalInDays: json['wateringIntervalInDays'] as int? ?? 3,
      isReminderActive: json['isReminderActive'] as bool? ?? false,
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

      'lastWatered': lastWatered,
      'wateringIntervalInDays': wateringIntervalInDays,
      'isReminderActive': isReminderActive,
    };
  }
}
