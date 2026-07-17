import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantcare/core/colors_manager.dart';
import 'package:plantcare/core/styles_manager.dart';
import 'package:plantcare/core/validators/validators.dart';
import 'package:plantcare/features/auth/cubit/auth_cubit.dart';
import 'package:plantcare/features/auth/cubit/auth_states.dart';
import 'package:plantcare/features/auth/login/login_screen.dart';
import 'package:plantcare/features/auth/widgets/terms_checkbox_simple.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _termsAccepted = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool _isFormValid() {
    final emailValid = Validators.validateEmail(_emailController.text) == null;

    final passwordValid =
        Validators.validatePassword(_passwordController.text) == null;

    final confirmValid =
        _passwordController.text == _confirmPasswordController.text &&
        _confirmPasswordController.text.isNotEmpty;

    final termsAccepted = _termsAccepted;

    return emailValid && passwordValid && confirmValid && termsAccepted;
  }

  void _signUp() {
    if (_formKey.currentState?.validate() ?? false) {
      if (!_termsAccepted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please accept the terms & conditions'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }
      context.read<AuthCubit>().signUp(
        fullName: '',
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;
    final bool isTablet =
        MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < 1024;
    final bool isFormValid = _isFormValid();
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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Account created successfully! Please login.'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
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
                        left: 0,
                        right: isMobile ? 20 : (isTablet ? 60 : 90),
                        child: Column(
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
                      children: [
                        Text('Sign Up', style: StyleManager.black30header),

                        const SizedBox(height: 5),

                        Text(
                          'Create your Account',
                          style: StyleManager.black14org,
                        ),

                        SizedBox(height: 22.71),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter E-mail',
                          ),
                          validator: Validators.validateEmail,
                          onChanged: (value) => setState(() {}),
                        ),
                        SizedBox(height: 22.83),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter Password',
                          ),
                          validator: Validators.validatePassword,
                          onChanged: (value) => setState(() {}),
                        ),
                        SizedBox(height: 22.83),
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Confirm Password',
                            hintText: 'Enter Password',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          onChanged: (value) => setState(() {}),
                        ),
                        SizedBox(height: 10),
                        TermsCheckbox(
                          value: _termsAccepted,
                          onChanged: (value) {
                            setState(() {
                              _termsAccepted = value ?? false;
                            });
                          },
                        ),
                        SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed:
                                (state.status == AuthStatus.loading ||
                                    !isFormValid)
                                ? null
                                : _signUp,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isFormValid
                                  ? AppColor.backgroundButton
                                  : Colors.grey.shade400,
                              foregroundColor: AppColor.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: state.status == AuthStatus.loading
                                ? const SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    'SIGN UP',
                                    style: TextStyle(fontSize: 18),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: StyleManager.smallText,
                            ),
                            TextButton(
                              onPressed: () {
                                onPressed:
                                () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const LoginScreen(),
                                    ),
                                  );
                                };
                              },
                              child: Text(
                                'Log In',
                                style: StyleManager.textButton,
                              ),
                            ),
                          ],
                        ),
                      ],
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
