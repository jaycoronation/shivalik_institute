import 'package:flutter/foundation.dart';
import '../constant/ApiService.dart';
import '../model/DashboardResponseModel.dart';

class DashboardViewModel extends ChangeNotifier {
  late DashboardResponseModel _response;
  bool _isLoading = false;

  DashboardResponseModel get response => _response;
  bool get isLoading => _isLoading;

  Future<void> dashboardData(Map<String, String> jsonBody) async {
    _isLoading = true;
    notifyListeners();

    try {
      _response = await ApiService.dashboard(jsonBody);
    } catch (error) {
      print(error);
      // Handle error, e.g., show an error message to the user
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
