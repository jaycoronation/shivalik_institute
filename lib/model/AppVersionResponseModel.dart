import 'dart:convert';
/// version : "1.0"
/// force_update : "0"
/// success : 1
/// message : "Android version found!"

AppVersionResponseModel appVersionResponseModelFromJson(String str) => AppVersionResponseModel.fromJson(json.decode(str));
String appVersionResponseModelToJson(AppVersionResponseModel data) => json.encode(data.toJson());
class AppVersionResponseModel {
  AppVersionResponseModel({
      String? version, 
      String? forceUpdate, 
      num? success, 
      String? message,}){
    _version = version;
    _forceUpdate = forceUpdate;
    _success = success;
    _message = message;
}

  AppVersionResponseModel.fromJson(dynamic json) {
    _version = json['version'];
    _forceUpdate = json['force_update'];
    _success = json['success'];
    _message = json['message'];
  }
  String? _version;
  String? _forceUpdate;
  num? _success;
  String? _message;
AppVersionResponseModel copyWith({  String? version,
  String? forceUpdate,
  num? success,
  String? message,
}) => AppVersionResponseModel(  version: version ?? _version,
  forceUpdate: forceUpdate ?? _forceUpdate,
  success: success ?? _success,
  message: message ?? _message,
);
  String? get version => _version;
  String? get forceUpdate => _forceUpdate;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['version'] = _version;
    map['force_update'] = _forceUpdate;
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}