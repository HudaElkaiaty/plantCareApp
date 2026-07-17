import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantcare/core/colors_manager.dart';
import 'package:plantcare/core/styles_manager.dart';
import 'package:plantcare/core/validators/validators.dart';
import 'package:plantcare/core/utils/responsive_helper.dart';
import 'package:plantcare/features/auth/cubit/auth_cubit.dart';
import 'package:plantcare/features/auth/cubit/auth_states.dart';
import 'package:plantcare/features/auth/signup/signup_screen.dart';
import 'package:plantcare/features/auth/widgets/custom_text_form_field.dart';
import 'package:plantcare/features/home/home_screen.dart';

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

  void _login() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState == null) return;

    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    // Trigger login in AuthCubit
    context.read<AuthCubit>().login(email: email, password: password);
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final bool isMobile = deviceWidth < 600;
    final bool isTablet = deviceWidth >= 600 && deviceWidth < 1024;

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
            MaterialPageRoute(builder: (_) => const HomeScreen()),
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
                              onPressed: state.status == AuthStatus.loading
                                  ? null
                                  : _login,
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
                                style: TextStyle(
                                  fontSize: isMobile
                                      ? 16
                                      : (isTablet ? 20 : 24),
                                ),
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
                      child: const Center(
                        child: CircularProgressIndicator(color: AppColor.white),
                      ),
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
