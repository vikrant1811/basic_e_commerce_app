import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../commons/widgets/custom_button.dart';
import '../../../commons/widgets/reusable_back_button.dart';
import '../../../res/assets.dart';
import '../../../res/colors.dart';
import '../../../utils/snackbar_service.dart';
import '../controller/auth_controller.dart';
import '../widgets/reusable_auth_text_field.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});
  static String routeName = 'forgetPassword';
  static const routePath = '/forgetPassword';

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: const ReusableBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             // const CustomTitleWithIcon(),
              const SizedBox(height: 20),
              const Text(
                'Forget Password',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 30),
              Image.asset(
                ImageAssets.forgetPass,
                height: 300,
              ),
              const SizedBox(height: 20),
              const Text(
                'Enter your Email ID',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              ReusableAuthTextField(
                controller: emailController,
                hintText: "johndoe@gmail.com",
                onChanged: (value) => setState(() {
                  emailController.text = value;
                }),
              ),
              const SizedBox(height: 80),
              CustomButton(
                label: "Continue",
                //route: ForgetPassEmailVerifyScreen.routePath
                onPressedCallback: () async {
                  if (!EmailValidator.validate(emailController.text.trim())) {
                    SnackBarService.showSnackBar(
                      context: context,
                      message: "Invalid email format",
                      backgroundColor: BasicColors.red,
                    );
                    return;
                  }
                  ref.read(authControllerProvider.notifier).forgetPassUsingEmail(
                    context: context,
                    email: emailController.text.trim(),
                  );
                },
              ),
              const SizedBox(height: 10),

            ],
          ),
        ),
      ),
    );
  }
}