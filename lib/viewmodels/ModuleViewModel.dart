// import 'package:flutter/foundation.dart';
// import '../constant/ApiService.dart';
//
//
// class ModuleViewModel extends ChangeNotifier {
//   late ModuleResponseModel _response;
//   bool _isLoading = false;
//
//   ModuleResponseModel get response => _response;
//   bool get isLoading => _isLoading;
//
//   Future<void> moduleData(Map<String, String> jsonBody) async {
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       _response = await ApiService.moduleList(jsonBody);
//     } catch (error) {
//       // Handle error, e.g., show an error message to the user
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }
