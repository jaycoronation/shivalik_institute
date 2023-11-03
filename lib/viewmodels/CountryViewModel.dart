import 'package:flutter/foundation.dart';
import '../constant/ApiService.dart';
import '../model/CountryResponseModel.dart';

class CountryViewModel extends ChangeNotifier {
  late CountryResponseModel _response;
  bool _isLoading = false;

  CountryResponseModel get response => _response;
  bool get isLoading => _isLoading;

  Future<void> countryData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _response = await ApiService.countryList();
    } catch (error) {
      // Handle error, e.g., show an error message to the user
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
