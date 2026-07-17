import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantcare/features/your_plants/cubit/states.dart';

class MyPlantsCubit extends Cubit<MyPlantsStates> {
  MyPlantsCubit() : super(MyPlantsInitial());

  static MyPlantsCubit get(context) => BlocProvider.of(context);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addPlantToMyPlants(Map<String, dynamic> plantData) async {
    bool isAlreadyAdded = false;
    if (state is GetMyPlantsSuccess) {
      final currentPlants = (state as GetMyPlantsSuccess).myPlants;
      isAlreadyAdded = currentPlants.any((plant) => plant['name'] == plantData['name']);
    }

    if (isAlreadyAdded) {
      emit(AddPlantDuplicateState()); 
      return; 
    }

    emit(AddPlantToMyPlantsLoading()); 
    
    try {
      await _firestore.collection('my_plants').add(plantData); 
      emit(AddPlantToMyPlantsSuccess()); 
      getMyPlants();
    } catch (e) {
      emit(AddPlantToMyPlantsError(e.toString())); 
    }
  }

  void getMyPlants() {
    emit(GetMyPlantsLoading());
    
    _firestore.collection('my_plants').snapshots().listen((snapshot) {
      
      List<dynamic> loadedPlants = snapshot.docs.map((doc) {
        var data = doc.data();
        data['id'] = doc.id; 
        return data;
      }).toList();
      
      emit(GetMyPlantsSuccess(loadedPlants));
      
    }, onError: (error) {
      emit(GetMyPlantsError(error.toString()));
    });
  }
}