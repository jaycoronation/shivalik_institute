import 'package:flutter/foundation.dart';
import 'package:shivalik_institute/model/CaseStudyResponseModel.dart';
import 'package:shivalik_institute/model/DocumentResponseModel.dart';
import '../constant/ApiService.dart';
import '../model/LecturesResponseModel.dart';

class DocumentViewModel extends ChangeNotifier {
  late DocumentResponseModel _response;
  bool _isLoading = false;

  DocumentResponseModel get response => _response;
  bool get isLoading => _isLoading;

  Future<void> getClassDocumentList(Map<String, String> jsonBody) async {
    _isLoading = true;
    notifyListeners();

    try {
      _response = await ApiService.documentList(jsonBody);
    } catch (error) {
      // Handle error, e.g., show an error message to the user
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
