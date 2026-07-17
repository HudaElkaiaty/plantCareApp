import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantcare/features/home/cubit/home_cubit.dart';
import 'package:plantcare/features/home/cubit/state_home.dart';
import 'package:plantcare/features/home/widgets/custom_plant.dart';

class OutdoorScreen extends StatelessWidget {
  const OutdoorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50),
        
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 50),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.green,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                  ),
                  SizedBox(width: 50),
                  Image.asset('assets/outdoorPlants.png'),
                   SizedBox(height: 30),
        
                  
                ],
        
              ),
            ),
              Expanded(
            child: BlocBuilder<HomeCubit, HomeStates>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is HomeSuccess) {
                   final outdoorPlants =
                  context.read<HomeCubit>().filterOutdoor(state.plants);
                  return SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: Column(
                        children: List.generate(
                          (outdoorPlants.length / 2).ceil(),
                          (rowIndex) {
                            final firstIndex = rowIndex * 2;
                            final secondIndex = firstIndex + 1;
                            final hasSecond =
                                secondIndex < outdoorPlants.length;

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Row(
                                mainAxisAlignment: hasSecond
                                    ? MainAxisAlignment.spaceBetween
                                    : MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width:
                                        (MediaQuery.of(context).size.width -
                                            56) /
                                        2,
                                    child: CustomPlant(
                                      plants: outdoorPlants[firstIndex],
                                    ),
                                  ),
                                  if (hasSecond)
                                    SizedBox(
                                      width:
                                          (MediaQuery.of(context).size.width -
                                              56) /
                                          2,
                                      child: CustomPlant(
                                        plants: outdoorPlants[secondIndex],
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
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            onPressed: () {
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              "Add to favorite",
              style: TextStyle(
                fontSize: 18,
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
  
