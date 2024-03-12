import 'package:flutter/foundation.dart';
import 'package:shivalik_institute/model/CaseStudyResponseModel.dart';
import '../constant/ApiService.dart';
import '../model/LecturesResponseModel.dart';
import '../model/MaterialDetailResponseModel.dart';

class MaterialDetailViewModel extends ChangeNotifier {
  late MaterialDetailResponseModel _response;
  bool _isLoading = false;

  MaterialDetailResponseModel get response => _response;
  bool get isLoading => _isLoading;

  Future<void> getMaterialList(Map<String, String> jsonBody) async {
    _isLoading = true;
    notifyListeners();

    try {
      _response = await ApiService.materialList(jsonBody);
    } catch (error) {
      print(error);
      // Handle error, e.g., show an error message to the user
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}