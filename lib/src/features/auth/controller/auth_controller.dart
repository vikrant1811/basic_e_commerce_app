import 'dart:convert';
import 'dart:developer';
import 'package:basic_e_commerce_app/src/features/auth/forgot_password/reset_password_screen.dart';
import 'package:basic_e_commerce_app/src/features/auth/views/otp_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../commons/controller/shared_prefs_controller.dart';
import '../../../commons/providers/common_providers.dart';
import '../../../models/user_model.dart';
import '../../../res/colors.dart';
import '../../../res/strings.dart';
import '../../../utils/config.dart';
import '../../../utils/snackbar_service.dart';
import '../../home/home_screen.dart';
import '../repository/auth_repo.dart';
import '../views/login_screen.dart';

final authControllerProvider =
StateNotifierProvider<AuthController, bool>((ref) {
  final authRepo = ref.watch(authRepoProvider);
  return AuthController(authRepo: authRepo, ref: ref);
});

class AuthController extends StateNotifier<bool> {
  AuthController({required AuthRepo authRepo, required Ref ref})
      : _authRepo = authRepo,
        _ref = ref,
        super(false);

  final AuthRepo _authRepo;
  final Ref _ref;

  Future<void> verifyOtp({
    required String email,
    required String otp,
    required BuildContext context,
  }) async {
    // Show a loading dialog while verifying the OTP
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        content: Row(
          children: [
            CircularProgressIndicator(color: BasicColors.blue),
            const SizedBox(width: 20),
            const Text("Verifying..."),
          ],
        ),
      ),
    );

    state = true;

    try {
      final response = await _authRepo.verifyOTP(email: email, otp: otp);
      if (response == null) {
        throw Exception("No response from server");
      }
      final data = jsonDecode(response.body);
      if (data == null || data['success'] == null) {
        throw Exception("Invalid response from server");
      }
      final otpVerifiedSuccess = data['success'] as bool;

      // Show appropriate snackbar message based on verification result
      SnackBarService.showSnackBar(
        context: context,
        message: otpVerifiedSuccess
            ? AuthenticationMessages.otpVerificationSuccess
            : (data['message'] ),
        backgroundColor: otpVerifiedSuccess
            ? BasicColors.green
            : const Color.fromARGB(255, 215, 101, 93),
      );

      if (otpVerifiedSuccess) {
        // Dismiss the loading dialog
        context.pop();
        context.pushReplacement(LoginScreen.routePath);
      } else {
        context.pop();
      }
    } catch (e, stacktrace) {
      context.pop();
      if (AppConfig.logHttp) {
        log('$e');
        log('$stacktrace');
      }
      SnackBarService.showSnackBar(
        context: context,
        message: AuthenticationMessages.otpVerificationFailed,
        backgroundColor: const Color.fromARGB(255, 227, 121, 113),
      );
    } finally {
      state = false;
    }
  }


  Future<void> signUpUsingEmailPass({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required BuildContext context,
  }) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return  AlertDialog(
          backgroundColor: AppColors.white,
          content: Row(
            children: [
              CircularProgressIndicator(
                color: BasicColors.blue,
              ),
              SizedBox(width: 20),
              Text("Signing in..."),
            ],
          ),
        );
      },
    );
    if (!state) {
      state = true;
      _authRepo
          .signUpUsingEmailPass(email: email,
          firstName: firstName,
          lastName: lastName,
          password: password)
          .then((response) {
        if (response != null) {
          try {
            final data = jsonDecode(response.body);
            final success = data['success'];

            SnackBarService.showSnackBar(
              context: context,
              message: success
                  ? "${AuthenticationMessages.signUpSuccess} as $email"
                  : data['message'],
              backgroundColor: success
                  ? BasicColors.green
                  : const Color.fromARGB(255, 215, 101, 93),
            );
            context.pop();
            if (success) {
              context.pushReplacement(OTPVerificationScreen.routePath,
                  extra: email,
              );

            }
          } catch (e, stacktrace) {
            if (AppConfig.logHttp) {
              log('$e');
              log('$stacktrace');
            }
            context.pop();
            SnackBarService.showSnackBar(
              context: context,
              message:"Registration failed: ${e.toString()}",
              backgroundColor: const Color.fromARGB(255, 227, 121, 113),
            );
          }
        }
      });
      state = false;
    }
  }


  Future<void> signInUsingEmailPass(
      {required String email,
        required String password,
        required BuildContext context}) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          content: Row(
            children: [
              CircularProgressIndicator(
                color: BasicColors.blue,
              ),
              const SizedBox(width: 20),
              const Text("Logging In..."),
            ],
          ),
        );
      },
    );
    state = true;
    _authRepo
        .signInUsingEmailPass(email: email, password: password)
        .then((response) {
      if (response != null) {
        try {
          final data = jsonDecode(response.body);
          final success = data['success']==true;

          SnackBarService.showSnackBar(
            context: context,
            message: success
                ? "${AuthenticationMessages.signInSuccess} as $email"
                : data['message'],
            backgroundColor: success
                ? BasicColors.green
                : const Color.fromARGB(255, 215, 101, 93),
          );
         // final userData = data['data']['user'];
         // final token = userData['tokenId']['token'];
          // final token = data['token'];
          // final userDetails = data['userDetails'];
          final userData = data['data']?['user'];
          final token = data['data']?['token'];
         // final refreshToken = data['data']?['refreshToken'];
          print(userData);
          if (token != null) {
            _ref.read(sharedPrefsControllerProvider).setCookie(cookie: token);
            _ref.read(authTokenProvider.notifier).update((state) => token);
          }
          final user = User.fromJson(userData);
          state = false;
          _ref.read(sharedPrefsControllerProvider).setUser(user: user);
          _ref.read(currentUserProvider.notifier).update((state) => user);
          context.go(HomeScreen.routePath);
        } catch (e, stacktrace) {
          if (AppConfig.logHttp) {
            log('$e');
            log('$stacktrace');
          }
          context.pop();
          SnackBarService.showSnackBar(
              context: context,
              message: AuthenticationMessages.signInFailed,
              backgroundColor: const Color.fromARGB(255, 227, 121, 113));
        }
      }
    });
    state = false;
  }


  Future<void> forgetPassUsingEmail({
    required String email,
    required BuildContext context,
  }) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return  AlertDialog(
          backgroundColor: AppColors.white,
          content: Row(
            children: [
              CircularProgressIndicator(
                color: BasicColors.blue,
              ),
              SizedBox(width: 20),
              Text("Sending otp..."),
            ],
          ),
        );
      },
    );
    if (!state) {
      state = true;
      _authRepo
          .forgetPassUsingEmail(email: email)
          .then((response) {
        if (response != null) {
          try {
            final data = jsonDecode(response.body);
            final success = data['success'];

            SnackBarService.showSnackBar(
              context: context,
              message: success
                  ? "${AuthenticationMessages.otpSendSuccessfully} to $email"
                  : data['message'],
              backgroundColor: success
                  ? BasicColors.green
                  : const Color.fromARGB(255, 215, 101, 93),
            );
            context.pop();
            if (success) {
              context.pushReplacement(LoginScreen.routePath);//ResetPasswordScreen
              // context.pushReplacement(
              //   ForgetPassEmailVerifyScreen.routePath,
              //   extra: {
              //     'email': email,
              //   },
              // );
            }
          } catch (e, stacktrace) {
            if (AppConfig.logHttp) {
              log('$e');
              log('$stacktrace');
            }
            context.pop();
            SnackBarService.showSnackBar(
              context: context,
              message: AuthenticationMessages.otpVerificationFailed,
              backgroundColor: const Color.fromARGB(255, 227, 121, 113),
            );
          }
        }
      });
      state = false;
    }
  }





  // Future<void> forgetPassVerifyOTP({
  //   required String email,
  //   required String otp,
  //   required BuildContext context,
  // }) async {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return  AlertDialog(
  //         backgroundColor: AppColors.white,
  //         content: Row(
  //           children: [
  //             CircularProgressIndicator(
  //               color: BasicColors.blue,
  //             ),
  //             SizedBox(width: 20),
  //             Text("Verifying..."),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  //   state = true;
  //
  //   _authRepo.forgetPassVerifyOTP(email: email,otp: otp).then((response) {
  //     if (response != null) {
  //       try {
  //         final data = jsonDecode(response.body);
  //         if (data == null || data['success'] == null) {
  //           throw Exception("Invalid response from server");
  //         }
  //         final otpVerifiedSuccess = data['success'];
  //
  //         SnackBarService.showSnackBar(
  //           context: context,
  //           message: otpVerifiedSuccess
  //               ? AuthenticationMessages.otpVerificationSuccess
  //               : data['message'],
  //           backgroundColor: otpVerifiedSuccess
  //               ? BasicColors.green
  //               : const Color.fromARGB(255, 215, 101, 93),
  //         );
  //         /*
  //         if (otpVerifiedSuccess) {
  //           // final token = data['token'];
  //           // final userDetails = data['userDetails'];
  //           final userData = data['data']['user'];
  //           final token = userData['tokenId']['token'];
  //           if (token != null) {
  //             _ref.read(sharedPrefsControllerProvider).setCookie(cookie: token);
  //             _ref.read(authTokenProvider.notifier).update((state) => token);
  //           }
  //           final user = User.fromJson(userData);
  //           state = false;
  //           _ref.read(sharedPrefsControllerProvider).setUser(user: user);
  //           _ref.read(currentUserProvider.notifier).update((state) => user);
  //           context.go(ResetPasswordScreen.routePath,extra: email);
  //         }
  //
  //          */
  //         if (otpVerifiedSuccess) {
  //           context.pop();
  //           /*
  //           // Check if user data exists in the response before accessing it
  //           if (data.containsKey('data') && data['data'] != null && data['data'].containsKey('user')) {
  //             final userData = data['data']['user'];
  //             final token = userData['tokenId']?['token'];
  //             if (token != null) {
  //               _ref.read(sharedPrefsControllerProvider).setCookie(cookie: token);
  //               _ref.read(authTokenProvider.notifier).update((state) => token);
  //             }
  //             final user = User.fromJson(userData);
  //             _ref.read(sharedPrefsControllerProvider).setUser(user: user);
  //             _ref.read(currentUserProvider.notifier).update((state) => user);
  //           }
  //
  //            */
  //
  //           // Navigate to ResetPasswordScreen, passing email as extra
  //           context.go(ResetPasswordScreen.routePath, extra: email);
  //         }
  //       } catch (e, stacktrace) {
  //         if (AppConfig.logHttp) {
  //           log('$e');
  //           log('$stacktrace');
  //         }
  //         context.pop();
  //         SnackBarService.showSnackBar(
  //           context: context,
  //           message: AuthenticationMessages.otpVerificationFailed,
  //           backgroundColor: const Color.fromARGB(255, 227, 121, 113),
  //         );
  //       }
  //     } else {
  //       context.pop();
  //       SnackBarService.showSnackBar(
  //         context: context,
  //         message: "No response from server",
  //         backgroundColor: const Color.fromARGB(255, 227, 121, 113),
  //       );
  //     }
  //   });
  //   state = false;
  // }


  Future<void> resetPass({
    required String email,
    required String newPassword,
    required String confirmNewPassword,
    required BuildContext context,
  }) async {
    if (newPassword != confirmNewPassword) {
      SnackBarService.showSnackBar(
        context: context,
        message: AuthenticationMessages.passwordDoNotMatch,
        backgroundColor: BasicColors.red,
      );
      return;
    }

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return  AlertDialog(
          backgroundColor: AppColors.white,
          content: Row(
            children: [
              CircularProgressIndicator(
                color: BasicColors.blue,
              ),
              SizedBox(width: 20),
              Text("Resetting password..."),
            ],
          ),
        );
      },
    );

    state = true;

    try {
      final response = await _authRepo.resetPass(
        email:email,
        newPassword: newPassword,
        confirmNewPassword: confirmNewPassword,
      );

      if (response != null) {
        final data = jsonDecode(response.body);

        if (data == null || data['success'] == null) {
          throw Exception("Invalid response from server");
        }

        final resetSuccess = data['success'];

        SnackBarService.showSnackBar(
          context: context,
          message: resetSuccess
              ? AuthenticationMessages.passwordResetSuccess
              : data['message'],
          backgroundColor: resetSuccess ? BasicColors.green : BasicColors.red,
        );

        if (resetSuccess) {
          context.go(LoginScreen.routePath); // Redirect to login
        }
      } else {
        throw Exception("No response from server");
      }
    } catch (e, stacktrace) {
      if (AppConfig.logHttp) {
        log('$e');
        log('$stacktrace');
      }
      SnackBarService.showSnackBar(
        context: context,
        message: AuthenticationMessages.passwordResetFailed,
        backgroundColor: BasicColors.red,
      );
    } finally {
      context.pop(); // Close loading dialog
      state = false; // Reset state
    }
  }



  Future<void> resendOtp({
    required String email,
    required BuildContext context,
  }) async {
    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        content: Row(
          children: [
            CircularProgressIndicator(color: BasicColors.blue),
            SizedBox(width: 20),
            Text("Resending OTP..."),
          ],
        ),
      ),
    );
    state = true;

    try {
      final response = await _authRepo.resendOtp(email: email);
      context.pop(); // close loading
      state = false;

      if (response != null) {
        final data = jsonDecode(response.body);
        final success = data['success'] as bool;
        SnackBarService.showSnackBar(
          context: context,
          message: success
              ? "${AuthenticationMessages.otpReSendSuccessfully} to $email"
              : data['message'] as String,
          backgroundColor: success
              ? BasicColors.green
              : const Color.fromARGB(255, 215, 101, 93),
        );
      } else {
        throw Exception("No response from server");
      }
    } catch (e) {
      context.pop();
      state = false;
      SnackBarService.showSnackBar(
        context: context,
        message: "${AuthenticationMessages.otpReSendFailed} Please try again.",
        backgroundColor: const Color.fromARGB(255, 227, 121, 113),
      );
      if (AppConfig.logHttp) log(e.toString());
    }
  }












  Future<void> signOut({BuildContext? context}) async {
    // _ref.read(authTokenProvider.notifier).update((state) => null);
    // _ref.read(currentUserProvider.notifier).update((state) => null);
    final authTokenState = _ref.read(authTokenProvider);
    if (authTokenState != null) {
      _ref.read(authTokenProvider.notifier).update((_) => null);
    }
    _ref.read(sharedPrefsControllerProvider).clear();
    if (context != null) {
      context.go(LoginScreen.routePath);
    }
  }


}