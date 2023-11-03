import 'package:flutter/foundation.dart';
import '../constant/ApiService.dart';
import '../model/BatchResponseModel.dart';

class BatchViewModel extends ChangeNotifier {
  late BatchResponseModel _response;
  bool _isLoading = false;

  BatchResponseModel get response => _response;
  bool get isLoading => _isLoading;

  Future<void> batchData(Map<String, String> jsonBody) async {
    _isLoading = true;
    notifyListeners();

    try {
      _response = await ApiService.batchList(jsonBody);
    } catch (error) {
      // Handle error, e.g., show an error message to the user
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
