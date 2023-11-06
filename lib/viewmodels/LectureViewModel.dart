import 'package:flutter/foundation.dart';
import '../constant/ApiService.dart';
import '../model/LecturesResponseModel.dart';

class LectureViewModel extends ChangeNotifier {
  late LecturesResponseModel _response;
  bool _isLoading = false;

  LecturesResponseModel get response => _response;
  bool get isLoading => _isLoading;

  Future<void> getModuleList(Map<String, String> jsonBody) async {
    _isLoading = true;
    notifyListeners();

    try {
      _response = await ApiService.lectureList(jsonBody);
    } catch (error) {
      // Handle error, e.g., show an error message to the user
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
