import 'package:flutter/foundation.dart';
import 'package:shivalik_institute/model/UserListResponseModel.dart';
import '../constant/ApiService.dart';

class UserListViewModel extends ChangeNotifier {
  late UserListResponseModel _response;
  bool _isLoading = false;

  UserListResponseModel get response => _response;
  bool get isLoading => _isLoading;

  Future<void> getUserList(Map<String, String> jsonBody) async {
    _isLoading = true;
    notifyListeners();

    try {
      _response = await ApiService.userList(jsonBody);
    } catch (error) {
      print(error);
      // Handle error, e.g., show an error message to the user
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
