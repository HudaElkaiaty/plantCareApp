import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantcare/features/home/model/plant_model.dart';
import 'package:plantcare/features/your_plants/cubit/plants_cubit.dart';
import 'package:plantcare/features/your_plants/cubit/states.dart';

class DetailsScreen extends StatelessWidget {
  final PlantModel plant;

  const DetailsScreen({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 500.w),

          child: SingleChildScrollView(
            child: Column(
              children: [
                /// Header
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30.r,
                        backgroundColor: Colors.green,
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                            size: 35.sp,
                          ),
                        ),
                      ),

                      const Spacer(),

                      Flexible(
                        child: Image.asset(
                          "assets/DetailsLogo.png",
                          height: 70.h,
                          fit: BoxFit.contain,
                        ),
                      ),

                      const Spacer(),

                      CircleAvatar(
                        radius: 30.r,
                        backgroundColor: Colors.grey,
                        child: IconButton(
                          onPressed: () {
                            // Favorite
                          },
                          icon: Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.white,
                            size: 35.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

                /// Plant Image
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Image.asset(
                      plant.image,
                      height: 220.h,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                /// Name & Rating
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          plant.name,
                          style: TextStyle(
                            fontSize: 22.sp,
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      Icon(Icons.star, color: Colors.amber, size: 18.sp),

                      SizedBox(width: 4.w),

                      Text(
                        "4.8",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(width: 4.w),

                      Text(
                        "(2256 Reviews)",
                        style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16.h),

                /// Description
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14.sp,
                        height: 1.5,
                      ),
                      children: [
                        TextSpan(text: plant.description),
                        TextSpan(
                          text: " Read More",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 24.h),

                /// Plant Info
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfoColumn("Size", plant.size),
                      _buildInfoColumn("Plant", plant.plantType),
                      _buildInfoColumn("Height", '${plant.height}"'),
                      _buildInfoColumn("Humidity", "${plant.humidity}%"),
                    ],
                  ),
                ),

                SizedBox(height: 40.h),

                /// Button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: BlocListener<MyPlantsCubit, MyPlantsStates>(
                      listener: (context, state) {
                        if (state is AddPlantToMyPlantsSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Added to My Plants successfully! 🎉',
                                style: TextStyle(fontSize: 14.sp),
                              ),
                              backgroundColor: Colors.green,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                          Navigator.pushNamed(context, '/yourPlantsScreen');
                        } 
                        
                        else if (state is AddPlantDuplicateState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'This plant is already in your list! 🌿',
                                style: TextStyle(fontSize: 14.sp),
                              ),
                              backgroundColor: Colors.amber,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        } 
                        
                        else if (state is AddPlantToMyPlantsError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Error: ${state.error}',
                                style: TextStyle(fontSize: 14.sp),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: ElevatedButton(
                        onPressed: () {
                          MyPlantsCubit.get(context).addPlantToMyPlants({
                            'name': plant.name,
                            'image': plant.image,
                            'description': plant.description,
                            'category': plant.category,
                            'size': plant.size,
                            'plantType': plant.plantType,
                            'height': plant.height,
                            'humidity': plant.humidity,
                          }, );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                        child: Text(
                          "ADD TO MY PLANTS",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey, fontSize: 12.sp),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
        ),
      ],
    );
  }
}
