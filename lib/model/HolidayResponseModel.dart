import 'dart:convert';
/// success : "1"
/// message : "List Found"
/// total_records : "2"
/// holiday_list : [{"id":"3","title":"Diwali","description":"Festival of Lights","holiday_date":"12-11-2023","status":"1","created_at":"1698304510","updated_at":"1698305119","deleted_at":""},{"id":"4","title":"Christmas","description":"Christmas Description","holiday_date":"25-12-2023","status":"1","created_at":"1698304935","updated_at":"1698305130","deleted_at":""}]

HolidayResponseModel holidayResponseModelFromJson(String str) => HolidayResponseModel.fromJson(json.decode(str));
String holidayResponseModelToJson(HolidayResponseModel data) => json.encode(data.toJson());
class HolidayResponseModel {
  HolidayResponseModel({
      String? success, 
      String? message, 
      String? totalRecords, 
      List<HolidayList>? holidayList,}){
    _success = success;
    _message = message;
    _totalRecords = totalRecords;
    _holidayList = holidayList;
}

  HolidayResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _totalRecords = json['total_records'];
    if (json['list'] != null) {
      _holidayList = [];
      json['list'].forEach((v) {
        _holidayList?.add(HolidayList.fromJson(v));
      });
    }
  }
  String? _success;
  String? _message;
  String? _totalRecords;
  List<HolidayList>? _holidayList;
HolidayResponseModel copyWith({  String? success,
  String? message,
  String? totalRecords,
  List<HolidayList>? holidayList,
}) => HolidayResponseModel(  success: success ?? _success,
  message: message ?? _message,
  totalRecords: totalRecords ?? _totalRecords,
  holidayList: holidayList ?? _holidayList,
);
  String? get success => _success;
  String? get message => _message;
  String? get totalRecords => _totalRecords;
  List<HolidayList>? get holidayList => _holidayList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    map['total_records'] = _totalRecords;
    if (_holidayList != null) {
      map['holiday_list'] = _holidayList?.map((v) => v.toJson()).toList();
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

HolidayList holidayListFromJson(String str) => HolidayList.fromJson(json.decode(str));
String holidayListToJson(HolidayList data) => json.encode(data.toJson());
class HolidayList {
  HolidayList({
      String? id, 
      String? title, 
      String? description, 
      String? holidayDate, 
      String? toDate,
      String? status,
      String? createdAt, 
      String? updatedAt, 
      String? deletedAt,}){
    _id = id;
    _title = title;
    _description = description;
    _holidayDate = holidayDate;
    _toDate = toDate;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
}

  HolidayList.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _holidayDate = json['holiday_date'];
    _toDate = json['to_date'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
  }
  String? _id;
  String? _title;
  String? _description;
  String? _holidayDate;
  String? _toDate;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  String? _deletedAt;
HolidayList copyWith({  String? id,
  String? title,
  String? description,
  String? holidayDate,
  String? toDate,
  String? status,
  String? createdAt,
  String? updatedAt,
  String? deletedAt,
}) => HolidayList(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
  holidayDate: holidayDate ?? _holidayDate,
  toDate: toDate ?? _toDate,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
);
  String? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get holidayDate => _holidayDate;
  String? get toDate => _toDate;
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
    map['to_date'] = _toDate;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    return map;
  }

}