import 'package:flutter/foundation.dart';
import 'package:shivalik_institute/model/ManagmentResponseModel.dart';
import '../constant/ApiService.dart';

class ManagementViewModel extends ChangeNotifier {
  late ManagementResponseModel _response;
  bool _isLoading = false;

  ManagementResponseModel get response => _response;
  bool get isLoading => _isLoading;

  Future<void> getManagementList(Map<String, String> jsonBody) async {
    _isLoading = true;
    notifyListeners();

    try {
      _response = await ApiService.managementList(jsonBody);
    } catch (error) {
      // Handle error, e.g., show an error message to the user
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
