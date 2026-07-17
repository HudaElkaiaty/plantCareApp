abstract class MyPlantsStates {}
class MyPlantsInitial extends MyPlantsStates {}

class GetMyPlantsLoading extends MyPlantsStates {}

class GetMyPlantsSuccess extends MyPlantsStates {
  final List<dynamic> myPlants; 
  GetMyPlantsSuccess(this.myPlants);
}

class GetMyPlantsError extends MyPlantsStates {
  final String error;
  GetMyPlantsError(this.error);
}


class AddPlantToMyPlantsLoading extends MyPlantsStates {}

class AddPlantDuplicateState extends MyPlantsStates {}

class AddPlantToMyPlantsSuccess extends MyPlantsStates {}

class AddPlantToMyPlantsError extends MyPlantsStates {
  final String error;
  AddPlantToMyPlantsError(this.error);
}