import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_app/core/styles/colors_manager.dart';
import 'package:plant_app/core/styles/styles_manager.dart';
import 'package:plant_app/core/validators/validators.dart';
import 'package:plant_app/core/widgets/custom_text_form_field.dart';
import 'package:plant_app/core/widgets/terms_checkbox_simple.dart';
import 'package:plant_app/features/auth/cubit/auth_cubit.dart';

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
  bool _isEmailValid = false;
  bool _isPasswordValid = false;
  bool _isConfirmPasswordValid = false;

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
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 45,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Text('Plant Care', style: StyleManager.white36header),
                        Text(
                          'Farm at your fingertips',
                          style: StyleManager.white14org,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 38),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sign Up', style: StyleManager.black30header),

                    const SizedBox(height: 5),

                    Text('Create your Account', style: StyleManager.black14org),

                    SizedBox(height: 22.71),
                    CustomTextFormField(
                      controller: _emailController,
                      labelText: 'Email',
                      hintText: 'Enter E-mail',
                      keyboardType: TextInputType.emailAddress,
                      validator: Validators.validateEmail,
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 22.83),
                    CustomTextFormField(
                      controller: _passwordController,
                      labelText: 'Password',
                      hintText: 'Enter Password',
                      isPassword: true,
                      validator: Validators.validatePassword,
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 22.83),
                    CustomTextFormField(
                      controller: _confirmPasswordController,
                      labelText: 'Confirm Password',
                      hintText: 'Enter Password',
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {});
                      },
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
                        onPressed: _isFormValid() ? _signUp : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isFormValid()
                              ? AppColor.backgroundButton
                              : Colors.grey.shade400,
                          foregroundColor: AppColor.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'SIGN UP',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: StyleManager.smallText,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Log In', style: StyleManager.textButton),
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
  }
}
