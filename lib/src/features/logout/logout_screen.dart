import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../res/colors.dart';
import '../auth/views/login_screen.dart';
import '../profile/views/profile_screen.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});
  static String routeName = 'logout';
  static const routePath = '/logout';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const ProfileScreen(),
        Container(
          color: Colors.black.withOpacity(0.6),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Log out title
                const Text(
                  'Log out',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                    decoration: TextDecoration.none
                  ),
                ),
                const SizedBox(height: 8),
                // Confirmation message
                const Text(
                  'Are you sure you want to log out?',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.grey,
                      decoration: TextDecoration.none

                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          context.go(ProfileScreen.routePath);
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.theme),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.theme,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Ensure LoginScreen.routePath is valid
                          context.go(LoginScreen.routePath);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.theme,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Log Out',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
