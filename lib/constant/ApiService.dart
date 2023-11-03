import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shivalik_institute/model/CommonResponseModel.dart';
import '../model/BatchResponseModel.dart';
import '../model/CityResponseModel.dart';
import '../model/CountryResponseModel.dart';
import '../model/CourseResponseModel.dart';
import '../model/DashboardResponseModel.dart';
import '../model/StateViewResponseModel.dart';
import '../model/VerifyOtpResponseModel.dart';
import 'api_end_point.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';


class ApiService {

  static Future<CommonResponseModel> generateOtp(Map<String, String> jsonBody) async {

    final response = await http.post(Uri.parse(generateOTPUrl),body: jsonBody);
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return CommonResponseModel.fromJson(data);
    } else {
      throw Exception('Failed to load users');
    }
  }


  static Future<VerifyOtpResponseModel> verifyOtp(Map<String, String> jsonBody) async {

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    final response = await http.post(Uri.parse(verifyOTPUrl),body: jsonBody);
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return VerifyOtpResponseModel.fromJson(data);
    } else {
      throw Exception('Failed to load users');
    }
  }


  static Future<DashboardResponseModel> dashboard(Map<String, String> jsonBody) async {

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    final response = await http.post(Uri.parse(dashboardUrl),body: jsonBody);
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return DashboardResponseModel.fromJson(data);
    } else {
      throw Exception('Failed to load users');
    }
  }


  static Future<CourseResponseModel> courseList(Map<String, String> jsonBody) async {

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    final response = await http.post(Uri.parse(courseListUrl),body: jsonBody);
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return CourseResponseModel.fromJson(data);
    } else {
      throw Exception('Failed to load users');
    }
  }


  static Future<CountryResponseModel> countryList() async {

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    final response = await http.get(Uri.parse(countryListUrl),);
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return CountryResponseModel.fromJson(data);
    } else {
      throw Exception('Failed to load users');
    }
  }


  static Future<StateViewResponseModel> stateList(Map<String, String> jsonBody) async {

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    final response = await http.post(Uri.parse(stateListUrl),body: jsonBody);
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return StateViewResponseModel.fromJson(data);
    } else {
      throw Exception('Failed to load users');
    }
  }

  static Future<CityResponseModel> cityList(Map<String, String> jsonBody) async {

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    final response = await http.post(Uri.parse(cityListUrl),body: jsonBody);
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return CityResponseModel.fromJson(data);
    } else {
      throw Exception('Failed to load users');
    }
  }


  static Future<BatchResponseModel> batchList(Map<String, String> jsonBody) async {

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    final response = await http.post(Uri.parse(batchListUrl),body: jsonBody);
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return BatchResponseModel.fromJson(data);
    } else {
      throw Exception('Failed to load users');
    }
  }

  // static Future<ModuleResponseModel> moduleList(Map<String, String> jsonBody) async {
  //
  //   HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
  //     HttpLogger(logLevel: LogLevel.BODY),
  //   ]);
  //   final response = await http.post(Uri.parse(moduleListUrl),body: jsonBody);
  //   if (response.statusCode == 200) {
  //     final dynamic data = json.decode(response.body);
  //     return ModuleResponseModel.fromJson(data);
  //   } else {
  //     throw Exception('Failed to load users');
  //   }
  // }


}