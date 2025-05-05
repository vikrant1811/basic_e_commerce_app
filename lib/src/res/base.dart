import '../utils/config.dart';

class BasePaths {
  static const baseImagePath = "assets/images";
  static const baseAnimationPath = "assets/animations";
  static const baseProdUrl = '';  //'https://bookmywarehouse-cwd2a3hgejevh8ht.eastus-01.azurewebsites.net/api/v1/'
  static const baseTestUrl = "https://shopai-rmia.onrender.com/api/v1";  //"http://192.168.1.106:5000/api/v1/"
  static const storageURL =  '';  //"https://pub-50749ce34b5e4abfa121ac60a6fdd9b2.r2.dev/";
  static const baseUrl = AppConfig.devMode ? baseTestUrl : baseProdUrl;
}