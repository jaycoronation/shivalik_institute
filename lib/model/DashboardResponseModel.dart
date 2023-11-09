import 'dart:convert';
/// success : "1"
/// message : ""
/// total_events : "2"
/// total_classes : "2"
/// total_modules : "11"
/// completed_module : "1"
/// pending_module : "10"
/// upcoming_classes : []
/// upcoming_events : [{"id":"2","title":"Guest Lecture by Mr Chitrak Shah - Soar High","banner_image":"http://shivalik.institute/api/assets/uploads/events/1698312793_gwySaI7M.jpeg","date":"28-10-2023 12:00 AM","date_timestamp":"1698431400","description":"Lecture by CS","created_at":"21-10-2023","event_gallery":[{"event_id":"2","image":"http://shivalik.institute/api/assets/uploads/events/1697870301Chitrak-Shah.jpeg","created_at":"21-10-2023"}]},{"id":"1","title":"Guest Lecture by Mr. Pranav Shah","banner_image":"http://shivalik.institute/api/assets/uploads/events/1697613260_ldOZaIWX.jpg","date":"29-10-2023 12:00 AM","date_timestamp":"1698517800","description":"Mr Pranav Shah, Co-founder and Managing Director of Navratna Group, Ahmedabad has delivered a very interactive and insightful session on 'Journey of a Developer: Challenges and Opportunities' to the participants of SIRE.He took the audience on a virtual journey of each and every project he has delivered with interesting facts and story telling.\r\n\r\nHe conveyed a very important message that every challenge comes with an opportunity to overcome that challenge. He really inspired our participants to take risks, embark on the new path and excel as a developer.\r\n\r\nThe session was graced by Mr Chitrak Shah, founder and MD of Shivalik Group.","created_at":"18-10-2023","event_gallery":[{"event_id":"1","image":"http://shivalik.institute/api/assets/uploads/events/16976132605.webp","created_at":"18-10-2023"},{"event_id":"1","image":"http://shivalik.institute/api/assets/uploads/events/16976132606.webp","created_at":"18-10-2023"},{"event_id":"1","image":"http://shivalik.institute/api/assets/uploads/events/169761326010.webp","created_at":"18-10-2023"}]}]
/// total_holidays : "2"
/// holidays_list : [{"id":"4","title":"Christmas","description":"Christmas Description","holiday_date":"25-12-2023","status":"1","created_at":"1698304935","updated_at":"1698305130","deleted_at":""},{"id":"3","title":"Diwali","description":"Festival of Lights","holiday_date":"12-11-2023","status":"1","created_at":"1698304510","updated_at":"1698305119","deleted_at":""}]
/// fees : {"payment_mode_cash_amount":"Array","payment_mode_cheque_amount":"Array","payment_mode_netbanking_amount":"0","total_fees":"94400","pending_fees":"0","paid_fees":"0"}

DashboardResponseModel dashboardResponseModelFromJson(String str) => DashboardResponseModel.fromJson(json.decode(str));
String dashboardResponseModelToJson(DashboardResponseModel data) => json.encode(data.toJson());
class DashboardResponseModel {
  DashboardResponseModel({
      String? success, 
      String? message, 
      String? totalEvents, 
      String? totalClasses, 
      String? totalModules, 
      String? completedModule, 
      String? pendingModule, 
      List<UpcomingClasses>? upcomingClasses,
      List<UpcomingEvents>? upcomingEvents, 
      String? totalHolidays, 
      List<HolidaysList>? holidaysList, 
      Fees? fees,}){
    _success = success;
    _message = message;
    _totalEvents = totalEvents;
    _totalClasses = totalClasses;
    _totalModules = totalModules;
    _completedModule = completedModule;
    _pendingModule = pendingModule;
    _upcomingClasses = upcomingClasses;
    _upcomingEvents = upcomingEvents;
    _totalHolidays = totalHolidays;
    _holidaysList = holidaysList;
    _fees = fees;
}

  DashboardResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _totalEvents = json['total_events'];
    _totalClasses = json['total_classes'];
    _totalModules = json['total_modules'];
    _completedModule = json['completed_module'];
    _pendingModule = json['pending_module'];
    if (json['upcoming_classes'] != null) {
      _upcomingClasses = [];
      json['upcoming_classes'].forEach((v) {
         _upcomingClasses?.add(UpcomingClasses.fromJson(v));
      });
    }
    if (json['upcoming_events'] != null) {
      _upcomingEvents = [];
      json['upcoming_events'].forEach((v) {
        _upcomingEvents?.add(UpcomingEvents.fromJson(v));
      });
    }
    _totalHolidays = json['total_holidays'];
    if (json['holidays_list'] != null) {
      _holidaysList = [];
      json['holidays_list'].forEach((v) {
        _holidaysList?.add(HolidaysList.fromJson(v));
      });
    }
    _fees = json['fees'] != null ? Fees.fromJson(json['fees']) : null;
  }
  String? _success;
  String? _message;
  String? _totalEvents;
  String? _totalClasses;
  String? _totalModules;
  String? _completedModule;
  String? _pendingModule;
  List<UpcomingClasses>? _upcomingClasses;
  List<UpcomingEvents>? _upcomingEvents;
  String? _totalHolidays;
  List<HolidaysList>? _holidaysList;
  Fees? _fees;
DashboardResponseModel copyWith({  String? success,
  String? message,
  String? totalEvents,
  String? totalClasses,
  String? totalModules,
  String? completedModule,
  String? pendingModule,
  List<UpcomingClasses>? upcomingClasses,
  List<UpcomingEvents>? upcomingEvents,
  String? totalHolidays,
  List<HolidaysList>? holidaysList,
  Fees? fees,
}) => DashboardResponseModel(  success: success ?? _success,
  message: message ?? _message,
  totalEvents: totalEvents ?? _totalEvents,
  totalClasses: totalClasses ?? _totalClasses,
  totalModules: totalModules ?? _totalModules,
  completedModule: completedModule ?? _completedModule,
  pendingModule: pendingModule ?? _pendingModule,
  upcomingClasses: upcomingClasses ?? _upcomingClasses,
  upcomingEvents: upcomingEvents ?? _upcomingEvents,
  totalHolidays: totalHolidays ?? _totalHolidays,
  holidaysList: holidaysList ?? _holidaysList,
  fees: fees ?? _fees,
);
  String? get success => _success;
  String? get message => _message;
  String? get totalEvents => _totalEvents;
  String? get totalClasses => _totalClasses;
  String? get totalModules => _totalModules;
  String? get completedModule => _completedModule;
  String? get pendingModule => _pendingModule;
  List<UpcomingClasses>? get upcomingClasses => _upcomingClasses;
  List<UpcomingEvents>? get upcomingEvents => _upcomingEvents;
  String? get totalHolidays => _totalHolidays;
  List<HolidaysList>? get holidaysList => _holidaysList;
  Fees? get fees => _fees;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    map['total_events'] = _totalEvents;
    map['total_classes'] = _totalClasses;
    map['total_modules'] = _totalModules;
    map['completed_module'] = _completedModule;
    map['pending_module'] = _pendingModule;
    if (_upcomingClasses != null) {
      map['upcoming_classes'] = _upcomingClasses?.map((v) => v.toJson()).toList();
    }
    if (_upcomingEvents != null) {
      map['upcoming_events'] = _upcomingEvents?.map((v) => v.toJson()).toList();
    }
    map['total_holidays'] = _totalHolidays;
    if (_holidaysList != null) {
      map['holidays_list'] = _holidaysList?.map((v) => v.toJson()).toList();
    }
    if (_fees != null) {
      map['fees'] = _fees?.toJson();
    }
    return map;
  }

}

