import 'package:flutter/foundation.dart';
import 'package:shivalik_institute/model/AddHolidayResponseModel.dart';
import '../constant/ApiService.dart';
import '../model/BatchResponseModel.dart';

class AddHolidayScreen extends ChangeNotifier {
  late AddHolidayResponseModel _response;
  bool _isLoading = false;

  AddHolidayResponseModel get response => _response;
  bool get isLoading => _isLoading;

  Future<void> batchData(Map<String, String> jsonBody) async {
    _isLoading = true;
    notifyListeners();

    try {
      _response = await ApiService.addHolidayData(jsonBody);
    } catch (error) {
      // Handle error, e.g., show an error message to the user
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
