import 'package:flutter/foundation.dart';
import 'package:shivalik_institute/model/EventResponseModel.dart';
import 'package:shivalik_institute/model/UserProfileResponseModel.dart';
import '../constant/ApiService.dart';
import '../model/BatchResponseModel.dart';

class EventViewModel extends ChangeNotifier {
  late EventResponseModel _response;
  bool _isLoading = false;

  EventResponseModel get response => _response;
  bool get isLoading => _isLoading;

  Future<void> getEventsList(Map<String, String> jsonBody) async {
    _isLoading = true;
    notifyListeners();

    try {
      _response = await ApiService.eventList(jsonBody);
    } catch (error) {
      // Handle error, e.g., show an error message to the user
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
