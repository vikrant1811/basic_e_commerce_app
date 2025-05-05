import 'package:http/http.dart' ;
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/core.dart';
import '../../../res/endpoints.dart';
import '../../../res/strings.dart';

final authRepoProvider = Provider((ref) {
  final api = ref.watch(apiProvider);
  return AuthRepo(api: api);
});

class AuthRepo {
  final API _api;

  AuthRepo({required API api}) : _api = api;


  Future<Response?> verifyOTP(
      {required String otp, required String email}) async {
    final body = {
      "email": email,
      "otp": otp,
    };
    final result = await _api.postRequest(
        url: Endpoints.verifyOTP, body: body, requireAuth: false);
    return result.fold(
          (Failure failure) {
        log(
          failure.message,
          name: LogLabel.auth,
        );
        return null;
      },
          (Response response) => response,
    );
  }

  Future<Response?> signUpUsingEmailPass({required String email,
    required String firstName,
    required String lastName,
    required String password}) async {
    final body = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
     // "role":"customer"
    };
    final result = await _api.postRequest(
        url: Endpoints.signUp, body: body, requireAuth: false);
    return result.fold(
          (Failure failure) {
        log(
          failure.message,
          name: LogLabel.auth,
        );
        return null;
      },
          (Response response) => response,
    );
  }


  Future<Response?> signInUsingEmailPass(
      {required String email, required String password}) async {
    final body = {
      "email": email,
      "password": password,
    };
    final result = await _api.postRequest(
        url: Endpoints.loginEmail, body: body, requireAuth: false);
    return result.fold(
          (Failure failure) {
        log(
          failure.message,
          name: LogLabel.auth,
        );
        return null;
      },
          (Response response) => response,
    );
  }


  Future<Response?> forgetPassUsingEmail(
      {required String email,}) async {
    final body = {
      "email": email,
    };
    final result = await _api.postRequest(
        url: Endpoints.forgetPass, body: body, requireAuth: false);
    return result.fold(
          (Failure failure) {
        log(
          failure.message,
          name: LogLabel.auth,
        );
        return null;
      },
          (Response response) => response,
    );
  }

  Future<Response?> forgetPassVerifyOTP(
      {required String otp, required String email,}) async {
    final body = {
      "email": email,
      "otp": otp,
    };
    final result = await _api.postRequest(
        url: Endpoints.verifyForgetPassOtp, body: body, requireAuth: false);
    return result.fold(
          (Failure failure) {
        log(
          failure.message,
          name: LogLabel.auth,
        );
        return null;
      },
          (Response response) => response,
    );
  }

  Future<Response?> resetPass(
      {  required String email,
        required String newPassword,required String confirmNewPassword,}) async {
    final body = {
      "email":email,
      "newPassword": newPassword,
      "confirmNewPassword": confirmNewPassword
    };
    final result = await _api.patchRequest(
        url: Endpoints.resetPass, body: body, requireAuth: false);
    return result.fold(
          (Failure failure) {
        log(
          failure.message,
          name: LogLabel.auth,
        );
        return null;
      },
          (Response response) => response,
    );
  }


  Future<Response?> resendOtp({ required String email }) async {
    final body = { "email": email };
    final result = await _api.postRequest(
      url: Endpoints.resendOTP,
      body: body,
      requireAuth: false,
    );
    return result.fold(
          (Failure failure) {
        log(failure.message, name: LogLabel.auth);
        return null;
      },
          (Response response) => response,
    );
  }


}

