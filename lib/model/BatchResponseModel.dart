import 'dart:convert';
/// success : "1"
/// message : "List Found"
/// total_records : "14"
/// batch_list : [{"id":"1","name":"JRE08","batch_size":"50","start_date":"26-10-2023","end_date":"26-12-2023","start_time":"06:00 PM","end_time":"09:00 PM","is_active":"1","created_at":"29-09-2023","updated_at":"1698660534","deleted_at":"","pending_amount":"70400","batch_status":"ongoing","registration_close_date":"25-10-2023","batch_month_year":"2023-11","student_enrolled":"2","formated_date_time":"26th Oct 2023 (06:00 PM to 09:00 PM)","module_complete":1,"module_pending":10},{"id":"15","name":"JRE09","batch_size":"50","start_date":"25-11-2023","end_date":"25-01-2024","start_time":"01:30 PM","end_time":"04:30 PM","is_active":"1","created_at":"30-10-2023","updated_at":"1698672040","deleted_at":"","pending_amount":null,"batch_status":"upcoming","registration_close_date":"30-11-2023","batch_month_year":"2023-11","student_enrolled":"6","formated_date_time":"25th Nov 2023 (01:30 PM to 04:30 PM)","module_complete":0,"module_pending":11},{"id":"3","name":"JRE10","batch_size":"50","start_date":"20-12-2023","end_date":"20-02-2024","start_time":"09:00 AM","end_time":"12:00 PM","is_active":"1","created_at":"29-09-2023","updated_at":"1698658130","deleted_at":"","pending_amount":null,"batch_status":"upcoming","registration_close_date":"16-12-2023","batch_month_year":"2023-12","student_enrolled":"0","formated_date_time":"20th Dec 2023 (09:00 AM to 12:00 PM)","module_complete":0,"module_pending":11},{"id":"4","name":"JRE11","batch_size":"25","start_date":"16-01-2024","end_date":"16-03-2024","start_time":"06:00 PM","end_time":"09:00 PM","is_active":"1","created_at":"29-09-2023","updated_at":"1698660166","deleted_at":"","pending_amount":null,"batch_status":"upcoming","registration_close_date":"12-01-2024","batch_month_year":"2024-01","student_enrolled":"0","formated_date_time":"16th Jan 2024 (06:00 PM to 09:00 PM)","module_complete":0,"module_pending":11},{"id":"5","name":"JRE12","batch_size":"50","start_date":"10-02-2024","end_date":"10-04-2024","start_time":"01:30 PM","end_time":"04:30 PM","is_active":"1","created_at":"29-09-2023","updated_at":"1698664658","deleted_at":"","pending_amount":null,"batch_status":"upcoming","registration_close_date":"07-02-2024","batch_month_year":"2024-02","student_enrolled":"0","formated_date_time":"10th Feb 2024 (01:30 PM to 04:30 PM)","module_complete":0,"module_pending":11},{"id":"6","name":"JRE13","batch_size":"50","start_date":"07-03-2024","end_date":"07-05-2024","start_time":"09:00 AM","end_time":"12:00 PM","is_active":"1","created_at":"29-09-2023","updated_at":"1698664680","deleted_at":"","pending_amount":null,"batch_status":"upcoming","registration_close_date":"04-03-2024","batch_month_year":"2024-03","student_enrolled":"0","formated_date_time":"7th Mar 2024 (09:00 AM to 12:00 PM)","module_complete":0,"module_pending":11},{"id":"7","name":"JRE14","batch_size":"50","start_date":"04-04-2024","end_date":"04-06-2024","start_time":"06:00 PM","end_time":"09:00 PM","is_active":"1","created_at":"29-09-2023","updated_at":"1698664695","deleted_at":"","pending_amount":null,"batch_status":"upcoming","registration_close_date":"01-04-2024","batch_month_year":"2024-04","student_enrolled":"0","formated_date_time":"4th Apr 2024 (06:00 PM to 09:00 PM)","module_complete":0,"module_pending":11},{"id":"8","name":"JRE15","batch_size":"50","start_date":"01-05-2024","end_date":"01-07-2024","start_time":"01:30 PM","end_time":"04:30 PM","is_active":"1","created_at":"29-09-2023","updated_at":"1698664704","deleted_at":"","pending_amount":null,"batch_status":"upcoming","registration_close_date":"27-04-2024","batch_month_year":"2024-04","student_enrolled":"0","formated_date_time":"1st May 2024 (01:30 PM to 04:30 PM)","module_complete":0,"module_pending":11},{"id":"9","name":"JRE16","batch_size":"50","start_date":"27-05-2024","end_date":"27-07-2024","start_time":"09:00 AM","end_time":"12:00 PM","is_active":"1","created_at":"29-09-2023","updated_at":"1698664717","deleted_at":"","pending_amount":null,"batch_status":"upcoming","registration_close_date":"23-05-2024","batch_month_year":"2024-03","student_enrolled":"0","formated_date_time":"27th May 2024 (09:00 AM to 12:00 PM)","module_complete":0,"module_pending":11},{"id":"10","name":"JRE17","batch_size":"50","start_date":"20-06-2024","end_date":"20-08-2024","start_time":"06:00 PM","end_time":"09:00 PM","is_active":"1","created_at":"29-09-2023","updated_at":"1698664775","deleted_at":"","pending_amount":null,"batch_status":"upcoming","registration_close_date":"17-06-2024","batch_month_year":"2024-06","student_enrolled":"0","formated_date_time":"20th Jun 2024 (06:00 PM to 09:00 PM)","module_complete":0,"module_pending":11},{"id":"11","name":"JRE18","batch_size":"50","start_date":"15-07-2024","end_date":"16-09-2024","start_time":"01:30 PM","end_time":"04:30 PM","is_active":"1","created_at":"29-09-2023","updated_at":"1698664793","deleted_at":"","pending_amount":null,"batch_status":"upcoming","registration_close_date":"10-07-2024","batch_month_year":"2024-07","student_enrolled":"0","formated_date_time":"15th Jul 2024 (01:30 PM to 04:30 PM)","module_complete":0,"module_pending":11},{"id":"12","name":"JRE19","batch_size":"50","start_date":"12-08-2024","end_date":"15-10-2024","start_time":"09:00 AM","end_time":"12:00 PM","is_active":"1","created_at":"29-09-2023","updated_at":"1698664807","deleted_at":"","pending_amount":null,"batch_status":"upcoming","registration_close_date":"07-08-2024","batch_month_year":"2024-08","student_enrolled":"0","formated_date_time":"12th Aug 2024 (09:00 AM to 12:00 PM)","module_complete":0,"module_pending":11},{"id":"13","name":"JRE20","batch_size":"50","start_date":"05-09-2024","end_date":"30-11-2024","start_time":"06:00 PM","end_time":"09:00 PM","is_active":"1","created_at":"29-09-2023","updated_at":"1698664824","deleted_at":"","pending_amount":null,"batch_status":"upcoming","registration_close_date":"02-09-2024","batch_month_year":"2024-09","student_enrolled":"0","formated_date_time":"5th Sep 2024 (06:00 PM to 09:00 PM)","module_complete":0,"module_pending":11},{"id":"14","name":"JRE21","batch_size":"50","start_date":"03-10-2024","end_date":"03-12-2024","start_time":"01:30 PM","end_time":"04:30 PM","is_active":"1","created_at":"29-09-2023","updated_at":"1698673474","deleted_at":"","pending_amount":null,"batch_status":"upcoming","registration_close_date":"30-09-2024","batch_month_year":"2024-10","student_enrolled":"0","formated_date_time":"3rd Oct 2024 (01:30 PM to 04:30 PM)","module_complete":0,"module_pending":11}]

