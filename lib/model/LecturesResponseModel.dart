import 'dart:convert';
/// success : "1"
/// message : "List Found"
/// total_records : "1"
/// lecture_list : [{"id":"2","batch_id":"1","module_id":"2","faculty_id":"","title":"","brief":"","date":"27th Oct, 2023","start_time":"06:00 PM","end_time":"09:00 PM","is_active":"1","created_at":"18-10-2023","updated_at":"1697716662","deleted_at":"","is_cancelled":"","cancel_reason":"","batch_details":{"id":"1","name":"JRE08","start_date":"26-10-2023","start_time":"06:00 PM","end_time":"09:00 PM"},"module_details":{"id":"2","name":"Introduction to Real Estate","description":"Gain a foundational understanding of the dynamic world of real estate\r\nof reforms in the field of Real Estate"},"class_material":[],"class_worksheet":[],"class_no":"2","class_no_format":"JRE08-class2","session1_faculty":"57","session1_topic":"Overview on type of Markets","session1_lecture_type":"Normal","session1_starttime":"","session1_endtime":"","session1_prefix":"Dr.","session1_faculty_name":"Sapan  Shah","session1_linked_profile":"","session2_faculty":"59","session2_topic":"Ahmedabad Real Estate Market","session2_lecture_type":"Normal","session2_starttime":"","session2_endtime":"","session2_prefix":"Mr.","session2_faculty_name":"Anup  Shah","session2_linked_profile":""}]

LecturesResponseModel lecturesResponseModelFromJson(String str) => LecturesResponseModel.fromJson(json.decode(str));
String lecturesResponseModelToJson(LecturesResponseModel data) => json.encode(data.toJson());
class LecturesResponseModel {
  LecturesResponseModel({
      String? success, 
      String? message, 
      String? totalRecords, 
      List<LectureList>? lectureList,}){
    _success = success;
    _message = message;
    _totalRecords = totalRecords;
    _lectureList = lectureList;
}

  LecturesResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _totalRecords = json['total_records'];
    if (json['list'] != null) {
      _lectureList = [];
      json['list'].forEach((v) {
        _lectureList?.add(LectureList.fromJson(v));
      });
    }
  }
  String? _success;
  String? _message;
  String? _totalRecords;
  List<LectureList>? _lectureList;
