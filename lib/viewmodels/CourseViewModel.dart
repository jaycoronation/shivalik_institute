import 'package:flutter/foundation.dart';
import '../constant/ApiService.dart';
import '../model/CommonResponseModel.dart';
import '../model/CourseResponseModel.dart';
import '../model/DashboardResponseModel.dart';

class CourseViewModel extends ChangeNotifier {
  late CourseResponseModel _response;
  bool _isLoading = false;

  CourseResponseModel get response => _response;
  bool get isLoading => _isLoading;

  Future<void> courseData(Map<String, String> jsonBody) async {
    _isLoading = true;
    notifyListeners();

    try {
      _response = await ApiService.courseList(jsonBody);
    } catch (error) {
      // Handle error, e.g., show an error message to the user
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
