import 'dart:convert';
/// success : "1"
/// message : "List Found"
/// total_records : "3"
/// list : [{"id":"13","class_id":"4","student_id":"96","document_type":"worksheet","file_type":"pdf","file":"1702374610dummy_(1).pdf","caption":"","is_active":"1","created_at":"2023-12-12","updated_at":"","deleted_at":"","full_path":"https://shivalik.institute/api/assets/uploads/class_material/1702374610dummy_(1).pdf","is_pending":"1","class_data":{"class_no":"4","module_id":"2"},"student_data":{"first_name":"Raj","last_name":"Shukla"},"module_data":{"name":"Introduction to Real Estate","description":"Gain a foundational understanding of the dynamic world of real estate\r\nof reforms in the field of Real Estate","duration":"6"}},{"id":"12","class_id":"4","student_id":"96","document_type":"worksheet","file_type":"pdf","file":"1702374492dummy.pdf","caption":"","is_active":"1","created_at":"2023-12-12","updated_at":"","deleted_at":"","full_path":"https://shivalik.institute/api/assets/uploads/class_material/1702374492dummy.pdf","is_pending":"1","class_data":{"class_no":"4","module_id":"2"},"student_data":{"first_name":"Raj","last_name":"Shukla"},"module_data":{"name":"Introduction to Real Estate","description":"Gain a foundational understanding of the dynamic world of real estate\r\nof reforms in the field of Real Estate","duration":"6"}},{"id":"8","class_id":"4","student_id":"96","document_type":"worksheet","file_type":"pdf","file":"1702371037dummy_(1).pdf","caption":"","is_active":"1","created_at":"2023-12-12","updated_at":"","deleted_at":"","full_path":"https://shivalik.institute/api/assets/uploads/class_material/1702371037dummy_(1).pdf","is_pending":"1","class_data":{"class_no":"4","module_id":"2"},"student_data":{"first_name":"Raj","last_name":"Shukla"},"module_data":{"name":"Introduction to Real Estate","description":"Gain a foundational understanding of the dynamic world of real estate\r\nof reforms in the field of Real Estate","duration":"6"}}]

SubmissionNewResponseModel submissionNewResponseModelFromJson(String str) => SubmissionNewResponseModel.fromJson(json.decode(str));
String submissionNewResponseModelToJson(SubmissionNewResponseModel data) => json.encode(data.toJson());
class SubmissionNewResponseModel {
  SubmissionNewResponseModel({
      String? success, 
      String? message, 
      String? totalRecords, 
      List<ListData>? list,}){
    _success = success;
    _message = message;
    _totalRecords = totalRecords;
    _list = list;
}

  SubmissionNewResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _totalRecords = json['total_records'];
    if (json['list'] != null) {
      _list = [];
      json['list'].forEach((v) {
        _list?.add(ListData.fromJson(v));
      });
    }
  }
  String? _success;
  String? _message;
  String? _totalRecords;
  List<ListData>? _list;
