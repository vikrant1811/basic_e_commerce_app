import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../commons/widgets/custom_button.dart';
import '../../../commons/widgets/reusable_back_button.dart';
import '../../../res/colors.dart';
import '../controller/auth_controller.dart';
import '../widgets/reusable_auth_text_field.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key,required this.email});
  final String email;
  static String routeName = 'resetPassword';
  static const routePath = '/resetPassword';

  @override
  ConsumerState<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmNewPasswordVisible = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: const ReusableBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           // const CustomTitleWithIcon(),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Reset Password',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'The password must be different than before',
                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 24),
            ReusableAuthTextField(
              controller: _newPasswordController,
              obscureText: !_isPasswordVisible,
              hintText: 'New Password',
              prefixIcon: const Icon(Icons.lock),
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
            ),
            const SizedBox(height: 16),
            ReusableAuthTextField(
              controller: _confirmNewPasswordController,
              obscureText: !_isConfirmNewPasswordVisible,
              hintText: 'Confirm Password',
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  _isConfirmNewPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isConfirmNewPasswordVisible = !_isConfirmNewPasswordVisible;
                  });
                },
              ),
            ),
            const Spacer(),
             CustomButton(
                label: "Continue",
              onPressedCallback: () {
                ref.read(authControllerProvider.notifier).resetPass(
                  context: context,
                  email: widget.email,
                  newPassword: _newPasswordController.text,
                  confirmNewPassword: _confirmNewPasswordController.text,
                );
              },
                //route: LoginScreen.routePath
            ),
          ],
        ),
      ),
    );
  }
}