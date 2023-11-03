import 'package:flutter/foundation.dart';
import '../constant/ApiService.dart';
import '../model/StateViewResponseModel.dart';

class StateViewModel extends ChangeNotifier {
  late StateViewResponseModel _response;
  bool _isLoading = false;

  StateViewResponseModel get response => _response;
  bool get isLoading => _isLoading;

  Future<void> stateData(Map<String, String> jsonBody) async {
    _isLoading = true;
    notifyListeners();

    try {
      _response = await ApiService.stateList(jsonBody);
    } catch (error) {
      // Handle error, e.g., show an error message to the user
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
