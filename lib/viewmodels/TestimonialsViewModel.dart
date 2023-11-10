import 'package:flutter/foundation.dart';
import '../constant/ApiService.dart';
import '../model/TestimonialsResponseModel.dart';

class TestimonialsViewModel extends ChangeNotifier {
  late TestimonialsResponseModel _response;
  bool _isLoading = false;

  TestimonialsResponseModel get response => _response;
  bool get isLoading => _isLoading;

  Future<void> getTestimonialsList(Map<String, String> jsonBody) async {
    _isLoading = true;
    notifyListeners();

    try {
      _response = await ApiService.testimonialsList(jsonBody);
    } catch (error) {
      // Handle error, e.g., show an error message to the user
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
