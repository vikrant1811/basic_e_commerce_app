import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../commons/widgets/custom_button.dart';
import '../../../commons/widgets/reusable_back_button.dart';
import '../../../res/colors.dart';
import '../controller/auth_controller.dart';

class OTPVerificationScreen extends ConsumerStatefulWidget {
  const OTPVerificationScreen({super.key, required this.email});
  final String email;

  static String routeName = 'otpVerification';
  static const routePath = '/otpVerification';

  @override
  ConsumerState<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends ConsumerState<OTPVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: const ReusableBackButton(),
        backgroundColor: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text(
              "Verify Code",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Please enter the code we sent on your email",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              widget.email, // Display the email passed from SignupScreen
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            PinCodeTextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              appContext: context,
              length: 6,
              onChanged: (value) {},
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: AppColors.white,
                inactiveFillColor: AppColors.white,
                selectedFillColor: AppColors.grey,
                inactiveColor: AppColors.theme,
                activeColor: AppColors.theme,
                selectedColor: AppColors.theme,
              ),
              backgroundColor: Colors.transparent,
              enableActiveFill: true,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Didn't receive the code?",
                ),
                const SizedBox(width: 5,),
                GestureDetector(
                  onTap: () {
                    ref.read(authControllerProvider.notifier).resendOtp(
                      email: widget.email,
                      context: context,
                    );
                  },
                  child: const Text(
                    "Resend OTP",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.theme,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            CustomButton(
              label: "Verify",
              onPressedCallback: () {
                ref.read(authControllerProvider.notifier).verifyOtp(
                  email: widget.email,
                  otp: _otpController.text,
                  context: context,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}