import 'dart:convert';
/// states : [{"id":"1","name":"Andaman and Nicobar Islands","country_id":"101"},{"id":"2","name":"Andhra Pradesh","country_id":"101"},{"id":"3","name":"Arunachal Pradesh","country_id":"101"},{"id":"4","name":"Assam","country_id":"101"},{"id":"5","name":"Bihar","country_id":"101"},{"id":"6","name":"Chandigarh","country_id":"101"},{"id":"7","name":"Chhattisgarh","country_id":"101"},{"id":"8","name":"Dadra and Nagar Haveli","country_id":"101"},{"id":"9","name":"Daman and Diu","country_id":"101"},{"id":"10","name":"Delhi-NCR","country_id":"101"},{"id":"11","name":"Goa","country_id":"101"},{"id":"12","name":"Gujarat","country_id":"101"},{"id":"13","name":"Haryana","country_id":"101"},{"id":"14","name":"Himachal Pradesh","country_id":"101"},{"id":"15","name":"Jammu and Kashmir","country_id":"101"},{"id":"16","name":"Jharkhand","country_id":"101"},{"id":"17","name":"Karnataka","country_id":"101"},{"id":"18","name":"Kenmore","country_id":"101"},{"id":"19","name":"Kerala","country_id":"101"},{"id":"20","name":"Lakshadweep","country_id":"101"},{"id":"21","name":"Madhya Pradesh","country_id":"101"},{"id":"22","name":"Maharashtra","country_id":"101"},{"id":"23","name":"Manipur","country_id":"101"},{"id":"24","name":"Meghalaya","country_id":"101"},{"id":"25","name":"Mizoram","country_id":"101"},{"id":"26","name":"Nagaland","country_id":"101"},{"id":"27","name":"Narora","country_id":"101"},{"id":"28","name":"Natwar","country_id":"101"},{"id":"29","name":"Odisha","country_id":"101"},{"id":"30","name":"Paschim Medinipur","country_id":"101"},{"id":"31","name":"Pondicherry","country_id":"101"},{"id":"32","name":"Punjab","country_id":"101"},{"id":"33","name":"Rajasthan","country_id":"101"},{"id":"34","name":"Sikkim","country_id":"101"},{"id":"35","name":"Tamil Nadu","country_id":"101"},{"id":"36","name":"Telangana","country_id":"101"},{"id":"37","name":"Tripura","country_id":"101"},{"id":"38","name":"TEST","country_id":"101"},{"id":"39","name":"UP-1","country_id":"101"},{"id":"40","name":"xxxxxx","country_id":"101"},{"id":"41","name":"West Bengal","country_id":"101"},{"id":"42","name":"UP-2","country_id":"101"}]
/// success : "1"
/// message : "States found"

StateViewResponseModel stateViewResponseModelFromJson(String str) => StateViewResponseModel.fromJson(json.decode(str));
String stateViewResponseModelToJson(StateViewResponseModel data) => json.encode(data.toJson());
class StateViewResponseModel {
  StateViewResponseModel({
      List<States>? states, 
      String? success, 
      String? message,}){
    _states = states;
    _success = success;
    _message = message;
}

  StateViewResponseModel.fromJson(dynamic json) {
    if (json['states'] != null) {
      _states = [];
      json['states'].forEach((v) {
        _states?.add(States.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
  }
  List<States>? _states;
  String? _success;
  String? _message;
StateViewResponseModel copyWith({  List<States>? states,
  String? success,
  String? message,
}) => StateViewResponseModel(  states: states ?? _states,
  success: success ?? _success,
  message: message ?? _message,
);
  List<States>? get states => _states;
  String? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_states != null) {
      map['states'] = _states?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// id : "1"
/// name : "Andaman and Nicobar Islands"
/// country_id : "101"

States statesFromJson(String str) => States.fromJson(json.decode(str));
String statesToJson(States data) => json.encode(data.toJson());
class States {
  States({
      String? id, 
      String? name, 
      String? countryId,}){
    _id = id;
    _name = name;
    _countryId = countryId;
}

  States.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _countryId = json['country_id'];
  }
  String? _id;
  String? _name;
  String? _countryId;
States copyWith({  String? id,
  String? name,
  String? countryId,
}) => States(  id: id ?? _id,
  name: name ?? _name,
  countryId: countryId ?? _countryId,
);
  String? get id => _id;
  String? get name => _name;
  String? get countryId => _countryId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['country_id'] = _countryId;
    return map;
  }

}