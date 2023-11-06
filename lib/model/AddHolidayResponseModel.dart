import 'dart:convert';
/// success : "1"
/// message : "Details Found"
/// details : {"id":"3","title":"Diwali","description":"Festival of Lights","holiday_date":"12-11-2023","status":"1","created_at":"1698304510","updated_at":"1698305119","deleted_at":""}

AddHolidayResponseModel addHolidayResponseModelFromJson(String str) => AddHolidayResponseModel.fromJson(json.decode(str));
String addHolidayResponseModelToJson(AddHolidayResponseModel data) => json.encode(data.toJson());
class AddHolidayResponseModel {
  AddHolidayResponseModel({
      String? success, 
      String? message, 
      Details? details,}){
    _success = success;
    _message = message;
    _details = details;
}

  AddHolidayResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _details = json['details'] != null ? Details.fromJson(json['details']) : null;
  }
  String? _success;
  String? _message;
  Details? _details;
AddHolidayResponseModel copyWith({  String? success,
  String? message,
  Details? details,
}) => AddHolidayResponseModel(  success: success ?? _success,
  message: message ?? _message,
  details: details ?? _details,
);
  String? get success => _success;
  String? get message => _message;
  Details? get details => _details;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_details != null) {
      map['details'] = _details?.toJson();
    }
    return map;
  }

}

/// id : "3"
/// title : "Diwali"
/// description : "Festival of Lights"
/// holiday_date : "12-11-2023"
/// status : "1"
/// created_at : "1698304510"
/// updated_at : "1698305119"
/// deleted_at : ""

Details detailsFromJson(String str) => Details.fromJson(json.decode(str));
String detailsToJson(Details data) => json.encode(data.toJson());
class Details {
  Details({
      String? id, 
      String? title, 
      String? description, 
      String? holidayDate, 
      String? status, 
      String? createdAt, 
      String? updatedAt, 
      String? deletedAt,}){
    _id = id;
    _title = title;
    _description = description;
    _holidayDate = holidayDate;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
}

  Details.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _holidayDate = json['holiday_date'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
  }
  String? _id;
  String? _title;
  String? _description;
  String? _holidayDate;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  String? _deletedAt;
Details copyWith({  String? id,
  String? title,
  String? description,
  String? holidayDate,
  String? status,
  String? createdAt,
  String? updatedAt,
  String? deletedAt,
}) => Details(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
  holidayDate: holidayDate ?? _holidayDate,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
);
  String? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get holidayDate => _holidayDate;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get deletedAt => _deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['holiday_date'] = _holidayDate;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    return map;
  }

}