import 'package:flutter/foundation.dart';
import 'package:shivalik_institute/model/CaseStudyResponseModel.dart';
import '../constant/ApiService.dart';

class CaseStudyViewModel extends ChangeNotifier {
  late CaseStudyResponseModel _response;
  bool _isLoading = false;

  CaseStudyResponseModel get response => _response;
  bool get isLoading => _isLoading;

  Future<void> getCaseStudyList(Map<String, String> jsonBody) async {
    _isLoading = true;
    notifyListeners();

    try {
      _response = await ApiService.caseStudyList(jsonBody);
    } catch (error) {
      // Handle error, e.g., show an error message to the user
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
