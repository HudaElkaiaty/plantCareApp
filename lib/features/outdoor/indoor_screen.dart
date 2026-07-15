import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantcare/features/home/cubit/home_cubit.dart';
import 'package:plantcare/features/home/cubit/state_home.dart';
import 'package:plantcare/features/home/widget/custom_plant.dart';

class IndoorScreen extends StatelessWidget {
  const IndoorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 50.h),

            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 50.w),
                  CircleAvatar(
                    radius: 30.r,
                    backgroundColor: Colors.green,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                        size: 35.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 50.w),
                  Image.asset("assets/indoorLogo.png"),
                ],
              ),
            ),

            Expanded(
              child: BlocBuilder<HomeCubit, HomeStates>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is HomeSuccess) {
                    final indoorPlants =
                        context.read<HomeCubit>().filterIndoor(state.plants);

                    return SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 20.h,
                      ),
                      child: Column(
                        children: List.generate(
                          (indoorPlants.length / 2).ceil(),
                          (rowIndex) {
                            final firstIndex = rowIndex * 2;
                            final secondIndex = firstIndex + 1;
                            final hasSecond =
                                secondIndex < indoorPlants.length;

                            return Padding(
                              padding: EdgeInsets.only(bottom: 16.h),
                              child: Row(
                                mainAxisAlignment: hasSecond
                                    ? MainAxisAlignment.spaceBetween
                                    : MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width:
                                        (MediaQuery.of(context).size.width -
                                                56.w) /
                                            2,
                                    child: CustomPlant(
                                      plants: indoorPlants[firstIndex],
                                    ),
                                  ),
                                  if (hasSecond)
                                    SizedBox(
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  56.w) /
                                              2,
                                      child: CustomPlant(
                                        plants: indoorPlants[secondIndex],
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(
          20.w,
          0,
          20.w,
          20.h,
        ),
        child: SizedBox(
          width: double.infinity,
          height: 55.h,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
            child: Text(
              "Add to favorite",
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}