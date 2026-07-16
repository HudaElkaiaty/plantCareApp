import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:plant_app/features/auth/cubit/auth_cubit.dart';
import 'package:plant_app/features/auth/cubit/auth_states.dart';
import 'package:plant_app/features/auth/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthAuthenticated) {
              return const HomeScreen();
            } else if (state is AuthLoading) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            } else {
              return const LoginScreen();
            }
          },
        ),
      ),
    );
  }
} // test

// Simple HomeScreen placeholder to fix missing class error.
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(child: Text('Welcome')),
    );
  }
}
