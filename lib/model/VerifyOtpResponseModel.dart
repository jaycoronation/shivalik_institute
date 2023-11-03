import 'dart:convert';
/// success : "1"
/// message : "Logged In.....!"
/// user : {"id":"7","first_name":"Priya","last_name":"Gohil","user_type":"3","profile_pic":"","access_token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjciLCJBUElfVElNRSI6MTY5ODk5MDA1Mn0.9ibAy2qFBPkEgoZkqTKJsM0i2oTDaPSZ8nw7_x069BA"}
/// access_token : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjciLCJBUElfVElNRSI6MTY5ODk5MDA1Mn0.9ibAy2qFBPkEgoZkqTKJsM0i2oTDaPSZ8nw7_x069BA"

VerifyOtpResponseModel verifyOtpResponseModelFromJson(String str) => VerifyOtpResponseModel.fromJson(json.decode(str));
String verifyOtpResponseModelToJson(VerifyOtpResponseModel data) => json.encode(data.toJson());
class VerifyOtpResponseModel {
  VerifyOtpResponseModel({
      String? success, 
      String? message, 
      User? user, 
      String? accessToken,}){
    _success = success;
    _message = message;
    _user = user;
    _accessToken = accessToken;
}

  VerifyOtpResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _accessToken = json['access_token'];
  }
  String? _success;
  String? _message;
  User? _user;
  String? _accessToken;
VerifyOtpResponseModel copyWith({  String? success,
  String? message,
  User? user,
  String? accessToken,
}) => VerifyOtpResponseModel(  success: success ?? _success,
  message: message ?? _message,
  user: user ?? _user,
  accessToken: accessToken ?? _accessToken,
);
  String? get success => _success;
  String? get message => _message;
  User? get user => _user;
  String? get accessToken => _accessToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['access_token'] = _accessToken;
    return map;
  }

}

/// id : "7"
/// first_name : "Priya"
/// last_name : "Gohil"
/// user_type : "3"
/// profile_pic : ""
/// access_token : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjciLCJBUElfVElNRSI6MTY5ODk5MDA1Mn0.9ibAy2qFBPkEgoZkqTKJsM0i2oTDaPSZ8nw7_x069BA"

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
      String? id, 
      String? firstName, 
      String? lastName, 
      String? userType, 
      String? profilePic, 
      String? accessToken,}){
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _userType = userType;
    _profilePic = profilePic;
    _accessToken = accessToken;
}

  User.fromJson(dynamic json) {
    _id = json['id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _userType = json['user_type'];
    _profilePic = json['profile_pic'];
    _accessToken = json['access_token'];
  }
  String? _id;
  String? _firstName;
  String? _lastName;
  String? _userType;
  String? _profilePic;
  String? _accessToken;
User copyWith({  String? id,
  String? firstName,
  String? lastName,
  String? userType,
  String? profilePic,
  String? accessToken,
}) => User(  id: id ?? _id,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  userType: userType ?? _userType,
  profilePic: profilePic ?? _profilePic,
  accessToken: accessToken ?? _accessToken,
);
  String? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get userType => _userType;
  String? get profilePic => _profilePic;
  String? get accessToken => _accessToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['user_type'] = _userType;
    map['profile_pic'] = _profilePic;
    map['access_token'] = _accessToken;
    return map;
  }

}