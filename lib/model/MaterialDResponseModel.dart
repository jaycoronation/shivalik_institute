import 'dart:convert';
/// success : "1"
/// message : "List Found"
/// total_records : "2"
/// list : [{"id":"22","class_id":"5","student_id":"","document_type":"material","file_type":"png","file":"1699446147ic_md.png","caption":"","is_active":"1","created_at":"2023-11-08","updated_at":"","deleted_at":"","full_path":"http://shivalik.institute/api/assets/uploads/class_material/1699446147ic_md.png","is_pending":"1","class_data":{"class_no":"2","module_id":"2"},"student_data":"","module_data":{"name":"Introduction to Real Estate","description":"Gain a foundational understanding of the dynamic world of real estate\r\nof reforms in the field of Real Estate","duration":"6"}},{"id":"17","class_id":"5","student_id":"","document_type":"material","file_type":"pdf","file":"1699422729dummy.pdf","caption":"","is_active":"1","created_at":"2023-11-08","updated_at":"","deleted_at":"","full_path":"http://shivalik.institute/api/assets/uploads/class_material/1699422729dummy.pdf","is_pending":"1","class_data":{"class_no":"2","module_id":"2"},"student_data":"","module_data":{"name":"Introduction to Real Estate","description":"Gain a foundational understanding of the dynamic world of real estate\r\nof reforms in the field of Real Estate","duration":"6"}}]

MaterialDResponseModel materialDResponseModelFromJson(String str) => MaterialDResponseModel.fromJson(json.decode(str));
String materialDResponseModelToJson(MaterialDResponseModel data) => json.encode(data.toJson());
class MaterialDResponseModel {
  MaterialDResponseModel({
      String? success, 
      String? message, 
      String? totalRecords, 
      List<MaterialDataList>? list,}){
    _success = success;
    _message = message;
    _totalRecords = totalRecords;
    _list = list;
}

  MaterialDResponseModel.fromJson(dynamic json) {
    _success = json['success'].toString();
    _message = json['message'];
    _totalRecords = json['total_records'];
    if (json['list'] != null) {
      _list = [];
      json['list'].forEach((v) {
        _list?.add(MaterialDataList.fromJson(v));
      });
    }
  }
  String? _success;
  String? _message;
  String? _totalRecords;
 List<MaterialDataList>? _list;
MaterialDResponseModel copyWith({  String? success,
  String? message,
  String? totalRecords,
List<MaterialDataList>? list,
}) => MaterialDResponseModel(  success: success ?? _success,
  message: message ?? _message,
  totalRecords: totalRecords ?? _totalRecords,
  list: list ?? _list,
);
  String? get success => _success;
  String? get message => _message;
  String? get totalRecords => _totalRecords;
  List<MaterialDataList>? get list => _list;

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

/// id : "22"
/// class_id : "5"
/// student_id : ""
/// document_type : "material"
/// file_type : "png"
/// file : "1699446147ic_md.png"
/// caption : ""
/// is_active : "1"
/// created_at : "2023-11-08"
/// updated_at : ""
/// deleted_at : ""
/// full_path : "http://shivalik.institute/api/assets/uploads/class_material/1699446147ic_md.png"
/// is_pending : "1"
/// class_data : {"class_no":"2","module_id":"2"}
/// student_data : ""
/// module_data : {"name":"Introduction to Real Estate","description":"Gain a foundational understanding of the dynamic world of real estate\r\nof reforms in the field of Real Estate","duration":"6"}

MaterialDataList listFromJson(String str) => MaterialDataList.fromJson(json.decode(str));
String listToJson(MaterialDataList data) => json.encode(data.toJson());
class MaterialDataList {
  MaterialDataList({
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
      String? studentData, 
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

  MaterialDataList.fromJson(dynamic json) {
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
    _studentData = json['student_data'];
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
  String? _studentData;
  ModuleData? _moduleData;
MaterialDataList copyWith({  String? id,
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
  String? studentData,
  ModuleData? moduleData,
}) => MaterialDataList(  id: id ?? _id,
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
  String? get studentData => _studentData;
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
    map['student_data'] = _studentData;
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

/// class_no : "2"
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