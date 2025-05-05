import 'base.dart';

class Endpoints {

  static const String baseUrl = BasePaths.baseUrl;

  //signUp
  static const String signUp = '$baseUrl/users/register';
  static const String verifyOTP = '$baseUrl/users/verify-email';

  //resend otp
  static const String resendOTP = '$baseUrl/users/resend-verification';

  //Login
  static const String loginEmail = '$baseUrl/users/login';

  //forget password
  static const String forgetPass = '$baseUrl/users/forgot-password';
  static const String verifyForgetPassOtp = '$baseUrl/user/verifyforgotpassword';
  static const String resetPass = '$baseUrl/user/forgot_password';

  //Logout
  static const String logout = '$baseUrl/user/logout';

  //location
  static const String location = '$baseUrl/user/update-coordinates';


  //profile
  static const String completeProfile = '$baseUrl/user/complete-profile';
  static const String editProfile = '$baseUrl/user/edit-profile';
  static const String storage = "$baseUrl/storage/upload";



}