LecturesResponseModel copyWith({  String? success,
  String? message,
  String? totalRecords,
  List<LectureList>? lectureList,
}) => LecturesResponseModel(  success: success ?? _success,
  message: message ?? _message,
  totalRecords: totalRecords ?? _totalRecords,
  lectureList: lectureList ?? _lectureList,
);
  String? get success => _success;
  String? get message => _message;
  String? get totalRecords => _totalRecords;
  List<LectureList>? get lectureList => _lectureList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    map['total_records'] = _totalRecords;
    if (_lectureList != null) {
      map['lecture_list'] = _lectureList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "2"
/// batch_id : "1"
/// module_id : "2"
/// faculty_id : ""
/// title : ""
/// brief : ""
/// date : "27th Oct, 2023"
/// start_time : "06:00 PM"
/// end_time : "09:00 PM"
/// is_active : "1"
/// created_at : "18-10-2023"
/// updated_at : "1697716662"
/// deleted_at : ""
/// is_cancelled : ""
/// cancel_reason : ""
/// batch_details : {"id":"1","name":"JRE08","start_date":"26-10-2023","start_time":"06:00 PM","end_time":"09:00 PM"}
/// module_details : {"id":"2","name":"Introduction to Real Estate","description":"Gain a foundational understanding of the dynamic world of real estate\r\nof reforms in the field of Real Estate"}
/// class_material : []
/// class_worksheet : []
/// class_no : "2"
/// class_no_format : "JRE08-class2"
/// session1_faculty : "57"
/// session1_topic : "Overview on type of Markets"
/// session1_lecture_type : "Normal"
/// session1_starttime : ""
/// session1_endtime : ""
/// session1_prefix : "Dr."
/// session1_faculty_name : "Sapan  Shah"
/// session1_linked_profile : ""
/// session2_faculty : "59"
/// session2_topic : "Ahmedabad Real Estate Market"
/// session2_lecture_type : "Normal"
/// session2_starttime : ""
/// session2_endtime : ""
/// session2_prefix : "Mr."
/// session2_faculty_name : "Anup  Shah"
/// session2_linked_profile : ""

LectureList lectureListFromJson(String str) => LectureList.fromJson(json.decode(str));
String lectureListToJson(LectureList data) => json.encode(data.toJson());
class LectureList {
  LectureList({
      String? id, 
      String? batchId, 
      String? moduleId, 
      String? facultyId, 
      String? title, 
      String? brief, 
      String? date, 
      String? startTime, 
      String? endTime, 
      String? isActive, 
      String? createdAt, 
      String? updatedAt, 
      String? deletedAt, 
      String? isCancelled, 
      String? cancelReason, 
      BatchDetails? batchDetails, 
      ModuleDetails? moduleDetails, 
      List<dynamic>? classMaterial, 
      List<dynamic>? classWorksheet, 
      String? classNo, 
      String? classNoFormat, 
      String? session1Faculty, 
      String? session1Topic, 
      String? session1LectureType, 
      String? session1Starttime, 
      String? session1Endtime, 
      String? session1Prefix, 
      String? session1FacultyName, 
      String? session1LinkedProfile, 
      String? session2Faculty, 
      String? session2Topic, 
      String? session2LectureType, 
      String? session2Starttime, 
      String? session2Endtime, 
      String? session2Prefix, 
      String? session2FacultyName, 
      String? session2LinkedProfile,}){
    _id = id;
    _batchId = batchId;
    _moduleId = moduleId;
    _facultyId = facultyId;
    _title = title;
    _brief = brief;
    _date = date;
    _startTime = startTime;
    _endTime = endTime;
    _isActive = isActive;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _isCancelled = isCancelled;
    _cancelReason = cancelReason;
    _batchDetails = batchDetails;
    _moduleDetails = moduleDetails;
    _classMaterial = classMaterial;
    _classWorksheet = classWorksheet;
    _classNo = classNo;
    _classNoFormat = classNoFormat;
    _session1Faculty = session1Faculty;
    _session1Topic = session1Topic;
    _session1LectureType = session1LectureType;
    _session1Starttime = session1Starttime;
    _session1Endtime = session1Endtime;
    _session1Prefix = session1Prefix;
    _session1FacultyName = session1FacultyName;
    _session1LinkedProfile = session1LinkedProfile;
    _session2Faculty = session2Faculty;
    _session2Topic = session2Topic;
    _session2LectureType = session2LectureType;
    _session2Starttime = session2Starttime;
    _session2Endtime = session2Endtime;
    _session2Prefix = session2Prefix;
    _session2FacultyName = session2FacultyName;
    _session2LinkedProfile = session2LinkedProfile;
}

  LectureList.fromJson(dynamic json) {
    _id = json['id'];
    _batchId = json['batch_id'];
    _moduleId = json['module_id'];
    _facultyId = json['faculty_id'];
    _title = json['title'];
    _brief = json['brief'];
    _date = json['date'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _isActive = json['is_active'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
    _isCancelled = json['is_cancelled'];
    _cancelReason = json['cancel_reason'];
    _batchDetails = json['batch_details'] != null ? BatchDetails.fromJson(json['batch_details']) : null;
    _moduleDetails = json['module_details'] != null ? ModuleDetails.fromJson(json['module_details']) : null;
    if (json['class_material'] != null) {
      _classMaterial = [];
      json['class_material'].forEach((v) {
        //_classMaterial?.add(Dynamic.fromJson(v));
      });
    }
    if (json['class_worksheet'] != null) {
      _classWorksheet = [];
      json['class_worksheet'].forEach((v) {
        //_classWorksheet?.add(Dynamic.fromJson(v));
      });
    }
    _classNo = json['class_no'];
    _classNoFormat = json['class_no_format'];
    _session1Faculty = json['session1_faculty'];
    _session1Topic = json['session1_topic'];
    _session1LectureType = json['session1_lecture_type'];
    _session1Starttime = json['session1_starttime'];
    _session1Endtime = json['session1_endtime'];
    _session1Prefix = json['session1_prefix'];
    _session1FacultyName = json['session1_faculty_name'];
    _session1LinkedProfile = json['session1_linked_profile'];
    _session2Faculty = json['session2_faculty'];
    _session2Topic = json['session2_topic'];
    _session2LectureType = json['session2_lecture_type'];
    _session2Starttime = json['session2_starttime'];
    _session2Endtime = json['session2_endtime'];
    _session2Prefix = json['session2_prefix'];
    _session2FacultyName = json['session2_faculty_name'];
    _session2LinkedProfile = json['session2_linked_profile'];
  }
  String? _id;
  String? _batchId;
  String? _moduleId;
  String? _facultyId;
  String? _title;
  String? _brief;
  String? _date;
  String? _startTime;
  String? _endTime;
  String? _isActive;
  String? _createdAt;
  String? _updatedAt;
  String? _deletedAt;
  String? _isCancelled;
  String? _cancelReason;
  BatchDetails? _batchDetails;
  ModuleDetails? _moduleDetails;
  List<dynamic>? _classMaterial;
  List<dynamic>? _classWorksheet;
  String? _classNo;
  String? _classNoFormat;
  String? _session1Faculty;
  String? _session1Topic;
  String? _session1LectureType;
  String? _session1Starttime;
  String? _session1Endtime;
  String? _session1Prefix;
  String? _session1FacultyName;
  String? _session1LinkedProfile;
  String? _session2Faculty;
  String? _session2Topic;
  String? _session2LectureType;
  String? _session2Starttime;
  String? _session2Endtime;
  String? _session2Prefix;
  String? _session2FacultyName;
  String? _session2LinkedProfile;
LectureList copyWith({  String? id,
  String? batchId,
  String? moduleId,
  String? facultyId,
  String? title,
  String? brief,
  String? date,
  String? startTime,
  String? endTime,
  String? isActive,
  String? createdAt,
  String? updatedAt,
  String? deletedAt,
  String? isCancelled,
  String? cancelReason,
  BatchDetails? batchDetails,
  ModuleDetails? moduleDetails,
  List<dynamic>? classMaterial,
  List<dynamic>? classWorksheet,
  String? classNo,
  String? classNoFormat,
  String? session1Faculty,
  String? session1Topic,
  String? session1LectureType,
  String? session1Starttime,
  String? session1Endtime,
  String? session1Prefix,
  String? session1FacultyName,
  String? session1LinkedProfile,
  String? session2Faculty,
  String? session2Topic,
  String? session2LectureType,
  String? session2Starttime,
  String? session2Endtime,
  String? session2Prefix,
  String? session2FacultyName,
  String? session2LinkedProfile,
}) => LectureList(  id: id ?? _id,
  batchId: batchId ?? _batchId,
  moduleId: moduleId ?? _moduleId,
  facultyId: facultyId ?? _facultyId,
  title: title ?? _title,
  brief: brief ?? _brief,
  date: date ?? _date,
  startTime: startTime ?? _startTime,
  endTime: endTime ?? _endTime,
  isActive: isActive ?? _isActive,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
  isCancelled: isCancelled ?? _isCancelled,
  cancelReason: cancelReason ?? _cancelReason,
  batchDetails: batchDetails ?? _batchDetails,
  moduleDetails: moduleDetails ?? _moduleDetails,
  classMaterial: classMaterial ?? _classMaterial,
  classWorksheet: classWorksheet ?? _classWorksheet,
  classNo: classNo ?? _classNo,
  classNoFormat: classNoFormat ?? _classNoFormat,
  session1Faculty: session1Faculty ?? _session1Faculty,
  session1Topic: session1Topic ?? _session1Topic,
  session1LectureType: session1LectureType ?? _session1LectureType,
  session1Starttime: session1Starttime ?? _session1Starttime,
  session1Endtime: session1Endtime ?? _session1Endtime,
  session1Prefix: session1Prefix ?? _session1Prefix,
  session1FacultyName: session1FacultyName ?? _session1FacultyName,
  session1LinkedProfile: session1LinkedProfile ?? _session1LinkedProfile,
  session2Faculty: session2Faculty ?? _session2Faculty,
  session2Topic: session2Topic ?? _session2Topic,
  session2LectureType: session2LectureType ?? _session2LectureType,
  session2Starttime: session2Starttime ?? _session2Starttime,
  session2Endtime: session2Endtime ?? _session2Endtime,
  session2Prefix: session2Prefix ?? _session2Prefix,
  session2FacultyName: session2FacultyName ?? _session2FacultyName,
  session2LinkedProfile: session2LinkedProfile ?? _session2LinkedProfile,
);
  String? get id => _id;
  String? get batchId => _batchId;
  String? get moduleId => _moduleId;
  String? get facultyId => _facultyId;
  String? get title => _title;
  String? get brief => _brief;
  String? get date => _date;
  String? get startTime => _startTime;
  String? get endTime => _endTime;
  String? get isActive => _isActive;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get deletedAt => _deletedAt;
  String? get isCancelled => _isCancelled;
  String? get cancelReason => _cancelReason;
  BatchDetails? get batchDetails => _batchDetails;
  ModuleDetails? get moduleDetails => _moduleDetails;
  List<dynamic>? get classMaterial => _classMaterial;
  List<dynamic>? get classWorksheet => _classWorksheet;
  String? get classNo => _classNo;
  String? get classNoFormat => _classNoFormat;
  String? get session1Faculty => _session1Faculty;
  String? get session1Topic => _session1Topic;
  String? get session1LectureType => _session1LectureType;
  String? get session1Starttime => _session1Starttime;
  String? get session1Endtime => _session1Endtime;
  String? get session1Prefix => _session1Prefix;
  String? get session1FacultyName => _session1FacultyName;
  String? get session1LinkedProfile => _session1LinkedProfile;
  String? get session2Faculty => _session2Faculty;
  String? get session2Topic => _session2Topic;
  String? get session2LectureType => _session2LectureType;
  String? get session2Starttime => _session2Starttime;
  String? get session2Endtime => _session2Endtime;
  String? get session2Prefix => _session2Prefix;
  String? get session2FacultyName => _session2FacultyName;
  String? get session2LinkedProfile => _session2LinkedProfile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['batch_id'] = _batchId;
    map['module_id'] = _moduleId;
    map['faculty_id'] = _facultyId;
    map['title'] = _title;
    map['brief'] = _brief;
    map['date'] = _date;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['is_active'] = _isActive;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    map['is_cancelled'] = _isCancelled;
    map['cancel_reason'] = _cancelReason;
    if (_batchDetails != null) {
      map['batch_details'] = _batchDetails?.toJson();
    }
    if (_moduleDetails != null) {
      map['module_details'] = _moduleDetails?.toJson();
    }
    if (_classMaterial != null) {
      map['class_material'] = _classMaterial?.map((v) => v.toJson()).toList();
    }
    if (_classWorksheet != null) {
      map['class_worksheet'] = _classWorksheet?.map((v) => v.toJson()).toList();
    }
    map['class_no'] = _classNo;
    map['class_no_format'] = _classNoFormat;
    map['session1_faculty'] = _session1Faculty;
    map['session1_topic'] = _session1Topic;
    map['session1_lecture_type'] = _session1LectureType;
    map['session1_starttime'] = _session1Starttime;
    map['session1_endtime'] = _session1Endtime;
    map['session1_prefix'] = _session1Prefix;
    map['session1_faculty_name'] = _session1FacultyName;
    map['session1_linked_profile'] = _session1LinkedProfile;
    map['session2_faculty'] = _session2Faculty;
    map['session2_topic'] = _session2Topic;
    map['session2_lecture_type'] = _session2LectureType;
    map['session2_starttime'] = _session2Starttime;
    map['session2_endtime'] = _session2Endtime;
    map['session2_prefix'] = _session2Prefix;
    map['session2_faculty_name'] = _session2FacultyName;
    map['session2_linked_profile'] = _session2LinkedProfile;
    return map;
  }

}

/// id : "2"
/// name : "Introduction to Real Estate"
/// description : "Gain a foundational understanding of the dynamic world of real estate\r\nof reforms in the field of Real Estate"

ModuleDetails moduleDetailsFromJson(String str) => ModuleDetails.fromJson(json.decode(str));
String moduleDetailsToJson(ModuleDetails data) => json.encode(data.toJson());
class ModuleDetails {
  ModuleDetails({
      String? id, 
      String? name, 
      String? description,}){
    _id = id;
    _name = name;
    _description = description;
}

  ModuleDetails.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
  }
  String? _id;
  String? _name;
  String? _description;
ModuleDetails copyWith({  String? id,
  String? name,
  String? description,
}) => ModuleDetails(  id: id ?? _id,
  name: name ?? _name,
  description: description ?? _description,
);
  String? get id => _id;
  String? get name => _name;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    return map;
  }

}