/// id : "5"
/// batch_id : "4"
/// module_id : "2"
/// faculty_id : ""
/// title : ""
/// brief : ""
/// date : "16-01-2024"
/// date_timestamp : "1705343400"
/// start_time : "06:00 PM"
/// end_time : "09:00 PM"
/// is_active : "1"
/// created_at : "08-11-2023"
/// updated_at : ""
/// deleted_at : ""
/// is_draft : ""
/// is_module_complete : "1"
/// module_details : {"id":"2","name":"Introduction to Real Estate","description":"Gain a foundational understanding of the dynamic world of real estate\r\nof reforms in the field of Real Estate"}
/// session1_faculty : "80"
/// session1_topic : "Introduction"
/// session1_lecture_type : "Normal"
/// session1_starttime : ""
/// session1_endtime : ""
/// session1_prefix : "Mrs"
/// session1_faculty_name : "Avani  Sikka"
/// session1_linked_profile : ""
/// session2_faculty : "69"
/// session2_topic : "Appication Building"
/// session2_lecture_type : "Normal"
/// session2_starttime : ""
/// session2_endtime : ""
/// session2_prefix : "Mr"
/// session2_faculty_name : "Monil  Parikh"
/// session2_linked_profile : ""
/// class_no : "2"
/// class_no_format : "JRE11-class2"
/// batch_details : {"id":"4","name":"JRE11","start_date":"1705343400","start_time":"1705408200","end_time":"1705419000"}
/// class_material : [{"id":"17","class_id":"5","student_id":"","document_type":"material","file_type":"pdf","file":"1699422729dummy.pdf","caption":"","is_active":"1","created_at":"2023-11-08","updated_at":"","deleted_at":"","full_path":"http://shivalik.institute/api/assets/uploads/class_material/1699422729dummy.pdf"}]
/// class_worksheet : []

UpcomingClasses upcomingClassesFromJson(String str) => UpcomingClasses.fromJson(json.decode(str));
String upcomingClassesToJson(UpcomingClasses data) => json.encode(data.toJson());
class UpcomingClasses {
  UpcomingClasses({
    String? id,
    String? batchId,
    String? moduleId,
    String? facultyId,
    String? title,
    String? brief,
    String? date,
    String? dateTimestamp,
    String? startTime,
    String? endTime,
    String? isActive,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    String? isDraft,
    String? isModuleComplete,
    ModuleDetails? moduleDetails,
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
    String? classNo,
    String? classNoFormat,
    BatchDetails? batchDetails,
    List<ClassMaterial>? classMaterial,
    List<dynamic>? classWorksheet,}){
    _id = id;
    _batchId = batchId;
    _moduleId = moduleId;
    _facultyId = facultyId;
    _title = title;
    _brief = brief;
    _date = date;
    _dateTimestamp = dateTimestamp;
    _startTime = startTime;
    _endTime = endTime;
    _isActive = isActive;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _isDraft = isDraft;
    _isModuleComplete = isModuleComplete;
    _moduleDetails = moduleDetails;
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
    _classNo = classNo;
    _classNoFormat = classNoFormat;
    _batchDetails = batchDetails;
    _classMaterial = classMaterial;
    _classWorksheet = classWorksheet;
  }

