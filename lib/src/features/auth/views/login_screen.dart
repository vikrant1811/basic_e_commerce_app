import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../commons/widgets/custom_button.dart';
import '../../../commons/widgets/social_button.dart';
import '../../../res/assets.dart';
import '../../../res/colors.dart';
import '../../../res/strings.dart';
import '../../../utils/snackbar_service.dart';
import '../controller/auth_controller.dart';
import '../forgot_password/forgot_password_screen.dart';
import '../widgets/reusable_auth_text_field.dart';
import 'Signup_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  static String routeName = 'login';
  static const routePath = '/login';

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  bool isPasswordVisible = false;
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                const Center(
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 5,),
                const Center(
                  child: Text(
                    "Hi! Welcome back back you've been missed",
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.grey
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Email',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                ReusableAuthTextField(
                  controller: emailController,
                  hintText: 'johndoe@gmail.com',
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email address';
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
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: !isPasswordVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                ),
                // Remember Me and Forgot Password
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          checkColor: AppColors.theme,
                          value: _rememberMe,
                          onChanged: (bool? value) {
                            setState(() {
                              _rememberMe = value ?? false;
                            });
                          },
                          fillColor: WidgetStateProperty.all(AppColors.white),
                        ),

                        const Text('Remember me'),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        context.push(ForgotPasswordScreen.routePath);
                        // Handle Forgot Password action
                      },
                      child: const Text(
                        'Forgot Password ?',
                        style: TextStyle(color: AppColors.theme),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Log In Button
                CustomButton(
                  label: "Sign In",
                  onPressedCallback: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      ref.read(authControllerProvider.notifier).signInUsingEmailPass(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
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
                /*
                CustomButton(
                    label: "Login",
                  onPressedCallback: () {
                    ref.read(authControllerProvider.notifier)
                       .signInUsingEmailPass(
                      context: context,
                      email: emailController.value.text,
                      password: passwordController.value.text,
                    );
                  },

                ),

                 */         // custom button without from
                const SizedBox(height: 20),
                // Divider with "or"
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
                        // Handle Apple login
                        // TODO: Implement Apple login logic
                        SnackBarService.showSnackBar(
                          context: context,
                          message: 'Apple login not yet implemented',
                          backgroundColor: const Color.fromARGB(255, 227, 121, 113),
                        );                 },
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
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.black,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.push(SignupScreen.routePath);
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'Sign Up',
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

