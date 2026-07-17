import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantcare/features/home/model/plant_model.dart';
import 'package:plantcare/features/your_plants/cubit/plants_cubit.dart';
import 'package:plantcare/features/your_plants/cubit/states.dart';
import 'package:plantcare/features/your_plants/widgets/my_plant_card.dart';

class YourPlantsScreen extends StatelessWidget {
  const YourPlantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          'My Plants',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E293B),
            fontSize: 20.sp,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 20.r),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/homeScreen',
              (route) => false,
            );
          },
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<MyPlantsCubit, MyPlantsStates>(
          builder: (context, state) {
            if (state is GetMyPlantsLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.green),
              );
            } else if (state is GetMyPlantsSuccess) {
              final myPlantsList = state.myPlants;

              if (myPlantsList.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.eco_outlined,
                        size: 80.sp,
                        color: Colors.grey[400],
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'No plants added yet!',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14.w,
                  mainAxisSpacing: 14.h,
                  childAspectRatio: 0.82,
                ),
                itemCount: myPlantsList.length,
                itemBuilder: (context, index) {
                  final plant = PlantModel.fromJson(myPlantsList[index]);

                  return MyPlantCard(plant: plant);
                },
              );
            } else if (state is GetMyPlantsError) {
              return Center(
                child: Text(
                  'Error: ${state.error}',
                  style: TextStyle(color: Colors.red, fontSize: 14.sp),
                ),
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
