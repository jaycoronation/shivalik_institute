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

  Future<void> saveHolidayAddData(Map<String, String> jsonBody) async {
    _isLoading = true;
    notifyListeners();

    try {
      _response = await ApiService.saveHolidayAddData(jsonBody);
    } catch (error) {
      // Handle error, e.g., show an error message to the user
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> deleteHolidayData(Map<String, String> jsonBody) async {
    _isLoading = true;
    notifyListeners();

    try {
      _response = await ApiService.deleteHolidayAddData(jsonBody);
    } catch (error) {
      // Handle error, e.g., show an error message to the user
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> deleteResourceData(Map<String, String> jsonBody) async {
    _isLoading = true;
    notifyListeners();

    try {
      _response = await ApiService.deleteResourceData(jsonBody);
    } catch (error) {
      // Handle error, e.g., show an error message to the user
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> uploadResourceData(Map<String, String> jsonBody) async {
    _isLoading = true;
    notifyListeners();

    try {
      _response = await ApiService.uploadResourceData(jsonBody);
    } catch (error) {
      // Handle error, e.g., show an error message to the user
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


}
