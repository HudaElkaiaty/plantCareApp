import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantcare/features/care_tips/care_tips_screen.dart';
import 'package:plantcare/features/home/cubit/home_cubit.dart';
import 'package:plantcare/features/home/home_screen.dart';
import 'package:plantcare/features/indor_screen/indoor_screen.dart';
import 'package:plantcare/features/outdoor/outdoor_screen.dart';
import 'package:plantcare/features/profile/cubit/profile_cubit.dart';
import 'package:plantcare/firebase_options.dart';
import 'package:plantcare/core/data_source/firebase_data_source.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseDataSource firebaseDataSource = FirebaseDataSource();

  // await firebaseDataSource.addPlant();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeCubit()..getPlant()),
        BlocProvider(create: (_) => ProfileCubit()..getUserProfile()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/homeScreen',
            routes: {
              '/homeScreen': (_) => const HomeScreen(),
              '/indoorScreen': (_) => const IndoorScreen(),
              '/outdoorScreen': (_) => const OutdoorScreen(),
              '/care_tips': (_) => const CareTipsScreen(),
            },
          );
        },
      ),
    );
  }
}
