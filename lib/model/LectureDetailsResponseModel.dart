import 'dart:convert';
/// success : "1"
/// message : "Details Found"
/// details : {"id":"12","batch_id":"1","module_id":"3","faculty_id":"","title":"","brief":"","date":"2024-01-12","start_time":"06:00 PM","end_time":"09:00 PM","start_time_t":"1705062600","end_time_t":"1705073400","is_active":"1","created_at":"10-01-2024","updated_at":"","deleted_at":"","bacth_details":{"id":"1","name":"JRE08","start_date":"26-10-2023","start_time":"06:00 PM","end_time":"09:00 PM"},"module_details":{"id":"3","name":"Entrepreneurship in Real Estate","description":"A Guide On All The ‘Know How’s’ Of Real Estate"},"class_material":[{"id":"21","class_id":"12","student_id":"","document_type":"material","file_type":"png","file":"1704949408images.png","caption":"","is_active":"1","created_at":"2024-01-11","updated_at":"","deleted_at":"","full_path":"https://shivalik.institute/api/assets/uploads/class_material/1704949408images.png"}],"class_worksheet":[],"class_no":"11","class_no_format":"JRE08-class11","is_module_complete":"1","has_submission":"1","session1_faculty":"101","session1_topic":"Test Data","session1_lecture_type":"Normal","session1_starttime":"","session1_endtime":"","session1_starttime_t":"","session1_endtime_t":"","session1_prefix":"Mrs.","session1_faculty_name":"Priya Gohil","session1_linked_profile":"","session2_faculty":"101","session2_topic":"Test Topic","session2_lecture_type":"Normal","session2_starttime":"","session2_endtime":"","session2_starttime_t":"","session2_endtime_t":"","session2_prefix":"Mrs.","session2_faculty_name":"Priya Gohil","session2_linked_profile":"","is_cancelled":"","cancel_reason":""}

LectureDetailsResponseModel lectureDetailsResponseModelFromJson(String str) => LectureDetailsResponseModel.fromJson(json.decode(str));
String lectureDetailsResponseModelToJson(LectureDetailsResponseModel data) => json.encode(data.toJson());
class LectureDetailsResponseModel {
  LectureDetailsResponseModel({
      String? success, 
      String? message,
      Details? details,}){
    _success = success;
    _message = message;
    _details = details;
}

  LectureDetailsResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _details = json['details'] != null ? Details.fromJson(json['details']) : null;
  }
  String? _success;
  String? _message;
  Details? _details;
