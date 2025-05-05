import 'package:basic_e_commerce_app/src/features/auth/forgot_password/forgot_password_screen.dart';
import 'package:basic_e_commerce_app/src/features/auth/views/Signup_screen.dart';
import 'package:basic_e_commerce_app/src/features/auth/views/login_screen.dart';
import 'package:basic_e_commerce_app/src/features/favorites/favorites_screen.dart';
import 'package:basic_e_commerce_app/src/features/home/home_screen.dart';
import 'package:basic_e_commerce_app/src/features/main/main_screen.dart';
import 'package:go_router/go_router.dart';
import '../commons/views/splash_screen.dart';
import '../features/auth/views/otp_verification_screen.dart';
import '../features/cart/cart_screen.dart';
import '../features/category/category_screen.dart';
import '../features/product/product_details_screen.dart';
import '../features/profile/views/profile_screen.dart';
import '../models/product_model.dart';

class AppRouter {
  final GoRouter router = GoRouter(
    initialLocation: SplashScreen.routePath,
    routes: [
      GoRoute(
        name: SplashScreen.routeName,
        path: SplashScreen.routePath,
        builder: (context, state) => const SplashScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => MainScreen(child: child),
        routes: [
          GoRoute(
            name: HomeScreen.routeName,
            path: HomeScreen.routePath,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            name: CategoryScreen.routeName,
            path: CategoryScreen.routePath,
            builder: (context, state) => const CategoryScreen(),
          ),
          GoRoute(
            name: CartScreen.routeName,
            path: CartScreen.routePath,
            builder: (context, state) => const CartScreen(),
          ),
          GoRoute(
            name: FavoritesScreen.routeName,
            path: FavoritesScreen.routePath,
            builder: (context, state) => const FavoritesScreen(),
          ),
          GoRoute(
            name: ProfileScreen.routeName,
            path: ProfileScreen.routePath,
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      GoRoute(
        name: LoginScreen.routeName,
        path: LoginScreen.routePath,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: SignupScreen.routeName,
        path: SignupScreen.routePath,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: OTPVerificationScreen.routePath,
        builder: (context, state) {
          final email = state.extra as String;
          return OTPVerificationScreen(email: email,
          );
        },
      ),
      GoRoute(
        name: ForgotPasswordScreen.routeName,
        path: ForgotPasswordScreen.routePath,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        name: ProductDetailsScreen.routeName,
        path: ProductDetailsScreen.routePath,
        builder: (context, state) {
          final product = state.extra as ProductModel;
          return ProductDetailsScreen(product: product);
        },
      ),

    ],
  );
}
