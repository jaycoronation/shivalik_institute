import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shivalik_institute/model/CommonResponseModel.dart';

class MultipartApiViewModel extends ChangeNotifier {
  late CommonResponseModel _response;
  bool _isLoading = false;

  CommonResponseModel get response => _response;
  bool get isLoading => _isLoading;

  Future<void> uploadFile(http.MultipartRequest request) async {
    _isLoading = true;
    notifyListeners();

    try {
      var response = await request.send();
//Get the response from the server
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      Map<String, dynamic> user = jsonDecode(responseString);
      var commonResponse = CommonResponseModel.fromJson(user);
      if (response.statusCode == 200) {
        // Handle the successful response here
        print('File uploaded successfully');
        _response = commonResponse;

      } else {
        // Handle errors
        print('Failed to upload file');
      }
    } catch (e) {
      // Handle exceptions
      print('Exception occurred: $e');
    }
  }
}