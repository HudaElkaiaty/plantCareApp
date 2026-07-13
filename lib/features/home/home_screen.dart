import 'package:flutter/material.dart';

import 'package:plantcare/features/home/widgets/plant_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
          
              Center(
                child: Image.asset("assets/welcome.png"),
              ),
          
              const SizedBox(height: 60),
          
              PlantList(
                
              ),
          
             
          
              Image.asset(
                "assets/nature.png",
                height: 436,
                width: 426,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}