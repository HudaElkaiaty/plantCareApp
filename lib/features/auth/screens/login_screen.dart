import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_app/core/styles/colors_manager.dart';
import 'package:plant_app/core/styles/styles_manager.dart';
import 'package:plant_app/core/validators/validators.dart';
import 'package:plant_app/core/widgets/custom_text_form_field.dart';
import 'package:plant_app/features/Home/home_screen.dart';
import 'package:plant_app/features/auth/cubit/auth_cubit.dart';
import 'package:plant_app/features/auth/cubit/auth_states.dart';
import 'package:plant_app/features/auth/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); //mean-------
  @override
  void dispose() {
    //mean___---------------------
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().login(email: email, password: password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.error && state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );

          context.read<AuthCubit>().clearError();
        }

        if (state.status == AuthStatus.authenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColor.white,
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        'assets/leaves.png',
                        width: 500,
                        height: 270,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 45,
                        right: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Text(
                              'Plant Care',
                              style: StyleManager.white36header,
                            ),
                            Text(
                              'Farm at your fingertips',
                              style: StyleManager.white14org,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 37.89),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome Back',
                          style: StyleManager.black30header as TextStyle,
                        ),
                        SizedBox(height: 2.23),
                        Text(
                          'Log in to your account',
                          style: StyleManager.black14org as TextStyle,
                        ),
                        SizedBox(height: 11.71),
                        CustomTextFormField(
                          controller: _emailController,
                          labelText: 'Email',
                          hintText: 'name123@gmail.com',
                          keyboardType: TextInputType.emailAddress,
                          validator: Validators.validateEmail,
                        ),
                        SizedBox(height: 29.83),
                        CustomTextFormField(
                          controller: _passwordController,
                          labelText: 'Password',
                          hintText: '**********',
                          isPassword: true,
                          validator: Validators.validatePassword,
                        ),
                        SizedBox(height: 40),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.backgroundButton,
                              foregroundColor: AppColor.white,
                              shadowColor: AppColor.blurBackgroundButton,

                              padding: const EdgeInsets.symmetric(
                                vertical: 20.37,
                                horizontal: 100,
                              ),
                            ),
                            child: Text(
                              'Log In',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: StyleManager.smallText,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignupScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'SignUp',
                                style: StyleManager.textButton,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (state is AuthLoading)
                    Container(
                      color: Colors.black.withValues(alpha: 0.4),
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