SubmissionNewResponseModel copyWith({  String? success,
  String? message,
  String? totalRecords,
  List<ListData>? list,
}) => SubmissionNewResponseModel(  success: success ?? _success,
  message: message ?? _message,
  totalRecords: totalRecords ?? _totalRecords,
  list: list ?? _list,
);
  String? get success => _success;
  String? get message => _message;
  String? get totalRecords => _totalRecords;
  List<ListData>? get list => _list;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    map['total_records'] = _totalRecords;
    if (_list != null) {
      map['list'] = _list?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "13"
/// class_id : "4"
/// student_id : "96"
/// document_type : "worksheet"
/// file_type : "pdf"
/// file : "1702374610dummy_(1).pdf"
/// caption : ""
/// is_active : "1"
/// created_at : "2023-12-12"
/// updated_at : ""
/// deleted_at : ""
/// full_path : "https://shivalik.institute/api/assets/uploads/class_material/1702374610dummy_(1).pdf"
/// is_pending : "1"
/// class_data : {"class_no":"4","module_id":"2"}
/// student_data : {"first_name":"Raj","last_name":"Shukla"}
/// module_data : {"name":"Introduction to Real Estate","description":"Gain a foundational understanding of the dynamic world of real estate\r\nof reforms in the field of Real Estate","duration":"6"}

ListData listFromJson(String str) => ListData.fromJson(json.decode(str));
String listToJson(ListData data) => json.encode(data.toJson());
class ListData {
  ListData({
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
      String? fullPath, 
      String? isPending, 
      String? isPrivate,
      ClassData? classData,
      StudentData? studentData, 
      ModuleData? moduleData,}){
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
    _isPending = isPending;
    _isPrivate = isPrivate;
    _classData = classData;
    _studentData = studentData;
    _moduleData = moduleData;
}

  ListData.fromJson(dynamic json) {
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
    _isPending = json['is_pending'];
    _isPrivate = json['is_private'];
    _classData = json['class_data'] != null ? ClassData.fromJson(json['class_data']) : null;
    _studentData = json['student_data'] != null ? StudentData.fromJson(json['student_data']) : null;
    _moduleData = json['module_data'] != null ? ModuleData.fromJson(json['module_data']) : null;
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
  String? _isPending;
  String? _isPrivate;
  ClassData? _classData;
  StudentData? _studentData;
  ModuleData? _moduleData;
ListData copyWith({  String? id,
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
  String? isPending,
  String? isPrivate,
  ClassData? classData,
  StudentData? studentData,
  ModuleData? moduleData,
}) => ListData(  id: id ?? _id,
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
  isPending: isPending ?? _isPending,
  isPrivate: isPrivate ?? _isPrivate,
  classData: classData ?? _classData,
  studentData: studentData ?? _studentData,
  moduleData: moduleData ?? _moduleData,
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
  String? get isPending => _isPending;
  String? get isPrivate => _isPrivate;
  ClassData? get classData => _classData;
  StudentData? get studentData => _studentData;
  ModuleData? get moduleData => _moduleData;

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
    map['is_pending'] = _isPending;
    map['is_private'] = _isPrivate;
    if (_classData != null) {
      map['class_data'] = _classData?.toJson();
    }
    if (_studentData != null) {
      map['student_data'] = _studentData?.toJson();
    }
    if (_moduleData != null) {
      map['module_data'] = _moduleData?.toJson();
    }
    return map;
  }

}

/// name : "Introduction to Real Estate"
/// description : "Gain a foundational understanding of the dynamic world of real estate\r\nof reforms in the field of Real Estate"
/// duration : "6"

ModuleData moduleDataFromJson(String str) => ModuleData.fromJson(json.decode(str));
String moduleDataToJson(ModuleData data) => json.encode(data.toJson());
class ModuleData {
  ModuleData({
      String? name, 
      String? description, 
      String? duration,}){
    _name = name;
    _description = description;
    _duration = duration;
}

  ModuleData.fromJson(dynamic json) {
    _name = json['name'];
    _description = json['description'];
    _duration = json['duration'];
  }
  String? _name;
  String? _description;
  String? _duration;
ModuleData copyWith({  String? name,
  String? description,
  String? duration,
}) => ModuleData(  name: name ?? _name,
  description: description ?? _description,
  duration: duration ?? _duration,
);
  String? get name => _name;
  String? get description => _description;
  String? get duration => _duration;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['description'] = _description;
    map['duration'] = _duration;
    return map;
  }

}

/// first_name : "Raj"
/// last_name : "Shukla"

StudentData studentDataFromJson(String str) => StudentData.fromJson(json.decode(str));
String studentDataToJson(StudentData data) => json.encode(data.toJson());
class StudentData {
  StudentData({
      String? firstName, 
      String? lastName,}){
    _firstName = firstName;
    _lastName = lastName;
}

  StudentData.fromJson(dynamic json) {
    _firstName = json['first_name'];
    _lastName = json['last_name'];
  }
  String? _firstName;
  String? _lastName;
StudentData copyWith({  String? firstName,
  String? lastName,
}) => StudentData(  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
);
  String? get firstName => _firstName;
  String? get lastName => _lastName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    return map;
  }

}

/// class_no : "4"
/// module_id : "2"

ClassData classDataFromJson(String str) => ClassData.fromJson(json.decode(str));
String classDataToJson(ClassData data) => json.encode(data.toJson());
class ClassData {
  ClassData({
      String? classNo, 
      String? moduleId,}){
    _classNo = classNo;
    _moduleId = moduleId;
}

  ClassData.fromJson(dynamic json) {
    _classNo = json['class_no'];
    _moduleId = json['module_id'];
  }
  String? _classNo;
  String? _moduleId;
ClassData copyWith({  String? classNo,
  String? moduleId,
}) => ClassData(  classNo: classNo ?? _classNo,
  moduleId: moduleId ?? _moduleId,
);
  String? get classNo => _classNo;
  String? get moduleId => _moduleId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['class_no'] = _classNo;
    map['module_id'] = _moduleId;
    return map;
  }

}