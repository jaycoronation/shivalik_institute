import 'dart:convert';
/// success : "2"
/// message : "You have to logout from one of the listed devices to continue with this device."
/// devices : [{"device_type":"Android","device_name":"","device_token":"d_6h18pXRJSKnTBxk81BxK:APA91bE6PxMWw3RQ7N3aDZ-xDc1EnNY8ZEd5Td1QbsCTSqmXBIhe0zVRpI4yBUgQv_2CiJ1Zjy6TcFCVi5KrA51cOY4_Ud7Iymtmp7HwbvTTkmRZQ_0ZN2fYOsauYmXHX616VNuIS67a","is_force_logout":"0"}]

GenerateOtpResponseModel generateOtpResponseModelFromJson(String str) => GenerateOtpResponseModel.fromJson(json.decode(str));
String generateOtpResponseModelToJson(GenerateOtpResponseModel data) => json.encode(data.toJson());
class GenerateOtpResponseModel {
  GenerateOtpResponseModel({
      String? success, 
      String? message, 
      List<Devices>? devices,}){
    _success = success;
    _message = message;
    _devices = devices;
}

  GenerateOtpResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    if (json['devices'] != null) {
      _devices = [];
      json['devices'].forEach((v) {
        _devices?.add(Devices.fromJson(v));
      });
    }
  }
  String? _success;
  String? _message;
  List<Devices>? _devices;
GenerateOtpResponseModel copyWith({  String? success,
  String? message,
  List<Devices>? devices,
}) => GenerateOtpResponseModel(  success: success ?? _success,
  message: message ?? _message,
  devices: devices ?? _devices,
);
  String? get success => _success;
  String? get message => _message;
  List<Devices>? get devices => _devices;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_devices != null) {
      map['devices'] = _devices?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// device_type : "Android"
/// device_name : ""
/// device_token : "d_6h18pXRJSKnTBxk81BxK:APA91bE6PxMWw3RQ7N3aDZ-xDc1EnNY8ZEd5Td1QbsCTSqmXBIhe0zVRpI4yBUgQv_2CiJ1Zjy6TcFCVi5KrA51cOY4_Ud7Iymtmp7HwbvTTkmRZQ_0ZN2fYOsauYmXHX616VNuIS67a"
/// is_force_logout : "0"

Devices devicesFromJson(String str) => Devices.fromJson(json.decode(str));
String devicesToJson(Devices data) => json.encode(data.toJson());
class Devices {
  Devices({
      String? deviceType, 
      String? userId,
      String? deviceName,
      String? deviceToken, 
      String? isForceLogout,}){
    _deviceType = deviceType;
    _userId = userId;
    _deviceName = deviceName;
    _deviceToken = deviceToken;
    _isForceLogout = isForceLogout;
}

  Devices.fromJson(dynamic json) {
    _deviceType = json['device_type'];
    _userId = json['user_id'];
    _deviceName = json['device_name'];
    _deviceToken = json['device_token'];
    _isForceLogout = json['is_force_logout'];
  }
  String? _deviceType;
  String? _userId;
  String? _deviceName;
  String? _deviceToken;
  String? _isForceLogout;
Devices copyWith({  String? deviceType,
  String? userId,
  String? deviceName,
  String? deviceToken,
  String? isForceLogout,
}) => Devices(  deviceType: deviceType ?? _deviceType,
  userId: userId ?? _userId,
  deviceName: deviceName ?? _deviceName,
  deviceToken: deviceToken ?? _deviceToken,
  isForceLogout: isForceLogout ?? _isForceLogout,
);
  String? get deviceType => _deviceType;
  String? get userId => _userId;
  String? get deviceName => _deviceName;
  String? get deviceToken => _deviceToken;
  String? get isForceLogout => _isForceLogout;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['device_type'] = _deviceType;
    map['userId'] = _userId;
    map['device_name'] = _deviceName;
    map['device_token'] = _deviceToken;
    map['is_force_logout'] = _isForceLogout;
    return map;
  }

}