  UpcomingClasses.fromJson(dynamic json) {
    _id = json['id'];
    _batchId = json['batch_id'];
    _moduleId = json['module_id'];
    _facultyId = json['faculty_id'];
    _title = json['title'];
    _brief = json['brief'];
    _date = json['date'];
    _dateTimestamp = json['date_timestamp'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _isActive = json['is_active'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
    _isDraft = json['is_draft'];
    _isModuleComplete = json['is_module_complete'];
    _moduleDetails = json['module_details'] != null ? ModuleDetails.fromJson(json['module_details']) : null;
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
    _classNo = json['class_no'];
    _classNoFormat = json['class_no_format'];
    _batchDetails = json['batch_details'] != null ? BatchDetails.fromJson(json['batch_details']) : null;
    if (json['class_material'] != null) {
      _classMaterial = [];
      json['class_material'].forEach((v) {
        _classMaterial?.add(ClassMaterial.fromJson(v));
      });
    }
    if (json['class_worksheet'] != null) {
      _classWorksheet = [];
      json['class_worksheet'].forEach((v) {
        // _classWorksheet?.add(Dynamic.fromJson(v));
      });
    }
  }
  String? _id;
  String? _batchId;
  String? _moduleId;
  String? _facultyId;
  String? _title;
  String? _brief;
  String? _date;
  String? _dateTimestamp;
  String? _startTime;
  String? _endTime;
  String? _isActive;
  String? _createdAt;
  String? _updatedAt;
  String? _deletedAt;
  String? _isDraft;
  String? _isModuleComplete;
  ModuleDetails? _moduleDetails;
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
  String? _classNo;
  String? _classNoFormat;
  BatchDetails? _batchDetails;
  List<ClassMaterial>? _classMaterial;
  List<dynamic>? _classWorksheet;
  UpcomingClasses copyWith({  String? id,
    String? batchId,
    String? moduleId,
    String? facultyId,
    String? title,
    String? brief,
    String? date,
    String? dateTimestamp,
    String? startTime,
    String? endTime,
    String? isActive,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    String? isDraft,
    String? isModuleComplete,
    ModuleDetails? moduleDetails,
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
    String? classNo,
    String? classNoFormat,
    BatchDetails? batchDetails,
    List<ClassMaterial>? classMaterial,
    List<dynamic>? classWorksheet,
  }) => UpcomingClasses(  id: id ?? _id,
    batchId: batchId ?? _batchId,
    moduleId: moduleId ?? _moduleId,
    facultyId: facultyId ?? _facultyId,
    title: title ?? _title,
    brief: brief ?? _brief,
    date: date ?? _date,
    dateTimestamp: dateTimestamp ?? _dateTimestamp,
    startTime: startTime ?? _startTime,
    endTime: endTime ?? _endTime,
    isActive: isActive ?? _isActive,
    createdAt: createdAt ?? _createdAt,
    updatedAt: updatedAt ?? _updatedAt,
    deletedAt: deletedAt ?? _deletedAt,
    isDraft: isDraft ?? _isDraft,
    isModuleComplete: isModuleComplete ?? _isModuleComplete,
    moduleDetails: moduleDetails ?? _moduleDetails,
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
    classNo: classNo ?? _classNo,
    classNoFormat: classNoFormat ?? _classNoFormat,
    batchDetails: batchDetails ?? _batchDetails,
    classMaterial: classMaterial ?? _classMaterial,
    classWorksheet: classWorksheet ?? _classWorksheet,
  );
  String? get id => _id;
  String? get batchId => _batchId;
  String? get moduleId => _moduleId;
  String? get facultyId => _facultyId;
  String? get title => _title;
  String? get brief => _brief;
  String? get date => _date;
  String? get dateTimestamp => _dateTimestamp;
  String? get startTime => _startTime;
  String? get endTime => _endTime;
  String? get isActive => _isActive;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get deletedAt => _deletedAt;
  String? get isDraft => _isDraft;
  String? get isModuleComplete => _isModuleComplete;
  ModuleDetails? get moduleDetails => _moduleDetails;
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
  String? get classNo => _classNo;
  String? get classNoFormat => _classNoFormat;
  BatchDetails? get batchDetails => _batchDetails;
  List<ClassMaterial>? get classMaterial => _classMaterial;
  List<dynamic>? get classWorksheet => _classWorksheet;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['batch_id'] = _batchId;
    map['module_id'] = _moduleId;
    map['faculty_id'] = _facultyId;
    map['title'] = _title;
    map['brief'] = _brief;
    map['date'] = _date;
    map['date_timestamp'] = _dateTimestamp;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['is_active'] = _isActive;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    map['is_draft'] = _isDraft;
    map['is_module_complete'] = _isModuleComplete;
    if (_moduleDetails != null) {
      map['module_details'] = _moduleDetails?.toJson();
    }
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
    map['class_no'] = _classNo;
    map['class_no_format'] = _classNoFormat;
    if (_batchDetails != null) {
      map['batch_details'] = _batchDetails?.toJson();
    }
    if (_classMaterial != null) {
      map['class_material'] = _classMaterial?.map((v) => v.toJson()).toList();
    }
    if (_classWorksheet != null) {
      map['class_worksheet'] = _classWorksheet?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// payment_mode_cash_amount : "Array"
/// payment_mode_cheque_amount : "Array"
/// payment_mode_netbanking_amount : "0"
/// total_fees : "94400"
/// pending_fees : "0"
/// paid_fees : "0"


/// id : "17"
/// class_id : "5"
/// student_id : ""
/// document_type : "material"
/// file_type : "pdf"
/// file : "1699422729dummy.pdf"
/// caption : ""
/// is_active : "1"
/// created_at : "2023-11-08"
/// updated_at : ""
/// deleted_at : ""
/// full_path : "http://shivalik.institute/api/assets/uploads/class_material/1699422729dummy.pdf"

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

  ClassMaterial.fromJson(dynamic json) {
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
  ClassMaterial copyWith({  String? id,
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
  }) => ClassMaterial(  id: id ?? _id,
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

/// id : "4"
/// name : "JRE11"
/// start_date : "1705343400"
/// start_time : "1705408200"
/// end_time : "1705419000"

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

Fees feesFromJson(String str) => Fees.fromJson(json.decode(str));
String feesToJson(Fees data) => json.encode(data.toJson());
class Fees {
  Fees({
      String? paymentModeCashAmount, 
      String? paymentModeChequeAmount, 
      String? paymentModeNetbankingAmount, 
      String? totalFees, 
      String? pendingFees, 
      String? paidFees,}){
    _paymentModeCashAmount = paymentModeCashAmount;
    _paymentModeChequeAmount = paymentModeChequeAmount;
    _paymentModeNetbankingAmount = paymentModeNetbankingAmount;
    _totalFees = totalFees;
    _pendingFees = pendingFees;
    _paidFees = paidFees;
}

  Fees.fromJson(dynamic json) {
    _paymentModeCashAmount = json['payment_mode_cash_amount'];
    _paymentModeChequeAmount = json['payment_mode_cheque_amount'];
    _paymentModeNetbankingAmount = json['payment_mode_netbanking_amount'];
    _totalFees = json['total_fees'];
    _pendingFees = json['pending_fees'];
    _paidFees = json['paid_fees'];
  }
  String? _paymentModeCashAmount;
  String? _paymentModeChequeAmount;
  String? _paymentModeNetbankingAmount;
  String? _totalFees;
  String? _pendingFees;
  String? _paidFees;
Fees copyWith({  String? paymentModeCashAmount,
  String? paymentModeChequeAmount,
  String? paymentModeNetbankingAmount,
  String? totalFees,
  String? pendingFees,
  String? paidFees,
}) => Fees(  paymentModeCashAmount: paymentModeCashAmount ?? _paymentModeCashAmount,
  paymentModeChequeAmount: paymentModeChequeAmount ?? _paymentModeChequeAmount,
  paymentModeNetbankingAmount: paymentModeNetbankingAmount ?? _paymentModeNetbankingAmount,
  totalFees: totalFees ?? _totalFees,
  pendingFees: pendingFees ?? _pendingFees,
  paidFees: paidFees ?? _paidFees,
);
  String? get paymentModeCashAmount => _paymentModeCashAmount;
  String? get paymentModeChequeAmount => _paymentModeChequeAmount;
  String? get paymentModeNetbankingAmount => _paymentModeNetbankingAmount;
  String? get totalFees => _totalFees;
  String? get pendingFees => _pendingFees;
  String? get paidFees => _paidFees;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['payment_mode_cash_amount'] = _paymentModeCashAmount;
    map['payment_mode_cheque_amount'] = _paymentModeChequeAmount;
    map['payment_mode_netbanking_amount'] = _paymentModeNetbankingAmount;
    map['total_fees'] = _totalFees;
    map['pending_fees'] = _pendingFees;
    map['paid_fees'] = _paidFees;
    return map;
  }

}

/// id : "4"
/// title : "Christmas"
/// description : "Christmas Description"
/// holiday_date : "25-12-2023"
/// status : "1"
/// created_at : "1698304935"
/// updated_at : "1698305130"
/// deleted_at : ""

HolidaysList holidaysListFromJson(String str) => HolidaysList.fromJson(json.decode(str));
String holidaysListToJson(HolidaysList data) => json.encode(data.toJson());
class HolidaysList {
  HolidaysList({
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

  HolidaysList.fromJson(dynamic json) {
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
HolidaysList copyWith({  String? id,
  String? title,
  String? description,
  String? holidayDate,
  String? status,
  String? createdAt,
  String? updatedAt,
  String? deletedAt,
}) => HolidaysList(  id: id ?? _id,
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

/// id : "2"
/// title : "Guest Lecture by Mr Chitrak Shah - Soar High"
/// banner_image : "http://shivalik.institute/api/assets/uploads/events/1698312793_gwySaI7M.jpeg"
/// date : "28-10-2023 12:00 AM"
/// date_timestamp : "1698431400"
/// description : "Lecture by CS"
/// created_at : "21-10-2023"
/// event_gallery : [{"event_id":"2","image":"http://shivalik.institute/api/assets/uploads/events/1697870301Chitrak-Shah.jpeg","created_at":"21-10-2023"}]

UpcomingEvents upcomingEventsFromJson(String str) => UpcomingEvents.fromJson(json.decode(str));
String upcomingEventsToJson(UpcomingEvents data) => json.encode(data.toJson());
class UpcomingEvents {
  UpcomingEvents({
      String? id, 
      String? title, 
      String? bannerImage, 
      String? date, 
      String? dateTimestamp, 
      String? description, 
      String? createdAt, 
      List<EventGallery>? eventGallery,}){
    _id = id;
    _title = title;
    _bannerImage = bannerImage;
    _date = date;
    _dateTimestamp = dateTimestamp;
    _description = description;
    _createdAt = createdAt;
    _eventGallery = eventGallery;
}

  UpcomingEvents.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _bannerImage = json['banner_image'];
    _date = json['date'];
    _dateTimestamp = json['date_timestamp'];
    _description = json['description'];
    _createdAt = json['created_at'];
    if (json['event_gallery'] != null) {
      _eventGallery = [];
      json['event_gallery'].forEach((v) {
        _eventGallery?.add(EventGallery.fromJson(v));
      });
    }
  }
  String? _id;
  String? _title;
  String? _bannerImage;
  String? _date;
  String? _dateTimestamp;
  String? _description;
  String? _createdAt;
  List<EventGallery>? _eventGallery;
UpcomingEvents copyWith({  String? id,
  String? title,
  String? bannerImage,
  String? date,
  String? dateTimestamp,
  String? description,
  String? createdAt,
  List<EventGallery>? eventGallery,
}) => UpcomingEvents(  id: id ?? _id,
  title: title ?? _title,
  bannerImage: bannerImage ?? _bannerImage,
  date: date ?? _date,
  dateTimestamp: dateTimestamp ?? _dateTimestamp,
  description: description ?? _description,
  createdAt: createdAt ?? _createdAt,
  eventGallery: eventGallery ?? _eventGallery,
);
  String? get id => _id;
  String? get title => _title;
  String? get bannerImage => _bannerImage;
  String? get date => _date;
  String? get dateTimestamp => _dateTimestamp;
  String? get description => _description;
  String? get createdAt => _createdAt;
  List<EventGallery>? get eventGallery => _eventGallery;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['banner_image'] = _bannerImage;
    map['date'] = _date;
    map['date_timestamp'] = _dateTimestamp;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    if (_eventGallery != null) {
      map['event_gallery'] = _eventGallery?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// event_id : "2"
/// image : "http://shivalik.institute/api/assets/uploads/events/1697870301Chitrak-Shah.jpeg"
/// created_at : "21-10-2023"

EventGallery eventGalleryFromJson(String str) => EventGallery.fromJson(json.decode(str));
String eventGalleryToJson(EventGallery data) => json.encode(data.toJson());
class EventGallery {
  EventGallery({
      String? eventId, 
      String? image, 
      String? createdAt,}){
    _eventId = eventId;
    _image = image;
    _createdAt = createdAt;
}

  EventGallery.fromJson(dynamic json) {
    _eventId = json['event_id'];
    _image = json['image'];
    _createdAt = json['created_at'];
  }
  String? _eventId;
  String? _image;
  String? _createdAt;
EventGallery copyWith({  String? eventId,
  String? image,
  String? createdAt,
}) => EventGallery(  eventId: eventId ?? _eventId,
  image: image ?? _image,
  createdAt: createdAt ?? _createdAt,
);
  String? get eventId => _eventId;
  String? get image => _image;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['event_id'] = _eventId;
    map['image'] = _image;
    map['created_at'] = _createdAt;
    return map;
  }

}