/// id : "1"
/// name : "JRE08"
/// start_date : "26-10-2023"
/// start_time : "06:00 PM"
/// end_time : "09:00 PM"

BatchDetails batchDetailsFromJson(String str) => BatchDetails.fromJson(json.decode(str));
String batchDetailsToJson(BatchDetails data) => json.encode(data.toJson());
class BatchDetails {
  BatchDetails({
      String? id, 
      String? name, 
      String? startDate, 
      String? startTime, 
      String? endTime,}){
    _id = id;
    _name = name;
    _startDate = startDate;
    _startTime = startTime;
    _endTime = endTime;
}

  BatchDetails.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _startDate = json['start_date'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
  }
  String? _id;
  String? _name;
  String? _startDate;
  String? _startTime;
  String? _endTime;
BatchDetails copyWith({  String? id,
  String? name,
  String? startDate,
  String? startTime,
  String? endTime,
}) => BatchDetails(  id: id ?? _id,
  name: name ?? _name,
  startDate: startDate ?? _startDate,
  startTime: startTime ?? _startTime,
  endTime: endTime ?? _endTime,
);
  String? get id => _id;
  String? get name => _name;
  String? get startDate => _startDate;
  String? get startTime => _startTime;
  String? get endTime => _endTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['start_date'] = _startDate;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    return map;
  }

}