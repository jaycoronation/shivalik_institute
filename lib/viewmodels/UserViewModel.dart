import 'package:flutter/foundation.dart';
import 'package:shivalik_institute/model/UserProfileResponseModel.dart';
import '../constant/ApiService.dart';
import '../model/BatchResponseModel.dart';

class UserViewModel extends ChangeNotifier {
  late UserProfileResponseModel _response;
  bool _isLoading = false;

  UserProfileResponseModel get response => _response;
  bool get isLoading => _isLoading;

  Future<void> getUserDetails(Map<String, String> jsonBody) async {
    _isLoading = true;
    notifyListeners();

    try {
      _response = await ApiService.userDetails(jsonBody);
    } catch (error) {
      // Handle error, e.g., show an error message to the user
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
