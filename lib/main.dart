import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_app/features/auth/cubit/auth_cubit.dart';
import 'package:plant_app/features/auth/cubit/auth_states.dart';
import 'package:plant_app/features/auth/login/login_screen.dart';
import 'package:plant_app/features/splash/splash_screen.dart';
import 'package:plant_app/firebase_options.dart' as firebase_options;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:
        firebase_options.DefaultFirebaseOptions.currentPlatform
            as FirebaseOptions?,
  );
  runApp(const MyPlant());
}

class MyPlant extends StatelessWidget {
  const MyPlant({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => AuthCubit())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
