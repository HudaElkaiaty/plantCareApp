import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantcare/core/data_source/firebase_data_source.dart';
import 'package:plantcare/features/home/cubit/state_home.dart';
import 'package:plantcare/features/home/model/plant_model.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitial());
  FirebaseDataSource dataSource = FirebaseDataSource();
  List<PlantModel> plants = [];
  List<PlantModel> filteredPlants = [];

  Future<void> getPlant() async {
    emit(HomeInitial());
       try {
      plants = await dataSource.getData();
      emit(HomeSuccess(plants: plants));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  void filterMeals(String query) {
    emit(HomeLoading());

    try {
      filteredPlants = plants.where((meal) {
        return meal.plantType == query;
      }).toList();
      emit(HomeSuccess(plants: filteredPlants));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }
    List<PlantModel> filterIndoor(List<PlantModel> plants) {
    return plants
        .where((plant) => plant.category == "Indoor")
        .toList();
  }

  List<PlantModel> filterOutdoor(List<PlantModel> plants) {
    return plants
        .where((plant) => plant.category == "Outdoor")
        .toList();
  }
}
  

