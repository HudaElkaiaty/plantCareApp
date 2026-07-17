import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:plantcare/core/color_manager.dart'; 
import 'package:plantcare/core/style_manager.dart'; 
import 'package:plantcare/features/home/model/plant_model.dart';
import 'package:plantcare/features/your_plants/cubit/plants_cubit.dart';
import 'package:plantcare/features/your_plants/cubit/states.dart';

class MyPlantDetailsScreen extends StatelessWidget {
  const MyPlantDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final plantIndex = ModalRoute.of(context)!.settings.arguments as int;
    return BlocBuilder<MyPlantsCubit, MyPlantsStates>(
      builder: (context, state) {
        final cubit = MyPlantsCubit.get(context);
        final plant = cubit.myPlantsList[plantIndex];
        
        // calculations
        DateTime? lastWateredDate = plant.lastWatered != null
            ? DateTime.parse(plant.lastWatered!)
            : null;
        DateTime nextWateringDate = (lastWateredDate ?? DateTime.now()).add(
          Duration(days: plant.wateringIntervalInDays),
        );
        int daysLeft = nextWateringDate.difference(DateTime.now()).inDays;

        String lastWateredText = lastWateredDate != null
            ? DateFormat('yyyy-MM-dd hh:mm a').format(lastWateredDate)
            : 'Never watered yet';

        String statusText = daysLeft <= 0
            ? 'Needs water today! ⚠️'
            : 'In $daysLeft days';

        return Scaffold(
          backgroundColor: ColorManager.lightSlateBackground, 
          appBar: AppBar(
            title: Text(
              plant.name,
              style: StyleManager.sectionTitleStyle.copyWith(fontSize: 18.sp), 
            ),
            backgroundColor: ColorManager.whiteColor, 
            foregroundColor: ColorManager.textDarkBody,
            elevation: 0,
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 250.h,
                  width: double.infinity,
                  color: ColorManager.chipBackground,
                  child: Image.asset(plant.image, fit: BoxFit.contain),
                ),

                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: ColorManager.whiteColor,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: ColorManager.detailShadowColor, 
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.notifications_active_outlined,
                                      color: ColorManager.greenColor, 
                                      size: 24.r,
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      'Active Care Reminder',
                                      style: StyleManager.reminderTitleStyle, 
                                    ),
                                  ],
                                ),
                                Switch(
                                  value: plant.isReminderActive,
                                  activeThumbColor: ColorManager.greenColor, 
                                  activeTrackColor: ColorManager.chipBackground,
                                  onChanged: (value) {
                                    MyPlantsCubit.get(context).toggleReminder(plant.name, value);
                                  },
                                ),
                              ],
                            ),
                            const Divider(color: ColorManager.dividerColor),
                            SizedBox(height: 8.h),

                            // معلومات السقاية
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Last Watered:',
                                  style: StyleManager.cardDescriptionStyle,
                                ),
                                Text(
                                  lastWateredText,
                                  style: StyleManager.reminderValueStyle, 
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Next Watering:',
                                  style: StyleManager.cardDescriptionStyle,
                                ),
                                Text(
                                  statusText,
                                  style: StyleManager.cardTitleStyle.copyWith(
                                    color: daysLeft <= 0
                                        ? ColorManager.errorRed 
                                        : ColorManager.greenColor, 
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 16.h),

                            ElevatedButton.icon(
                              onPressed: () {
                                MyPlantsCubit.get(context).waterPlant(plant.name);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Plant marked as watered! 💧'),
                                    backgroundColor: ColorManager.greenColor,
                                  ),
                                );
                              },
                              icon: Icon(Icons.water_drop, size: 18.r),
                              label: Text(
                                'I Watered It Today',
                                style: StyleManager.buttonTextStyle, 
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorManager.greenColor, 
                                foregroundColor: ColorManager.whiteColor, 
                                minimumSize: Size(double.infinity, 45.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                elevation: 0,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20.h),

                      Text(
                        'Plant Information',
                        style: StyleManager.cardTitleStyle,
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildInfoCard('Type', plant.plantType, Icons.nature),
                          _buildInfoCard('Size', plant.size, Icons.straighten),
                          _buildInfoCard(
                            'Humidity',
                            '${plant.humidity}%',
                            Icons.wb_cloudy_outlined,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Container(
      width: 100.w,
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.shadowColor, 
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: ColorManager.greenColor, size: 20.r), 
          SizedBox(height: 4.h),
          Text(
            title,
            style: StyleManager.cardDescriptionStyle.copyWith(fontSize: 11.sp),
          ),
          SizedBox(height: 2.h),
          Text(
            value,
            style: StyleManager.cardTitleStyle.copyWith(fontSize: 12.sp), 
          ),
        ],
      ),
    );
  }
}