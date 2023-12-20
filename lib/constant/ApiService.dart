import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shivalik_institute/model/AddHolidayResponseModel.dart';
import 'package:shivalik_institute/model/CaseStudyResponseModel.dart';
import 'package:shivalik_institute/model/EventResponseModel.dart';
import 'package:shivalik_institute/model/LecturesResponseModel.dart';
import 'package:shivalik_institute/model/ModuleResponseModel.dart';
import 'package:shivalik_institute/model/UserListResponseModel.dart';
import '../model/BatchResponseModel.dart';
import '../model/CityResponseModel.dart';
import '../model/CommonResponseModel.dart';
import '../model/CountryResponseModel.dart';
import '../model/CourseResponseModel.dart';
import '../model/DashboardResponseModel.dart';
import '../model/HolidayResponseModel.dart';
import '../model/ManagmentResponseModel.dart';
import '../model/MaterialDetailResponseModel.dart';
import '../model/StateViewResponseModel.dart';
import '../model/TestimonialResponseModel.dart';
import '../model/UserProfileResponseModel.dart';
import '../model/VerifyOtpResponseModel.dart';
import 'api_end_point.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';


class ApiService {
  static Future<CommonResponseModel> generateOtp(Map<String, String> jsonBody) async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final response = await http.post(Uri.parse(generateOTPUrl),body: jsonBody);
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return CommonResponseModel.fromJson(data);
    } else {
      throw Exception('Failed to load users');
    }
  }

  static Future<CommonResponseModel> saveUserData(Map<String, String> jsonBody) async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    final response = await http.post(Uri.parse(saveUserDataUrl),body: jsonBody);
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

  static Future<UserListResponseModel> userList(Map<String, String> jsonBody) async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    final response = await http.post(Uri.parse(userListUrl),body: jsonBody);
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return UserListResponseModel.fromJson(data);
    } else {
      throw Exception('Failed to load users');
    }
  }

  static Future<UserProfileResponseModel> userDetails(Map<String, String> jsonBody) async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    final response = await http.post(Uri.parse(userProfileUrl),body: jsonBody);
    if (response.statusCode == 200) {
      try {
        final dynamic data = json.decode(response.body);
        return UserProfileResponseModel.fromJson(data);
      } on Exception catch (e) {
        print("EXECTIOn E === $e");
      }
      return UserProfileResponseModel();
    } else {
      throw Exception('Failed to load users');
    }
  }

  static Future<ModuleResponseModel> moduleList(Map<String, String> jsonBody) async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    final response = await http.post(Uri.parse(moduleListUrl),body: jsonBody);
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return ModuleResponseModel.fromJson(data);
    } else {
      throw Exception('Failed to load users');
    }
  }

  static Future<LecturesResponseModel> lectureList(Map<String, String> jsonBody) async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    final response = await http.post(Uri.parse(lectureListUrl),body: jsonBody);
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return LecturesResponseModel.fromJson(data);
    } else {
      throw Exception('Failed to load users');
    }
  }

  static Future<EventResponseModel> eventList(Map<String, String> jsonBody) async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    final response = await http.post(Uri.parse(eventListUrl),body: jsonBody);
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return EventResponseModel.fromJson(data);
    } else {
      throw Exception('Failed to load users');
    }
  }

  static Future<HolidayResponseModel> holidayList(Map<String, String> jsonBody) async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    final response = await http.post(Uri.parse(holidayListUrl),body: jsonBody);
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return HolidayResponseModel.fromJson(data);
    } else {
      throw Exception('Failed to load users');
    }
  }

  static Future<CaseStudyResponseModel> caseStudyList(Map<String, String> jsonBody) async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    final response = await http.post(Uri.parse(caseStudyListUrl),body: jsonBody);
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return CaseStudyResponseModel.fromJson(data);
    } else {
      throw Exception('Failed to load users');
    }
  }

  static Future<ManagementResponseModel> managementList(Map<String, String> jsonBody) async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    final response = await http.post(Uri.parse(managementsListUrl),body: jsonBody);
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return ManagementResponseModel.fromJson(data);
    } else {
      throw Exception('Failed to load users');
    }
  }

  static Future<TestimonialResponseModel> testimonialsList(Map<String, String> jsonBody) async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    final response = await http.post(Uri.parse(testimonialsListUrl),body: jsonBody);
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return TestimonialResponseModel.fromJson(data);
    } else {
      throw Exception('Failed to load users');
    }
  }

  static Future<MaterialDetailResponseModel> documentList(Map<String, String> jsonBody) async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    final response = await http.post(Uri.parse(materialListUrl),body: jsonBody);
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return MaterialDetailResponseModel.fromJson(data);
    } else {
      throw Exception('Failed to load users');
    }
  }


  static Future<MaterialDetailResponseModel> materialList(Map<String, String> jsonBody) async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    final response = await http.post(Uri.parse(materialDetailListUrl),body: jsonBody);
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return MaterialDetailResponseModel.fromJson(data);
    } else {
      throw Exception('Failed to load users');
    }
  }

  static Future<CommonResponseModel> saveHolidayAddData(Map<String, String> jsonBody) async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final response = await http.post(Uri.parse(holidayAddUrl),body: jsonBody);
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return CommonResponseModel.fromJson(data);
    } else {
      throw Exception('Failed to load users');
    }
  }

  static Future<AddHolidayResponseModel> addHolidayData(Map<String, String> jsonBody) async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final response = await http.post(Uri.parse(updateHolidayAddUrl),body: jsonBody);
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return AddHolidayResponseModel.fromJson(data);
    } else {
      throw Exception('Failed to load users');
    }
  }

  static Future<CommonResponseModel> deleteHolidayAddData(Map<String, String> jsonBody) async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final response = await http.post(Uri.parse(deelteHolidayAddUrl),body: jsonBody);
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return CommonResponseModel.fromJson(data);
    } else {
      throw Exception('Failed to load users');
    }
  }


  static Future<CommonResponseModel> deleteResourceData(Map<String, String> jsonBody) async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final response = await http.post(Uri.parse(deleteResourceAddUrl),body: jsonBody);
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return CommonResponseModel.fromJson(data);
    } else {
      throw Exception('Failed to load users');
    }
  }


  static Future<CommonResponseModel> uploadResourceData(Map<String, String> jsonBody) async {
        HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final response = await http.post(Uri.parse(uploadResourceAddUrl),body: jsonBody);
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return CommonResponseModel.fromJson(data);
    } else {
      throw Exception('Failed to load users');
    }
  }


}