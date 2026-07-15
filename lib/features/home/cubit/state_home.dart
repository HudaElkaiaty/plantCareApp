import 'package:plantcare/features/home/model/plant_model.dart';

class HomeStates {}

class HomeInitial extends HomeStates {}

class HomeLoading extends HomeStates {}

class HomeSuccess extends HomeStates {
  final List<PlantModel> plants;

  HomeSuccess({ required this.plants});
}

class HomeError extends HomeStates {
  final String message;

  HomeError({required this.message});
}