BatchResponseModel batchResponseModelFromJson(String str) => BatchResponseModel.fromJson(json.decode(str));
String batchResponseModelToJson(BatchResponseModel data) => json.encode(data.toJson());
class BatchResponseModel {
  BatchResponseModel({
      String? success, 
      String? message, 
      String? totalRecords, 
      List<BatchList>? batchList,}){
    _success = success;
    _message = message;
    _totalRecords = totalRecords;
    _batchList = batchList;
}

  BatchResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _totalRecords = json['total_records'];
    if (json['list'] != null) {
      _batchList = [];
      json['list'].forEach((v) {
        _batchList?.add(BatchList.fromJson(v));
      });
    }
  }
  String? _success;
  String? _message;
  String? _totalRecords;
  List<BatchList>? _batchList;
BatchResponseModel copyWith({  String? success,
  String? message,
  String? totalRecords,
  List<BatchList>? batchList,
}) => BatchResponseModel(  success: success ?? _success,
  message: message ?? _message,
  totalRecords: totalRecords ?? _totalRecords,
  batchList: batchList ?? _batchList,
);
  String? get success => _success;
  String? get message => _message;
  String? get totalRecords => _totalRecords;
  List<BatchList>? get batchList => _batchList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    map['total_records'] = _totalRecords;
    if (_batchList != null) {
      map['batch_list'] = _batchList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// name : "JRE08"
/// batch_size : "50"
/// start_date : "26-10-2023"
/// end_date : "26-12-2023"
/// start_time : "06:00 PM"
/// end_time : "09:00 PM"
/// is_active : "1"
/// created_at : "29-09-2023"
/// updated_at : "1698660534"
/// deleted_at : ""
/// pending_amount : "70400"
/// batch_status : "ongoing"
/// registration_close_date : "25-10-2023"
/// batch_month_year : "2023-11"
/// student_enrolled : "2"
/// formated_date_time : "26th Oct 2023 (06:00 PM to 09:00 PM)"
/// module_complete : 1
/// module_pending : 10

BatchList batchListFromJson(String str) => BatchList.fromJson(json.decode(str));
String batchListToJson(BatchList data) => json.encode(data.toJson());
class BatchList {
  BatchList({
      String? id, 
      String? name, 
      String? batchSize, 
      String? startDate, 
      String? endDate, 
      String? startTime, 
      String? endTime, 
      String? isActive, 
      String? createdAt, 
      String? updatedAt, 
      String? deletedAt, 
      String? pendingAmount, 
      String? batchStatus, 
      String? registrationCloseDate, 
      String? batchMonthYear, 
      String? studentEnrolled, 
      String? formatedDateTime, 
      num? moduleComplete, 
      num? modulePending,}){
    _id = id;
    _name = name;
    _batchSize = batchSize;
    _startDate = startDate;
    _endDate = endDate;
    _startTime = startTime;
    _endTime = endTime;
    _isActive = isActive;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _pendingAmount = pendingAmount;
    _batchStatus = batchStatus;
    _registrationCloseDate = registrationCloseDate;
    _batchMonthYear = batchMonthYear;
    _studentEnrolled = studentEnrolled;
    _formatedDateTime = formatedDateTime;
    _moduleComplete = moduleComplete;
    _modulePending = modulePending;
}

  BatchList.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _batchSize = json['batch_size'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _isActive = json['is_active'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
    _pendingAmount = json['pending_amount'];
    _batchStatus = json['batch_status'];
    _registrationCloseDate = json['registration_close_date'];
    _batchMonthYear = json['batch_month_year'];
    _studentEnrolled = json['student_enrolled'];
    _formatedDateTime = json['formated_date_time'];
    _moduleComplete = json['module_complete'];
    _modulePending = json['module_pending'];
  }
  String? _id;
  String? _name;
  String? _batchSize;
  String? _startDate;
  String? _endDate;
  String? _startTime;
  String? _endTime;
  String? _isActive;
  String? _createdAt;
  String? _updatedAt;
  String? _deletedAt;
  String? _pendingAmount;
  String? _batchStatus;
  String? _registrationCloseDate;
  String? _batchMonthYear;
  String? _studentEnrolled;
  String? _formatedDateTime;
  num? _moduleComplete;
  num? _modulePending;
BatchList copyWith({  String? id,
  String? name,
  String? batchSize,
  String? startDate,
  String? endDate,
  String? startTime,
  String? endTime,
  String? isActive,
  String? createdAt,
  String? updatedAt,
  String? deletedAt,
  String? pendingAmount,
  String? batchStatus,
  String? registrationCloseDate,
  String? batchMonthYear,
  String? studentEnrolled,
  String? formatedDateTime,
  num? moduleComplete,
  num? modulePending,
}) => BatchList(  id: id ?? _id,
  name: name ?? _name,
  batchSize: batchSize ?? _batchSize,
  startDate: startDate ?? _startDate,
  endDate: endDate ?? _endDate,
  startTime: startTime ?? _startTime,
  endTime: endTime ?? _endTime,
  isActive: isActive ?? _isActive,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
  pendingAmount: pendingAmount ?? _pendingAmount,
  batchStatus: batchStatus ?? _batchStatus,
  registrationCloseDate: registrationCloseDate ?? _registrationCloseDate,
  batchMonthYear: batchMonthYear ?? _batchMonthYear,
  studentEnrolled: studentEnrolled ?? _studentEnrolled,
  formatedDateTime: formatedDateTime ?? _formatedDateTime,
  moduleComplete: moduleComplete ?? _moduleComplete,
  modulePending: modulePending ?? _modulePending,
);
  String? get id => _id;
  String? get name => _name;
  String? get batchSize => _batchSize;
  String? get startDate => _startDate;
  String? get endDate => _endDate;
  String? get startTime => _startTime;
  String? get endTime => _endTime;
  String? get isActive => _isActive;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get deletedAt => _deletedAt;
  String? get pendingAmount => _pendingAmount;
  String? get batchStatus => _batchStatus;
  String? get registrationCloseDate => _registrationCloseDate;
  String? get batchMonthYear => _batchMonthYear;
  String? get studentEnrolled => _studentEnrolled;
  String? get formatedDateTime => _formatedDateTime;
  num? get moduleComplete => _moduleComplete;
  num? get modulePending => _modulePending;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['batch_size'] = _batchSize;
    map['start_date'] = _startDate;
    map['end_date'] = _endDate;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['is_active'] = _isActive;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    map['pending_amount'] = _pendingAmount;
    map['batch_status'] = _batchStatus;
    map['registration_close_date'] = _registrationCloseDate;
    map['batch_month_year'] = _batchMonthYear;
    map['student_enrolled'] = _studentEnrolled;
    map['formated_date_time'] = _formatedDateTime;
    map['module_complete'] = _moduleComplete;
    map['module_pending'] = _modulePending;
    return map;
  }

}