LectureDetailsResponseModel copyWith({  String? success,
  String? message,
  Details? details,
}) => LectureDetailsResponseModel(  success: success ?? _success,
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

/// id : "12"
/// batch_id : "1"
/// module_id : "3"
/// faculty_id : ""
/// title : ""
/// brief : ""
/// date : "2024-01-12"
/// start_time : "06:00 PM"
/// end_time : "09:00 PM"
/// start_time_t : "1705062600"
/// end_time_t : "1705073400"
/// is_active : "1"
/// created_at : "10-01-2024"
/// updated_at : ""
/// deleted_at : ""
/// bacth_details : {"id":"1","name":"JRE08","start_date":"26-10-2023","start_time":"06:00 PM","end_time":"09:00 PM"}
/// module_details : {"id":"3","name":"Entrepreneurship in Real Estate","description":"A Guide On All The ‘Know How’s’ Of Real Estate"}
/// class_material : [{"id":"21","class_id":"12","student_id":"","document_type":"material","file_type":"png","file":"1704949408images.png","caption":"","is_active":"1","created_at":"2024-01-11","updated_at":"","deleted_at":"","full_path":"https://shivalik.institute/api/assets/uploads/class_material/1704949408images.png"}]
/// class_worksheet : []
/// class_no : "11"
/// class_no_format : "JRE08-class11"
/// is_module_complete : "1"
/// has_submission : "1"
/// session1_faculty : "101"
/// session1_topic : "Test Data"
/// session1_lecture_type : "Normal"
/// session1_starttime : ""
/// session1_endtime : ""
/// session1_starttime_t : ""
/// session1_endtime_t : ""
/// session1_prefix : "Mrs."
/// session1_faculty_name : "Priya Gohil"
/// session1_linked_profile : ""
/// session2_faculty : "101"
/// session2_topic : "Test Topic"
/// session2_lecture_type : "Normal"
/// session2_starttime : ""
/// session2_endtime : ""
/// session2_starttime_t : ""
/// session2_endtime_t : ""
/// session2_prefix : "Mrs."
/// session2_faculty_name : "Priya Gohil"
/// session2_linked_profile : ""
/// is_cancelled : ""
/// cancel_reason : ""

Details detailsFromJson(String str) => Details.fromJson(json.decode(str));
String detailsToJson(Details data) => json.encode(data.toJson());
class Details {
  Details({
      String? id,
      String? batchId,

      String? moduleId,
      String? facultyId,
      String? title,
      String? brief,
      String? date,
      String? startTime,
      String? endTime,
      String? startTimeT,
      String? endTimeT,
      String? isActive,
      String? createdAt,
      String? updatedAt,
      String? deletedAt,
      BacthDetails? bacthDetails,
      ModuleDetails? moduleDetails,
      List<ClassMaterial>? classMaterial,
      List<ClassWorksheet>? classWorksheet,
      String? classNo,
      String? classNoFormat,
      String? isModuleComplete,
      String? hasSubmission,
      String? session1Faculty,
      String? session1Topic,
      String? session1LectureType,
      String? session1Starttime,
      String? session1Endtime,
      String? session1StarttimeT,
      String? session1EndtimeT,
      String? session1Prefix,
      String? session1FacultyName,
      String? session1LinkedProfile,
      String? session1Location,
      String? session2Faculty,
      String? session2Topic,
      String? session2LectureType,
      String? session2Starttime,
      String? session2Endtime,
      String? session2StarttimeT,
      String? session2EndtimeT,
      String? session2Prefix,
      String? session2FacultyName,
      String? session2LinkedProfile,
      String? allowUploadSubmissions,
      String? isCancelled,
      String? cancelReason,}){
    _id = id;
    _batchId = batchId;
    _moduleId = moduleId;
    _facultyId = facultyId;
    _title = title;
    _brief = brief;
    _date = date;
    _startTime = startTime;
    _endTime = endTime;
    _startTimeT = startTimeT;
    _endTimeT = endTimeT;
    _isActive = isActive;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _bacthDetails = bacthDetails;
    _moduleDetails = moduleDetails;
    _classMaterial = classMaterial;
    _classWorksheet = classWorksheet;
    _classNo = classNo;
    _classNoFormat = classNoFormat;
    _isModuleComplete = isModuleComplete;
    _hasSubmission = hasSubmission;
    _session1Faculty = session1Faculty;
    _session1Topic = session1Topic;
    _session1LectureType = session1LectureType;
    _session1Starttime = session1Starttime;
    _session1Endtime = session1Endtime;
    _session1StarttimeT = session1StarttimeT;
    _session1EndtimeT = session1EndtimeT;
    _session1Prefix = session1Prefix;
    _session1FacultyName = session1FacultyName;
    _session1LinkedProfile = session1LinkedProfile;
    _session1Location = session1Location;
    _session2Faculty = session2Faculty;
    _session2Topic = session2Topic;
    _session2LectureType = session2LectureType;
    _session2Starttime = session2Starttime;
    _session2Endtime = session2Endtime;
    _session2StarttimeT = session2StarttimeT;
    _session2EndtimeT = session2EndtimeT;
    _session2Prefix = session2Prefix;
    _session2FacultyName = session2FacultyName;
    _session2LinkedProfile = session2LinkedProfile;
    _allowUploadSubmissions = allowUploadSubmissions;
    _isCancelled = isCancelled;
    _cancelReason = cancelReason;
}

  Details.fromJson(dynamic json) {
    _id = json['id'];
    _batchId = json['batch_id'];
    _moduleId = json['module_id'];
    _facultyId = json['faculty_id'];
    _title = json['title'];
    _brief = json['brief'];
    _date = json['date'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _startTimeT = json['start_time_t'];
    _endTimeT = json['end_time_t'];
    _isActive = json['is_active'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
    _bacthDetails = json['bacth_details'] != null ? BacthDetails.fromJson(json['bacth_details']) : null;
    _moduleDetails = json['module_details'] != null ? ModuleDetails.fromJson(json['module_details']) : null;
    if (json['class_material'] != null) {
      _classMaterial = [];
      json['class_material'].forEach((v) {
        _classMaterial?.add(ClassMaterial.fromJson(v));
      });
    }
    if (json['class_worksheet'] != null) {
      _classWorksheet = [];
      json['class_worksheet'].forEach((v) {
        _classWorksheet?.add(ClassWorksheet.fromJson(v));
      });
    }
    _classNo = json['class_no'];
    _classNoFormat = json['class_no_format'];
    _isModuleComplete = json['is_module_complete'];
    _hasSubmission = json['has_submission'];
    _session1Faculty = json['session1_faculty'];
    _session1Topic = json['session1_topic'];
    _session1LectureType = json['session1_lecture_type'];
    _session1Starttime = json['session1_starttime'];
    _session1Endtime = json['session1_endtime'];
    _session1StarttimeT = json['session1_starttime_t'];
    _session1EndtimeT = json['session1_endtime_t'];
    _session1Prefix = json['session1_prefix'];
    _session1FacultyName = json['session1_faculty_name'];
    _session1LinkedProfile = json['session1_linked_profile'];
    _session1Location = json['session1_location'];
    _session2Faculty = json['session2_faculty'];
    _session2Topic = json['session2_topic'];
    _session2LectureType = json['session2_lecture_type'];
    _session2Starttime = json['session2_starttime'];
    _session2Endtime = json['session2_endtime'];
    _session2StarttimeT = json['session2_starttime_t'];
    _session2EndtimeT = json['session2_endtime_t'];
    _session2Prefix = json['session2_prefix'];
    _session2FacultyName = json['session2_faculty_name'];
    _session2LinkedProfile = json['session2_linked_profile'];
    _allowUploadSubmissions = json['allow_upload_submissions'];
    _isCancelled = json['is_cancelled'];
    _cancelReason = json['cancel_reason'];
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
  String? _startTimeT;
  String? _endTimeT;
  String? _isActive;
  String? _createdAt;
  String? _updatedAt;
  String? _deletedAt;
  BacthDetails? _bacthDetails;
  ModuleDetails? _moduleDetails;
  List<ClassMaterial>? _classMaterial;
  List<ClassWorksheet>? _classWorksheet;
  String? _classNo;
  String? _classNoFormat;
  String? _isModuleComplete;
  String? _hasSubmission;
  String? _session1Faculty;
  String? _session1Topic;
  String? _session1LectureType;
  String? _session1Starttime;
  String? _session1Endtime;
  String? _session1StarttimeT;
  String? _session1EndtimeT;
  String? _session1Prefix;
  String? _session1FacultyName;
  String? _session1LinkedProfile;
  String? _session1Location;
  String? _session2Faculty;
  String? _session2Topic;
  String? _session2LectureType;
  String? _session2Starttime;
  String? _session2Endtime;
  String? _session2StarttimeT;
  String? _session2EndtimeT;
  String? _session2Prefix;
  String? _session2FacultyName;
  String? _session2LinkedProfile;
  String? _allowUploadSubmissions;
  String? _isCancelled;
  String? _cancelReason;
Details copyWith({  String? id,
  String? batchId,
  String? moduleId,
  String? facultyId,
  String? title,
  String? brief,
  String? date,
  String? startTime,
  String? endTime,
  String? startTimeT,
  String? endTimeT,
  String? isActive,
  String? createdAt,
  String? updatedAt,
  String? deletedAt,
  BacthDetails? bacthDetails,
  ModuleDetails? moduleDetails,
  List<ClassMaterial>? classMaterial,
  List<ClassWorksheet>? classWorksheet,
  String? classNo,
  String? classNoFormat,
  String? isModuleComplete,
  String? hasSubmission,
  String? session1Faculty,
  String? session1Topic,
  String? session1LectureType,
  String? session1Starttime,
  String? session1Endtime,
  String? session1StarttimeT,
  String? session1EndtimeT,
  String? session1Prefix,
  String? session1FacultyName,
  String? session1LinkedProfile,
  String? session1Location,
  String? session2Faculty,
  String? session2Topic,
  String? session2LectureType,
  String? session2Starttime,
  String? session2Endtime,
  String? session2StarttimeT,
  String? session2EndtimeT,
  String? session2Prefix,
  String? session2FacultyName,
  String? session2LinkedProfile,
  String? allowUploadSubmissions,
  String? isCancelled,
  String? cancelReason,
}) => Details(  id: id ?? _id,
  batchId: batchId ?? _batchId,
  moduleId: moduleId ?? _moduleId,
  facultyId: facultyId ?? _facultyId,
  title: title ?? _title,
  brief: brief ?? _brief,
  date: date ?? _date,
  startTime: startTime ?? _startTime,
  endTime: endTime ?? _endTime,
  startTimeT: startTimeT ?? _startTimeT,
  endTimeT: endTimeT ?? _endTimeT,
  isActive: isActive ?? _isActive,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
  bacthDetails: bacthDetails ?? _bacthDetails,
  moduleDetails: moduleDetails ?? _moduleDetails,
  classMaterial: classMaterial ?? _classMaterial,
  classWorksheet: classWorksheet ?? _classWorksheet,
  classNo: classNo ?? _classNo,
  classNoFormat: classNoFormat ?? _classNoFormat,
  isModuleComplete: isModuleComplete ?? _isModuleComplete,
  hasSubmission: hasSubmission ?? _hasSubmission,
  session1Faculty: session1Faculty ?? _session1Faculty,
  session1Topic: session1Topic ?? _session1Topic,
  session1LectureType: session1LectureType ?? _session1LectureType,
  session1Starttime: session1Starttime ?? _session1Starttime,
  session1Endtime: session1Endtime ?? _session1Endtime,
  session1StarttimeT: session1StarttimeT ?? _session1StarttimeT,
  session1EndtimeT: session1EndtimeT ?? _session1EndtimeT,
  session1Prefix: session1Prefix ?? _session1Prefix,
  session1FacultyName: session1FacultyName ?? _session1FacultyName,
  session1LinkedProfile: session1LinkedProfile ?? _session1LinkedProfile,
  session1Location: session1Location ?? _session1Location,
  session2Faculty: session2Faculty ?? _session2Faculty,
  session2Topic: session2Topic ?? _session2Topic,
  session2LectureType: session2LectureType ?? _session2LectureType,
  session2Starttime: session2Starttime ?? _session2Starttime,
  session2Endtime: session2Endtime ?? _session2Endtime,
  session2StarttimeT: session2StarttimeT ?? _session2StarttimeT,
  session2EndtimeT: session2EndtimeT ?? _session2EndtimeT,
  session2Prefix: session2Prefix ?? _session2Prefix,
  session2FacultyName: session2FacultyName ?? _session2FacultyName,
  session2LinkedProfile: session2LinkedProfile ?? _session2LinkedProfile,
  allowUploadSubmissions: allowUploadSubmissions ?? _allowUploadSubmissions,
  isCancelled: isCancelled ?? _isCancelled,
  cancelReason: cancelReason ?? _cancelReason,
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
  String? get startTimeT => _startTimeT;
  String? get endTimeT => _endTimeT;
  String? get isActive => _isActive;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get deletedAt => _deletedAt;
  BacthDetails? get bacthDetails => _bacthDetails;
  ModuleDetails? get moduleDetails => _moduleDetails;
  List<ClassMaterial>? get classMaterial => _classMaterial;
  List<ClassWorksheet>? get classWorksheet => _classWorksheet;
  String? get classNo => _classNo;
  String? get classNoFormat => _classNoFormat;
  String? get isModuleComplete => _isModuleComplete;
  String? get hasSubmission => _hasSubmission;
  String? get session1Faculty => _session1Faculty;
  String? get session1Topic => _session1Topic;
  String? get session1LectureType => _session1LectureType;
  String? get session1Starttime => _session1Starttime;
  String? get session1Endtime => _session1Endtime;
  String? get session1StarttimeT => _session1StarttimeT;
  String? get session1EndtimeT => _session1EndtimeT;
  String? get session1Prefix => _session1Prefix;
  String? get session1FacultyName => _session1FacultyName;
  String? get session1LinkedProfile => _session1LinkedProfile;
  String? get session1Location => _session1Location;
  String? get session2Faculty => _session2Faculty;
  String? get session2Topic => _session2Topic;
  String? get session2LectureType => _session2LectureType;
  String? get session2Starttime => _session2Starttime;
  String? get session2Endtime => _session2Endtime;
  String? get session2StarttimeT => _session2StarttimeT;
  String? get session2EndtimeT => _session2EndtimeT;
  String? get session2Prefix => _session2Prefix;
  String? get session2FacultyName => _session2FacultyName;
  String? get session2LinkedProfile => _session2LinkedProfile;
  String? get allowUploadSubmissions => _allowUploadSubmissions;
  String? get isCancelled => _isCancelled;
  String? get cancelReason => _cancelReason;

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
    map['start_time_t'] = _startTimeT;
    map['end_time_t'] = _endTimeT;
    map['is_active'] = _isActive;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    if (_bacthDetails != null) {
      map['bacth_details'] = _bacthDetails?.toJson();
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
    map['is_module_complete'] = _isModuleComplete;
    map['has_submission'] = _hasSubmission;
    map['session1_faculty'] = _session1Faculty;
    map['session1_topic'] = _session1Topic;
    map['session1_lecture_type'] = _session1LectureType;
    map['session1_starttime'] = _session1Starttime;
    map['session1_endtime'] = _session1Endtime;
    map['session1_starttime_t'] = _session1StarttimeT;
    map['session1_endtime_t'] = _session1EndtimeT;
    map['session1_prefix'] = _session1Prefix;
    map['session1_faculty_name'] = _session1FacultyName;
    map['session1_linked_profile'] = _session1LinkedProfile;
    map['session1_location'] = _session1Location;
    map['session2_faculty'] = _session2Faculty;
    map['session2_topic'] = _session2Topic;
    map['session2_lecture_type'] = _session2LectureType;
    map['session2_starttime'] = _session2Starttime;
    map['session2_endtime'] = _session2Endtime;
    map['session2_starttime_t'] = _session2StarttimeT;
    map['session2_endtime_t'] = _session2EndtimeT;
    map['session2_prefix'] = _session2Prefix;
    map['session2_faculty_name'] = _session2FacultyName;
    map['session2_linked_profile'] = _session2LinkedProfile;
    map['is_cancelled'] = _isCancelled;
    map['cancel_reason'] = _cancelReason;
    return map;
  }

}

/// id : "26"
/// class_id : "12"
/// student_id : "96"
/// document_type : "worksheet"
/// file_type : "pdf"
/// file : "1704968339WhatsApp_Image_2023-05-26_at_9.28.52_PM.pdf"
/// caption : ""
/// is_active : "1"
/// created_at : "2024-01-11"
/// updated_at : ""
/// deleted_at : ""
/// full_path : "https://shivalik.institute/api/assets/uploads/class_material/1704968339WhatsApp_Image_2023-05-26_at_9.28.52_PM.pdf"

ClassWorksheet classWorksheetFromJson(String str) => ClassWorksheet.fromJson(json.decode(str));
String classWorksheetToJson(ClassWorksheet data) => json.encode(data.toJson());
class ClassWorksheet {
  ClassWorksheet({
    String? id,
    String? classId,
    String? studentId,
    String? documentType,
    String? fileType,
    String? file,
    String? caption,
    String? isActive,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    String? fullPath,}){
    _id = id;
    _classId = classId;
    _studentId = studentId;
    _documentType = documentType;
    _fileType = fileType;
    _file = file;
    _caption = caption;
    _isActive = isActive;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _fullPath = fullPath;
  }

  ClassWorksheet.fromJson(dynamic json) {
    _id = json['id'];
    _classId = json['class_id'];
    _studentId = json['student_id'];
    _documentType = json['document_type'];
    _fileType = json['file_type'];
    _file = json['file'];
    _caption = json['caption'];
    _isActive = json['is_active'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
    _fullPath = json['full_path'];
  }
  String? _id;
  String? _classId;
  String? _studentId;
  String? _documentType;
  String? _fileType;
  String? _file;
  String? _caption;
  String? _isActive;
  String? _createdAt;
  String? _updatedAt;
  String? _deletedAt;
  String? _fullPath;
  ClassWorksheet copyWith({  String? id,
    String? classId,
    String? studentId,
    String? documentType,
    String? fileType,
    String? file,
    String? caption,
    String? isActive,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    String? fullPath,
  }) => ClassWorksheet(  id: id ?? _id,
    classId: classId ?? _classId,
    studentId: studentId ?? _studentId,
    documentType: documentType ?? _documentType,
    fileType: fileType ?? _fileType,
    file: file ?? _file,
    caption: caption ?? _caption,
    isActive: isActive ?? _isActive,
    createdAt: createdAt ?? _createdAt,
    updatedAt: updatedAt ?? _updatedAt,
    deletedAt: deletedAt ?? _deletedAt,
    fullPath: fullPath ?? _fullPath,
  );
  String? get id => _id;
  String? get classId => _classId;
  String? get studentId => _studentId;
  String? get documentType => _documentType;
  String? get fileType => _fileType;
  String? get file => _file;
  String? get caption => _caption;
  String? get isActive => _isActive;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get deletedAt => _deletedAt;
  String? get fullPath => _fullPath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['class_id'] = _classId;
    map['student_id'] = _studentId;
    map['document_type'] = _documentType;
    map['file_type'] = _fileType;
    map['file'] = _file;
    map['caption'] = _caption;
    map['is_active'] = _isActive;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    map['full_path'] = _fullPath;
    return map;
  }

}

/// id : "21"
/// class_id : "12"
/// student_id : ""
/// document_type : "material"
/// file_type : "png"
/// file : "1704949408images.png"
/// caption : ""
/// is_active : "1"
/// created_at : "2024-01-11"
/// updated_at : ""
/// deleted_at : ""
/// full_path : "https://shivalik.institute/api/assets/uploads/class_material/1704949408images.png"

ClassMaterial classMaterialFromJson(String str) => ClassMaterial.fromJson(json.decode(str));
String classMaterialToJson(ClassMaterial data) => json.encode(data.toJson());
class ClassMaterial {
  ClassMaterial({
      String? id,
      String? classId,
      String? studentId,
      String? documentType,
      String? fileType,
      String? file,
      String? caption,
      String? isActive,
      String? isPrivate,
      String? createdAt,
      String? updatedAt,
      String? deletedAt,
      String? hasSubmission,
      String? allowMaterialAccess,
      String? fullPath,}){
    _id = id;
    _classId = classId;
    _studentId = studentId;
    _documentType = documentType;
    _fileType = fileType;
    _file = file;
    _caption = caption;
    _isActive = isActive;
    _isPrivate = isPrivate;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _hasSubmission = hasSubmission;
    _allowMaterialAccess = allowMaterialAccess;
    _fullPath = fullPath;
}

  ClassMaterial.fromJson(dynamic json) {
    _id = json['id'];
    _classId = json['class_id'];
    _studentId = json['student_id'];
    _documentType = json['document_type'];
    _fileType = json['file_type'];
    _file = json['file'];
    _caption = json['caption'];
    _isActive = json['is_active'];
    _isPrivate = json['is_private'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
    _hasSubmission = json['has_submission'];
    _allowMaterialAccess = json['allow_material_access'];
    _fullPath = json['full_path'];
  }
  String? _id;
  String? _classId;
  String? _studentId;
  String? _documentType;
  String? _fileType;
  String? _file;
  String? _caption;
  String? _isActive;
  String? _isPrivate;
  String? _createdAt;
  String? _updatedAt;
  String? _deletedAt;
  String? _hasSubmission;
  String? _allowMaterialAccess;
  String? _fullPath;
ClassMaterial copyWith({  String? id,
  String? classId,
  String? studentId,
  String? documentType,
  String? fileType,
  String? file,
  String? caption,
  String? isActive,
  String? isPrivate,
  String? createdAt,
  String? updatedAt,
  String? deletedAt,
  String? hasSubmission,
  String? allowMaterialAccess,
  String? fullPath,
}) => ClassMaterial(  id: id ?? _id,
  classId: classId ?? _classId,
  studentId: studentId ?? _studentId,
  documentType: documentType ?? _documentType,
  fileType: fileType ?? _fileType,
  file: file ?? _file,
  caption: caption ?? _caption,
  isActive: isActive ?? _isActive,
  isPrivate: isPrivate ?? _isPrivate,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
  hasSubmission: hasSubmission ?? _hasSubmission,
  allowMaterialAccess: allowMaterialAccess ?? _allowMaterialAccess,
  fullPath: fullPath ?? _fullPath,
);
  String? get id => _id;
  String? get classId => _classId;
  String? get studentId => _studentId;
  String? get documentType => _documentType;
  String? get fileType => _fileType;
  String? get file => _file;
  String? get caption => _caption;
  String? get isActive => _isActive;
  String? get isPrivate => _isPrivate;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get hasSubmission => _hasSubmission;
  String? get deletedAt => _deletedAt;
  String? get allowMaterialAccess => _allowMaterialAccess;
  String? get fullPath => _fullPath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['class_id'] = _classId;
    map['student_id'] = _studentId;
    map['document_type'] = _documentType;
    map['file_type'] = _fileType;
    map['file'] = _file;
    map['caption'] = _caption;
    map['is_active'] = _isActive;
    map['is_private'] = _isPrivate;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    map['has_submission'] = _hasSubmission;
    map['allow_material_access'] = _allowMaterialAccess;
    map['full_path'] = _fullPath;
    return map;
  }

}

/// id : "3"
/// name : "Entrepreneurship in Real Estate"
/// description : "A Guide On All The ‘Know How’s’ Of Real Estate"

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

BacthDetails bacthDetailsFromJson(String str) => BacthDetails.fromJson(json.decode(str));
String bacthDetailsToJson(BacthDetails data) => json.encode(data.toJson());
class BacthDetails {
  BacthDetails({
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

  BacthDetails.fromJson(dynamic json) {
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
BacthDetails copyWith({  String? id,
  String? name,
  String? startDate,
  String? startTime,
  String? endTime,
}) => BacthDetails(  id: id ?? _id,
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