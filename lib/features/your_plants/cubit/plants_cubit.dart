import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantcare/core/data_source/firebase_data_source.dart';
import 'package:plantcare/features/your_plants/cubit/states.dart';

class MyPlantsCubit extends Cubit<MyPlantsStates> {
  MyPlantsCubit() : super(MyPlantsInitial());

static MyPlantsCubit get(BuildContext context) => BlocProvider.of<MyPlantsCubit>(context);
final FirebaseDataSource _dataSource = FirebaseDataSource();
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<dynamic> myPlantsList = [];

  Future<void> addPlantToMyPlants(Map<String, dynamic> plantData) async {
    bool isAlreadyAdded = myPlantsList.any((plant) => plant['name'] == plantData['name']);

    if (isAlreadyAdded) {
      emit(AddPlantDuplicateState()); 
      return; 
    }

    emit(AddPlantToMyPlantsLoading()); 
    
    try {
      await _firestore.collection('my_plants').doc(plantData['name']).set(plantData);
      emit(AddPlantToMyPlantsSuccess()); 
      
      emit(GetMyPlantsSuccess(myPlantsList)); 
    } catch (e) {
      emit(AddPlantToMyPlantsError(e.toString())); 
    }
  }

  void getMyPlants() {
    emit(GetMyPlantsLoading());
    
    _dataSource.getMyPlantsStream().listen((snapshot) {
      
      List<dynamic> loadedPlants = snapshot.docs.map((doc) {
        var data = doc.data();
        data['id'] = doc.id; 
        return data;
      }).toList();
      
      myPlantsList = loadedPlants;
      emit(GetMyPlantsSuccess(loadedPlants));
      
    }, onError: (error) {
      emit(GetMyPlantsError(error.toString()));
    });
  
}

Future<void> waterPlant(String plantName) async {
  try {
    await _firestore.collection('my_plants').doc(plantName).update({
      'lastWatered': DateTime.now().toIso8601String(),
    });
  } catch (e) {
    emit(GetMyPlantsError(e.toString()));
  }
}

Future<void> toggleReminder(String plantName, bool isActive) async {
  try {
    await _firestore.collection('my_plants').doc(plantName).update({
      'isReminderActive': isActive,
    });
  } catch (e) {
    emit(GetMyPlantsError(e.toString()));
  }
}

}