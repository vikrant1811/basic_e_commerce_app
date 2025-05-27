import 'package:basic_e_commerce_app/src/res/assets.dart';
import 'package:basic_e_commerce_app/src/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
//import '../../features/auth/views/login_screen.dart';
import '../../features/home/home_screen.dart';
import '../providers/common_providers.dart';

class SplashScreen extends ConsumerWidget {
  static String routeName ='splash';
  static const routePath ='/';


  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen for when the delay completes, then navigate.
    ref.listen<AsyncValue<void>>(splashProvider, (prev, next) {
      next.whenData((_) {
        context.pushReplacement(HomeScreen.routePath);//LoginScreen.routePath //HomeScreen
      });
    });

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Image.asset(ImageAssets.splashImg,
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}
