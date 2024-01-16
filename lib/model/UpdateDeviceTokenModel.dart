import 'dart:convert';
/// is_force_logout : "0"
/// success : 1
/// message : "Token successfully updated."

UpdateDeviceTokenModel updateDeviceTokenModelFromJson(String str) => UpdateDeviceTokenModel.fromJson(json.decode(str));
String updateDeviceTokenModelToJson(UpdateDeviceTokenModel data) => json.encode(data.toJson());
class UpdateDeviceTokenModel {
  UpdateDeviceTokenModel({
      String? isForceLogout, 
      num? success, 
      String? message,}){
    _isForceLogout = isForceLogout;
    _success = success;
    _message = message;
}

  UpdateDeviceTokenModel.fromJson(dynamic json) {
    _isForceLogout = json['is_force_logout'];
    _success = json['success'];
    _message = json['message'];
  }
  String? _isForceLogout;
  num? _success;
  String? _message;
UpdateDeviceTokenModel copyWith({  String? isForceLogout,
  num? success,
  String? message,
}) => UpdateDeviceTokenModel(  isForceLogout: isForceLogout ?? _isForceLogout,
  success: success ?? _success,
  message: message ?? _message,
);
  String? get isForceLogout => _isForceLogout;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_force_logout'] = _isForceLogout;
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}