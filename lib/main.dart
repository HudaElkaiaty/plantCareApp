import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ==================== FIREBASE ====================
import 'package:plantcare/firebase_options.dart';

// ==================== DATA SOURCE ====================
import 'package:plantcare/core/data_source/firebase_data_source.dart';

// ==================== CUBITS ====================
import 'package:plantcare/features/auth/cubit/auth_cubit.dart';
import 'package:plantcare/features/home/cubit/home_cubit.dart';
import 'package:plantcare/features/profile/cubit/profile_cubit.dart';
import 'package:plantcare/features/your_plants/cubit/plants_cubit.dart';

// ==================== SCREENS ====================
import 'package:plantcare/features/splash/splash_screen.dart';
import 'package:plantcare/features/auth/login/login_screen.dart';

import 'package:plantcare/features/home/home_screen.dart';
import 'package:plantcare/features/indor_screen/indoor_screen.dart';
import 'package:plantcare/features/outdoor/outdoor_screen.dart';
import 'package:plantcare/features/care_tips/care_tips_screen.dart';
import 'package:plantcare/features/your_plants/your_plants_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Firebase initialization error: $e');
  }

  // Optional: Seed data
  // final FirebaseDataSource firebaseDataSource = FirebaseDataSource();
  // await firebaseDataSource.addPlants();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (_) => HomeCubit()..getPlant()),
        BlocProvider(create: (_) => ProfileCubit()..getUserProfile()),
        BlocProvider(create: (context) => MyPlantsCubit()..getMyPlants()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'PlantCare',
            theme: ThemeData(
              fontFamily: 'Poppins',
              primarySwatch: Colors.green,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.black),
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            initialRoute: '/splash',
            routes: {
              '/splash': (_) => const SplashScreen(),
              '/login': (_) => const LoginScreen(),

              '/home': (_) => const HomeScreen(),
              '/indoor': (_) => const IndoorScreen(),
              '/outdoor': (_) => const OutdoorScreen(),
              '/care_tips': (_) => const CareTipsScreen(),
              '/your_plants': (_) => const YourPlantsScreen(),
            },
            onGenerateRoute: (settings) {
              return null;
            },
          );
        },
      ),
    );
  }
}
