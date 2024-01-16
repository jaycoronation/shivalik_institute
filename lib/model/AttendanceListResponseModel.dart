import 'dart:convert';
/// success : "List Found"
/// message : ""
/// data : [{"start_time":"06:00PM","end_time":"09:00PM","class_no":"1","module_id":"2","class_id":"1","batch_id":"1","batch_name":"JRE08","module_name":"Introduction to Real Estate","student_id":"96","user_name":"Mr. Raj Shukla","attendance":"1","date":"26-10-2023","punch_in":"26-10-2023 06:05PM","punch_out":"26-10-2023 09:05PM"},{"start_time":"06:00PM","end_time":"09:00PM","class_no":"2","module_id":"2","class_id":"2","batch_id":"1","batch_name":"JRE08","module_name":"Introduction to Real Estate","student_id":"96","user_name":"Mr. Raj Shukla","attendance":"0","date":"27-10-2023","punch_in":"27-10-2023 06:05PM","punch_out":""},{"start_time":"06:00PM","end_time":"09:00PM","class_no":"3","module_id":"3","class_id":"3","batch_id":"1","batch_name":"JRE08","module_name":"Entrepreneurship in Real Estate","student_id":"96","user_name":"Mr. Raj Shukla","attendance":"0","date":"28-10-2023","punch_in":"","punch_out":"28-10-2023 09:05PM"},{"start_time":"06:00PM","end_time":"09:00PM","class_no":"4","module_id":"3","class_id":"4","batch_id":"1","batch_name":"JRE08","module_name":"Entrepreneurship in Real Estate","student_id":"96","user_name":"Mr. Raj Shukla","attendance":"0","date":"29-10-2023","punch_in":"","punch_out":""}]

AttendanceListResponseModel attendanceListResponseModelFromJson(String str) => AttendanceListResponseModel.fromJson(json.decode(str));
String attendanceListResponseModelToJson(AttendanceListResponseModel data) => json.encode(data.toJson());
class AttendanceListResponseModel {
  AttendanceListResponseModel({
      String? success, 
      String? message, 
      List<Data>? data,}){
    _success = success;
    _message = message;
    _data = data;
}

  AttendanceListResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _success;
  String? _message;
  List<Data>? _data;
AttendanceListResponseModel copyWith({  String? success,
  String? message,
  List<Data>? data,
}) => AttendanceListResponseModel(  success: success ?? _success,
  message: message ?? _message,
  data: data ?? _data,
);
  String? get success => _success;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// start_time : "06:00PM"
/// end_time : "09:00PM"
/// class_no : "1"
/// module_id : "2"
/// class_id : "1"
/// batch_id : "1"
/// batch_name : "JRE08"
/// module_name : "Introduction to Real Estate"
/// student_id : "96"
/// user_name : "Mr. Raj Shukla"
/// attendance : "1"
/// date : "26-10-2023"
/// punch_in : "26-10-2023 06:05PM"
/// punch_out : "26-10-2023 09:05PM"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? startTime, 
      String? endTime, 
      String? classNo, 
      String? moduleId, 
      String? classId, 
      String? batchId, 
      String? batchName, 
      String? moduleName, 
      String? studentId, 
      String? userName, 
      String? attendance, 
      String? date, 
      String? punchIn, 
      String? punchOut,}){
    _startTime = startTime;
    _endTime = endTime;
    _classNo = classNo;
    _moduleId = moduleId;
    _classId = classId;
    _batchId = batchId;
    _batchName = batchName;
    _moduleName = moduleName;
    _studentId = studentId;
    _userName = userName;
    _attendance = attendance;
    _date = date;
    _punchIn = punchIn;
    _punchOut = punchOut;
}

  Data.fromJson(dynamic json) {
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _classNo = json['class_no'];
    _moduleId = json['module_id'];
    _classId = json['class_id'];
    _batchId = json['batch_id'];
    _batchName = json['batch_name'];
    _moduleName = json['module_name'];
    _studentId = json['student_id'];
    _userName = json['user_name'];
    _attendance = json['attendance'];
    _date = json['date'];
    _punchIn = json['punch_in'];
    _punchOut = json['punch_out'];
  }
  String? _startTime;
  String? _endTime;
  String? _classNo;
  String? _moduleId;
  String? _classId;
  String? _batchId;
  String? _batchName;
  String? _moduleName;
  String? _studentId;
  String? _userName;
  String? _attendance;
  String? _date;
  String? _punchIn;
  String? _punchOut;
Data copyWith({  String? startTime,
  String? endTime,
  String? classNo,
  String? moduleId,
  String? classId,
  String? batchId,
  String? batchName,
  String? moduleName,
  String? studentId,
  String? userName,
  String? attendance,
  String? date,
  String? punchIn,
  String? punchOut,
}) => Data(  startTime: startTime ?? _startTime,
  endTime: endTime ?? _endTime,
  classNo: classNo ?? _classNo,
  moduleId: moduleId ?? _moduleId,
  classId: classId ?? _classId,
  batchId: batchId ?? _batchId,
  batchName: batchName ?? _batchName,
  moduleName: moduleName ?? _moduleName,
  studentId: studentId ?? _studentId,
  userName: userName ?? _userName,
  attendance: attendance ?? _attendance,
  date: date ?? _date,
  punchIn: punchIn ?? _punchIn,
  punchOut: punchOut ?? _punchOut,
);
  String? get startTime => _startTime;
  String? get endTime => _endTime;
  String? get classNo => _classNo;
  String? get moduleId => _moduleId;
  String? get classId => _classId;
  String? get batchId => _batchId;
  String? get batchName => _batchName;
  String? get moduleName => _moduleName;
  String? get studentId => _studentId;
  String? get userName => _userName;
  String? get attendance => _attendance;
  String? get date => _date;
  String? get punchIn => _punchIn;
  String? get punchOut => _punchOut;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['class_no'] = _classNo;
    map['module_id'] = _moduleId;
    map['class_id'] = _classId;
    map['batch_id'] = _batchId;
    map['batch_name'] = _batchName;
    map['module_name'] = _moduleName;
    map['student_id'] = _studentId;
    map['user_name'] = _userName;
    map['attendance'] = _attendance;
    map['date'] = _date;
    map['punch_in'] = _punchIn;
    map['punch_out'] = _punchOut;
    return map;
  }

}