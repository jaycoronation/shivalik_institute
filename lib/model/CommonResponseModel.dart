import 'dart:convert';
/// success : "1"
/// message : "OTP has been sent to your given mobile number."

CommonResponseModel generateOtpResponseModelFromJson(String str) => CommonResponseModel.fromJson(json.decode(str));
String generateOtpResponseModelToJson(CommonResponseModel data) => json.encode(data.toJson());
class CommonResponseModel {
  CommonResponseModel({
      String? success, 
      String? message,}){
    _success = success;
    _message = message;
}

  CommonResponseModel.fromJson(dynamic json) {
    _success = json['success'] is int ? (json['success']).toString() : json['success'];
    _message = json['message'];
  }
  String? _success;
  String? _message;
CommonResponseModel copyWith({  String? success,
  String? message,
}) => CommonResponseModel(  success: success ?? _success,
  message: message ?? _message,
);
  String? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}