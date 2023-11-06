import 'package:flutter/foundation.dart';
import '../constant/ApiService.dart';
import '../model/CommonResponseModel.dart';

class CommonViewModel extends ChangeNotifier {
  late CommonResponseModel _response;
  bool _isLoading = false;

  CommonResponseModel get response => _response;
  bool get isLoading => _isLoading;

  Future<void> generateOTP(Map<String, String> jsonBody) async {
    _isLoading = true;
    notifyListeners();

    try {
      _response = await ApiService.generateOtp(jsonBody);
    } catch (error) {
      // Handle error, e.g., show an error message to the user
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveUserData(Map<String, String> jsonBody) async {
    _isLoading = true;
    notifyListeners();

    try {
      _response = await ApiService.saveUserData(jsonBody);
    } catch (error) {
      // Handle error, e.g., show an error message to the user
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}
