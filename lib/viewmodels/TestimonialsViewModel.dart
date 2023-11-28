import 'package:flutter/foundation.dart';
import '../constant/ApiService.dart';
import '../model/TestimonialResponseModel.dart';

class TestimonialsViewModel extends ChangeNotifier {
  late TestimonialResponseModel _response;
  bool _isLoading = false;

  TestimonialResponseModel get response => _response;
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
