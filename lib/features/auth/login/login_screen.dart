import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_app/core/styles/colors_manager.dart';
import 'package:plant_app/core/styles/styles_manager.dart';
import 'package:plant_app/core/validators/validators.dart';
import 'package:plant_app/features/auth/widgets/custom_text_form_field.dart';
import 'package:plant_app/core/utils/responsive_helper.dart';
import 'package:plant_app/features/auth/cubit/auth_cubit.dart';
import 'package:plant_app/features/auth/cubit/auth_states.dart';
import 'package:plant_app/features/auth/signup/signup_screen.dart';

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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveHelper.isMobile(context);
    final bool isTablet = ResponsiveHelper.isTablet(context);

    

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
          Navigator.pushReplacementNamed(context, '/home');
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
                        width: double.infinity,
                        height: isMobile ? 220 : (isTablet ? 300 : 350),
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: isMobile ? 30 : 45,
                        right: isMobile ? 20 : (isTablet ? 60 : 90),
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
                  SizedBox(height: isMobile ? 20 : 30),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 24 : (isTablet ? 60 : 120),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Welcome Back', style: StyleManager.black30header),
                         SizedBox(height: isMobile ? 5 : 10),
                        Text(
                          'Log in to your account',
                          style: StyleManager.black14org,
                        ),
                        SizedBox(height: isMobile ? 20 : 30),
                        CustomTextFormField(
                          controller: _emailController,
                          labelText: 'Email',
                          hintText: 'name123@gmail.com',
                          keyboardType: TextInputType.emailAddress,
                          validator: Validators.validateEmail,
                        ),
                        SizedBox(height: isMobile ? 20 : 30),
                        CustomTextFormField(
                          controller: _passwordController,
                          labelText: 'Password',
                          hintText: '**********',
                          isPassword: true,
                          validator: Validators.validatePassword,
                        ),
                        SizedBox(height: isMobile ? 30 : 40),
                        Center(
                          child: SizedBox(
                            width: isMobile 
                                ? double.infinity 
                                : (isTablet ? 400 : 500),
                            height: isMobile ? 50 : 60,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/home');
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
                                style: TextStyle( fontSize: isMobile ? 16 : (isTablet ? 20 : 24),),
                              ),
                            ),
                          ),
                        ),
                         SizedBox(height: isMobile ? 20 : 30),
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
                         SizedBox(height: isMobile ? 20 : 30),
                      ],
                    ),
                  ),
                  if (state is AuthLoading)
                    Container(
                      color: Colors.black.withValues(alpha: 0.3),
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
