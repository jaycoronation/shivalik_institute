import 'dart:convert';
/// success : "1"
/// message : "List Found"
/// total_records : "1"
/// list : [{"mg_id":"2","user_type":"core_team","prefix_name":"Mr.","first_name":"Jayesh","last_name":"Ladva","email":"jayesh@coronation.in","contact":"9987933004","designation":"Developer","is_active":"1","notes":"notes if you want to add","profile_pic":"http://shivalik.institute/api/image-tool/index.php?src=http://shivalik.institute/api/assets/uploads/1699001896_asljsdi3.png","created_at":"1698941282","updated_at":"1699009509","deleted_at":""}]

ManagementResponseModel managmentResponseModelFromJson(String str) => ManagementResponseModel.fromJson(json.decode(str));
String managmentResponseModelToJson(ManagementResponseModel data) => json.encode(data.toJson());
class ManagementResponseModel {
  ManagementResponseModel({
      String? success, 
      String? message, 
      String? totalRecords, 
      List<ManagementList>? list,}){
    _success = success;
    _message = message;
    _totalRecords = totalRecords;
    _list = list;
}

  ManagementResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _totalRecords = json['total_records'];
    if (json['list'] != null) {
      _list = [];
      json['list'].forEach((v) {
        _list?.add(ManagementList.fromJson(v));
      });
    }
  }
  String? _success;
  String? _message;
  String? _totalRecords;
  List<ManagementList>? _list;
ManagementResponseModel copyWith({  String? success,
  String? message,
  String? totalRecords,
  List<ManagementList>? list,
}) => ManagementResponseModel(  success: success ?? _success,
  message: message ?? _message,
  totalRecords: totalRecords ?? _totalRecords,
  list: list ?? _list,
);
  String? get success => _success;
  String? get message => _message;
  String? get totalRecords => _totalRecords;
  List<ManagementList>? get list => _list;

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

/// mg_id : "2"
/// user_type : "core_team"
/// prefix_name : "Mr."
/// first_name : "Jayesh"
/// last_name : "Ladva"
/// email : "jayesh@coronation.in"
/// contact : "9987933004"
/// designation : "Developer"
/// is_active : "1"
/// notes : "notes if you want to add"
/// profile_pic : "http://shivalik.institute/api/image-tool/index.php?src=http://shivalik.institute/api/assets/uploads/1699001896_asljsdi3.png"
/// created_at : "1698941282"
/// updated_at : "1699009509"
/// deleted_at : ""

ManagementList listFromJson(String str) => ManagementList.fromJson(json.decode(str));
String listToJson(ManagementList data) => json.encode(data.toJson());
class ManagementList {
  ManagementList({
      String? mgId, 
      String? userType, 
      String? prefixName, 
      String? firstName, 
      String? lastName, 
      String? email, 
      String? contact, 
      String? designation, 
      String? isActive, 
      String? notes, 
      String? profilePic, 
      String? createdAt, 
      String? updatedAt, 
      String? deletedAt,}){
    _mgId = mgId;
    _userType = userType;
    _prefixName = prefixName;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _contact = contact;
    _designation = designation;
    _isActive = isActive;
    _notes = notes;
    _profilePic = profilePic;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
}

  ManagementList.fromJson(dynamic json) {
    _mgId = json['mg_id'];
    _userType = json['user_type'];
    _prefixName = json['prefix_name'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _contact = json['contact'];
    _designation = json['designation'];
    _isActive = json['is_active'];
    _notes = json['notes'];
    _profilePic = json['profile_pic'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
  }
  String? _mgId;
  String? _userType;
  String? _prefixName;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _contact;
  String? _designation;
  String? _isActive;
  String? _notes;
  String? _profilePic;
  String? _createdAt;
  String? _updatedAt;
  String? _deletedAt;
ManagementList copyWith({  String? mgId,
  String? userType,
  String? prefixName,
  String? firstName,
  String? lastName,
  String? email,
  String? contact,
  String? designation,
  String? isActive,
  String? notes,
  String? profilePic,
  String? createdAt,
  String? updatedAt,
  String? deletedAt,
}) => ManagementList(  mgId: mgId ?? _mgId,
  userType: userType ?? _userType,
  prefixName: prefixName ?? _prefixName,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  email: email ?? _email,
  contact: contact ?? _contact,
  designation: designation ?? _designation,
  isActive: isActive ?? _isActive,
  notes: notes ?? _notes,
  profilePic: profilePic ?? _profilePic,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
);
  String? get mgId => _mgId;
  String? get userType => _userType;
  String? get prefixName => _prefixName;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get contact => _contact;
  String? get designation => _designation;
  String? get isActive => _isActive;
  String? get notes => _notes;
  String? get profilePic => _profilePic;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get deletedAt => _deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mg_id'] = _mgId;
    map['user_type'] = _userType;
    map['prefix_name'] = _prefixName;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['contact'] = _contact;
    map['designation'] = _designation;
    map['is_active'] = _isActive;
    map['notes'] = _notes;
    map['profile_pic'] = _profilePic;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    return map;
  }

}