import 'package:flutter/foundation.dart';
import '../constant/ApiService.dart';
import '../model/ModuleResponseModel.dart';

class ModuleViewModel extends ChangeNotifier {
  late ModuleResponseModel _response;
  bool _isLoading = false;

  ModuleResponseModel get response => _response;
  bool get isLoading => _isLoading;

  Future<void> getModuleList(Map<String, String> jsonBody) async {
    _isLoading = true;
    notifyListeners();

    try {
      _response = await ApiService.moduleList(jsonBody);
    } catch (error) {
      print("Error === $error");
      // Handle error, e.gx., show an error message to the user
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
