import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../commons/widgets/custom_button.dart';
import '../../../commons/widgets/social_button.dart';
import '../../../res/assets.dart';
import '../../../res/strings.dart';
import '../../../res/colors.dart';
import '../../../utils/snackbar_service.dart';
import '../controller/auth_controller.dart';
import '../widgets/reusable_auth_text_field.dart';
import 'login_screen.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});
  static String routeName = 'signup';
  static const routePath = '/signup';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // GlobalKey for form validation
  bool _isPasswordVisible = false;
  bool _isAgree = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey, // Set the formKey here
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                const Center(
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 5,),
                const Center(
                  child: Text(
                    "Fill your information",
                    style: TextStyle(
                        fontSize: 12,
                        color: AppColors.grey
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'First Name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                ReusableAuthTextField(
                  controller: _firstNameController,
                  hintText: 'John',
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty ) {
                      return 'Please enter an Username';
                    }
                    else if(value.length<2) {
                      return 'Username must be at least 2 characters long';

                    }
                    return null;
                  },
                ),
                const SizedBox(height: 5),
                const Text(
                  'Last Name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                ReusableAuthTextField(
                  controller: _lastNameController,
                  hintText: 'Doe',
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty ) {
                      return 'Please enter an Username';
                    }
                    else if(value.length<2) {
                      return 'Username must be at least 2 characters long';

                    }
                    return null;
                  },
                ),
                const SizedBox(height: 5),
                const Text(
                  'Email',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                ReusableAuthTextField(
                  controller: _emailController,
                  hintText: 'johndoe@gmail.com',
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email address';
                    } else if (!EmailValidator.validate(value)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 5),
                const Text(
                  'Password',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                ReusableAuthTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: !_isPasswordVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    } else if (value.length < 8) {
                      return 'Password must be at least 8 characters long';
                    } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$').hasMatch(value)) {
                      return 'Password must include uppercase, lowercase, number\n and special character';
                    }
                    return null;
                  },

                ),
                Row(
                  children: [
                    Checkbox(
                      checkColor: AppColors.theme,
                      value: _isAgree,
                      onChanged: (bool? value) {
                        setState(() {
                          _isAgree = value ?? false;
                        });
                      },
                      fillColor: WidgetStateProperty.all(AppColors.white),
                    ),

                    const Text('Agree with Terms & Conditions'),
                  ],
                ),
                const SizedBox(height: 20),
                CustomButton(
                  label: "Sign Up",
                  onPressedCallback: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      if (!_isAgree) {
                        SnackBarService.showSnackBar(
                          context: context,
                          message: 'Please agree to the Terms & Conditions',
                          backgroundColor: const Color.fromARGB(255, 227, 121, 113),
                        );
                        return;
                      }
                      // Call the signup function
                      ref.read(authControllerProvider.notifier)
                          .signUpUsingEmailPass(
                        email: _emailController.text.trim(),
                        password: _passwordController.text,
                        firstName: _firstNameController.text.trim(),
                        lastName: _lastNameController.text.trim(),

                        context: context,
                      );
                    } else {
                      SnackBarService.showSnackBar(
                        context: context,
                        message: AuthenticationMessages.fixError,
                        backgroundColor: const Color.fromARGB(255, 227, 121, 113),
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(child: Divider(color: AppColors.grey)),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('or'),
                    ),
                    Expanded(child: Divider(color: AppColors.grey)),
                  ],
                ),
                const SizedBox(height: 20),
                // Social Media Buttons (Google, Facebook, Apple)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialButton(
                      assetPath: ImageAssets.googleLogo,
                      onPressed: () {
                        // TODO: Implement Google login logic
                        SnackBarService.showSnackBar(
                          context: context,
                          message: 'Google login not yet implemented',
                          backgroundColor: const Color.fromARGB(255, 227, 121, 113),
                        );
                      },
                    ),
                    const SizedBox(width: 10,),
                    SocialButton(
                      assetPath: ImageAssets.facebookLogo,
                      onPressed: () {
                        // TODO: Implement Facebook login logic
                        SnackBarService.showSnackBar(
                          context: context,
                          message: 'Facebook login not yet implemented',
                          backgroundColor: const Color.fromARGB(255, 227, 121, 113),
                        );
                      },
                    ),
                    const SizedBox(width: 10,),
                    SocialButton(
                      assetPath: ImageAssets.appleLogo,
                      onPressed: () {
                        // TODO: Implement Apple login logic
                        SnackBarService.showSnackBar(
                          context: context,
                          message: 'Apple login not yet implemented',
                          backgroundColor: const Color.fromARGB(255, 227, 121, 113),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.black,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.push(LoginScreen.routePath);
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.theme,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ],

            ),
          ),
        ),
      ),
    );
  }
}
