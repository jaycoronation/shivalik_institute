 import 'package:flutter/foundation.dart';
import '../constant/ApiService.dart';
import '../model/VerifyOtpResponseModel.dart';

class VerifyOtpViewModel extends ChangeNotifier {
  late VerifyOtpResponseModel _response;
  bool _isLoading = false;

  VerifyOtpResponseModel get response => _response;
  bool get isLoading => _isLoading;

  Future<void> verifyOTP(Map<String, String> jsonBody) async {
    _isLoading = true;
    notifyListeners();

    try {
      _response = await ApiService.verifyOtp(jsonBody);
    } catch (error) {
      // Handle error, e.g., show an error message to the user
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
