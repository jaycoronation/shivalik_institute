import 'package:flutter/foundation.dart';
import '../constant/ApiService.dart';
import '../model/CityResponseModel.dart';
import '../model/StateViewResponseModel.dart';

class CityViewModel extends ChangeNotifier {
  late CityResponseModel _response;
  bool _isLoading = false;

  CityResponseModel get response => _response;
  bool get isLoading => _isLoading;

  Future<void> cityData(Map<String, String> jsonBody) async {
    _isLoading = true;
    notifyListeners();

    try {
      _response = await ApiService.cityList(jsonBody);
    } catch (error) {
      // Handle error, e.g., show an error message to the user
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
