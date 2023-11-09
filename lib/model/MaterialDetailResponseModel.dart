import 'dart:convert';
/// success : "1"
/// message : "List"
/// data : [{"id":"7","first_name":"Priya","last_name":"Gohil","documets":[{"id":"18","class_id":"5","student_id":"7","document_type":"worksheet","file_type":"png","file":"16994358951698750350837.png","caption":"","is_active":"1","created_at":"2023-11-08","updated_at":"","deleted_at":"","full_path":"http://shivalik.institute/api/assets/uploads/class_material/","is_pending":"1","student_data":{"first_name":"Priya","last_name":"Gohil"}}],"is_submitted":"yes","module_data":{"name":"Introduction to Real Estate","description":"Gain a foundational understanding of the dynamic world of real estate\r\nof reforms in the field of Real Estate","duration":"6"}},{"id":"10","first_name":"Vasant","last_name":"Saraswat","documets":[],"is_submitted":"no","module_data":{"name":"Introduction to Real Estate","description":"Gain a foundational understanding of the dynamic world of real estate\r\nof reforms in the field of Real Estate","duration":"6"}},{"id":"96","first_name":"Raj","last_name":"Shukla","documets":[],"is_submitted":"no","module_data":{"name":"Introduction to Real Estate","description":"Gain a foundational understanding of the dynamic world of real estate\r\nof reforms in the field of Real Estate","duration":"6"}},{"id":"97","first_name":"Jay ","last_name":"Mistry","documets":[],"is_submitted":"no","module_data":{"name":"Introduction to Real Estate","description":"Gain a foundational understanding of the dynamic world of real estate\r\nof reforms in the field of Real Estate","duration":"6"}}]

MaterialDetailResponseModel materialDetailResponseModelFromJson(String str) => MaterialDetailResponseModel.fromJson(json.decode(str));
String materialDetailResponseModelToJson(MaterialDetailResponseModel data) => json.encode(data.toJson());
class MaterialDetailResponseModel {
  MaterialDetailResponseModel({
      String? success, 
      String? message, 
      List<MaterialData>? data,}){
    _success = success;
    _message = message;
    _data = data;
}

  MaterialDetailResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    if (json['list'] != null) {
      _data = [];
      json['list'].forEach((v) {
        _data?.add(MaterialData.fromJson(v));
      });
    }
  }
  String? _success;
  String? _message;
  List<MaterialData>? _data;
MaterialDetailResponseModel copyWith({  String? success,
  String? message,
  List<MaterialData>? data,
}) => MaterialDetailResponseModel(  success: success ?? _success,
  message: message ?? _message,
  data: data ?? _data,
);
  String? get success => _success;
  String? get message => _message;
  List<MaterialData>? get data => _data;

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

/// id : "7"
/// first_name : "Priya"
/// last_name : "Gohil"
/// documets : [{"id":"18","class_id":"5","student_id":"7","document_type":"worksheet","file_type":"png","file":"16994358951698750350837.png","caption":"","is_active":"1","created_at":"2023-11-08","updated_at":"","deleted_at":"","full_path":"http://shivalik.institute/api/assets/uploads/class_material/","is_pending":"1","student_data":{"first_name":"Priya","last_name":"Gohil"}}]
/// is_submitted : "yes"
/// module_data : {"name":"Introduction to Real Estate","description":"Gain a foundational understanding of the dynamic world of real estate\r\nof reforms in the field of Real Estate","duration":"6"}

MaterialData dataFromJson(String str) => MaterialData.fromJson(json.decode(str));
String dataToJson(MaterialData data) => json.encode(data.toJson());
class MaterialData {
  MaterialData({
      String? id, 
      String? firstName, 
      String? lastName, 
      List<Documets>? documets, 
      String? isSubmitted, 
      ModuleData? moduleData,}){
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _documets = documets;
    _isSubmitted = isSubmitted;
    _moduleData = moduleData;
}

  MaterialData.fromJson(dynamic json) {
    _id = json['id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    if (json['documets'] != null) {
      _documets = [];
      json['documets'].forEach((v) {
        _documets?.add(Documets.fromJson(v));
      });
    }
    _isSubmitted = json['is_submitted'];
    _moduleData = json['module_data'] != null ? ModuleData.fromJson(json['module_data']) : null;
  }
  String? _id;
  String? _firstName;
  String? _lastName;
  List<Documets>? _documets;
  String? _isSubmitted;
  ModuleData? _moduleData;
MaterialData copyWith({  String? id,
  String? firstName,
  String? lastName,
  List<Documets>? documets,
  String? isSubmitted,
  ModuleData? moduleData,
}) => MaterialData(  id: id ?? _id,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  documets: documets ?? _documets,
  isSubmitted: isSubmitted ?? _isSubmitted,
  moduleData: moduleData ?? _moduleData,
);
  String? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  List<Documets>? get documets => _documets;
  String? get isSubmitted => _isSubmitted;
  ModuleData? get moduleData => _moduleData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    if (_documets != null) {
      map['documets'] = _documets?.map((v) => v.toJson()).toList();
    }
    map['is_submitted'] = _isSubmitted;
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

/// id : "18"
/// class_id : "5"
/// student_id : "7"
/// document_type : "worksheet"
/// file_type : "png"
/// file : "16994358951698750350837.png"
/// caption : ""
/// is_active : "1"
/// created_at : "2023-11-08"
/// updated_at : ""
/// deleted_at : ""
/// full_path : "http://shivalik.institute/api/assets/uploads/class_material/"
/// is_pending : "1"
/// student_data : {"first_name":"Priya","last_name":"Gohil"}

Documets documetsFromJson(String str) => Documets.fromJson(json.decode(str));
String documetsToJson(Documets data) => json.encode(data.toJson());
class Documets {
  Documets({
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
      StudentData? studentData,}){
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
    _studentData = studentData;
}

  Documets.fromJson(dynamic json) {
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
    _studentData = json['student_data'] != null ? StudentData.fromJson(json['student_data']) : null;
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
  StudentData? _studentData;
Documets copyWith({  String? id,
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
  StudentData? studentData,
}) => Documets(  id: id ?? _id,
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
  studentData: studentData ?? _studentData,
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
  StudentData? get studentData => _studentData;

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
    if (_studentData != null) {
      map['student_data'] = _studentData?.toJson();
    }
    return map;
  }

}

/// first_name : "Priya"
/// last_name : "Gohil"

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