import 'package:flutter/foundation.dart';
import '../constant/ApiService.dart';
import '../model/HolidayResponseModel.dart';
import '../model/LecturesResponseModel.dart';

class HolidayViewModel extends ChangeNotifier {
  late HolidayResponseModel _response;
  bool _isLoading = false;

  HolidayResponseModel get response => _response;
  bool get isLoading => _isLoading;

  Future<void> getHolidayList(Map<String, String> jsonBody) async {
    _isLoading = true;
    notifyListeners();

    try {
      _response = await ApiService.holidayList(jsonBody);
    } catch (error) {
      // Handle error, e.g., show an error message to the user
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
