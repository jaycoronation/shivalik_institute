import 'dart:convert';
/// success : "1"
/// message : "List Found"
/// total_records : "1"
/// course_list : [{"id":"1","name":"Journey of Real Estate","slug":"journey-of-real-estate","description":"This course covers overall aspect of real estate course aiming to create real estate entrepreneurs. The modules curated in this course cover the real estate project life cycle from acquiring land to calculating project viability till BU and handing over of the project.","duration":"120","site_visit_duration":"6","guest_lecture_duration":"6","fees":"94400","is_active":"1","created_at":"29-09-2023","updated_at":"1698930845","deleted_at":"","overview":"1","start_date_course":"","schedule_dyas":"","brochure":"http://shivalik.institute/api/assets/uploads/journey-of-real-estate-sire-brochure.pdf","experts":[{"id":"76","faculty_type":"core_team","first_name":"Sachin","last_name":"Dharwal","profile_pic":"http://shivalik.institute/api/assets/uploads/profiles/Faculty-24.png","email":"casachindharwal@gmail.com","designation":""},{"id":"81","faculty_type":"core_team","first_name":"Ruchi ","last_name":"Gandhi","profile_pic":"http://shivalik.institute/api/assets/uploads/profiles/Faculty-29.png","email":"ruchi.gandhi@savvygroup.in","designation":""},{"id":"89","faculty_type":"leader","first_name":"Chitrak","last_name":"Shah","profile_pic":"","email":"","designation":"Managing Director"}]}]

CourseResponseModel courseResponseModelFromJson(String str) => CourseResponseModel.fromJson(json.decode(str));
String courseResponseModelToJson(CourseResponseModel data) => json.encode(data.toJson());
class CourseResponseModel {
  CourseResponseModel({
      String? success, 
      String? message, 
      String? totalRecords, 
      List<CourseList>? courseList,}){
    _success = success;
    _message = message;
    _totalRecords = totalRecords;
    _courseList = courseList;
}

  CourseResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _totalRecords = json['total_records'];
    if (json['list'] != null) {
      _courseList = [];
      json['list'].forEach((v) {
        _courseList?.add(CourseList.fromJson(v));
      });
    }
  }
  String? _success;
  String? _message;
  String? _totalRecords;
  List<CourseList>? _courseList;
CourseResponseModel copyWith({  String? success,
  String? message,
  String? totalRecords,
  List<CourseList>? courseList,
}) => CourseResponseModel(  success: success ?? _success,
  message: message ?? _message,
  totalRecords: totalRecords ?? _totalRecords,
  courseList: courseList ?? _courseList,
);
  String? get success => _success;
  String? get message => _message;
  String? get totalRecords => _totalRecords;
  List<CourseList>? get courseList => _courseList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    map['total_records'] = _totalRecords;
    if (_courseList != null) {
      map['list'] = _courseList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// name : "Journey of Real Estate"
/// slug : "journey-of-real-estate"
/// description : "This course covers overall aspect of real estate course aiming to create real estate entrepreneurs. The modules curated in this course cover the real estate project life cycle from acquiring land to calculating project viability till BU and handing over of the project."
/// duration : "120"
/// site_visit_duration : "6"
/// guest_lecture_duration : "6"
/// fees : "94400"
/// is_active : "1"
/// created_at : "29-09-2023"
/// updated_at : "1698930845"
/// deleted_at : ""
/// overview : "1"
/// start_date_course : ""
/// schedule_dyas : ""
/// brochure : "http://shivalik.institute/api/assets/uploads/journey-of-real-estate-sire-brochure.pdf"
/// experts : [{"id":"76","faculty_type":"core_team","first_name":"Sachin","last_name":"Dharwal","profile_pic":"http://shivalik.institute/api/assets/uploads/profiles/Faculty-24.png","email":"casachindharwal@gmail.com","designation":""},{"id":"81","faculty_type":"core_team","first_name":"Ruchi ","last_name":"Gandhi","profile_pic":"http://shivalik.institute/api/assets/uploads/profiles/Faculty-29.png","email":"ruchi.gandhi@savvygroup.in","designation":""},{"id":"89","faculty_type":"leader","first_name":"Chitrak","last_name":"Shah","profile_pic":"","email":"","designation":"Managing Director"}]

CourseList courseListFromJson(String str) => CourseList.fromJson(json.decode(str));
String courseListToJson(CourseList data) => json.encode(data.toJson());
class CourseList {
  CourseList({
      String? id, 
      String? name, 
      String? slug, 
      String? description, 
      String? duration, 
      String? siteVisitDuration, 
      String? guestLectureDuration, 
      String? fees, 
      String? isActive, 
      String? createdAt, 
      String? updatedAt, 
      String? deletedAt, 
      String? overview, 
      String? startDateCourse, 
      String? scheduleDyas, 
      String? brochure, 
      List<Experts>? experts,}){
    _id = id;
    _name = name;
    _slug = slug;
    _description = description;
    _duration = duration;
    _siteVisitDuration = siteVisitDuration;
    _guestLectureDuration = guestLectureDuration;
    _fees = fees;
    _isActive = isActive;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _overview = overview;
    _startDateCourse = startDateCourse;
    _scheduleDyas = scheduleDyas;
    _brochure = brochure;
    _experts = experts;
}

  CourseList.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
    _description = json['description'];
    _duration = json['duration'];
    _siteVisitDuration = json['site_visit_duration'];
    _guestLectureDuration = json['guest_lecture_duration'];
    _fees = json['fees'];
    _isActive = json['is_active'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
    _overview = json['overview'];
    _startDateCourse = json['start_date_course'];
    _scheduleDyas = json['schedule_dyas'];
    _brochure = json['brochure'];
    if (json['experts'] != null) {
      _experts = [];
      json['experts'].forEach((v) {
        _experts?.add(Experts.fromJson(v));
      });
    }
  }
  String? _id;
  String? _name;
  String? _slug;
  String? _description;
  String? _duration;
  String? _siteVisitDuration;
  String? _guestLectureDuration;
  String? _fees;
  String? _isActive;
  String? _createdAt;
  String? _updatedAt;
  String? _deletedAt;
  String? _overview;
  String? _startDateCourse;
  String? _scheduleDyas;
  String? _brochure;
  List<Experts>? _experts;
CourseList copyWith({  String? id,
  String? name,
  String? slug,
  String? description,
  String? duration,
  String? siteVisitDuration,
  String? guestLectureDuration,
  String? fees,
  String? isActive,
  String? createdAt,
  String? updatedAt,
  String? deletedAt,
  String? overview,
  String? startDateCourse,
  String? scheduleDyas,
  String? brochure,
  List<Experts>? experts,
}) => CourseList(  id: id ?? _id,
  name: name ?? _name,
  slug: slug ?? _slug,
  description: description ?? _description,
  duration: duration ?? _duration,
  siteVisitDuration: siteVisitDuration ?? _siteVisitDuration,
  guestLectureDuration: guestLectureDuration ?? _guestLectureDuration,
  fees: fees ?? _fees,
  isActive: isActive ?? _isActive,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
  overview: overview ?? _overview,
  startDateCourse: startDateCourse ?? _startDateCourse,
  scheduleDyas: scheduleDyas ?? _scheduleDyas,
  brochure: brochure ?? _brochure,
  experts: experts ?? _experts,
);
  String? get id => _id;
  String? get name => _name;
  String? get slug => _slug;
  String? get description => _description;
  String? get duration => _duration;
  String? get siteVisitDuration => _siteVisitDuration;
  String? get guestLectureDuration => _guestLectureDuration;
  String? get fees => _fees;
  String? get isActive => _isActive;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get deletedAt => _deletedAt;
  String? get overview => _overview;
  String? get startDateCourse => _startDateCourse;
  String? get scheduleDyas => _scheduleDyas;
  String? get brochure => _brochure;
  List<Experts>? get experts => _experts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['slug'] = _slug;
    map['description'] = _description;
    map['duration'] = _duration;
    map['site_visit_duration'] = _siteVisitDuration;
    map['guest_lecture_duration'] = _guestLectureDuration;
    map['fees'] = _fees;
    map['is_active'] = _isActive;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    map['overview'] = _overview;
    map['start_date_course'] = _startDateCourse;
    map['schedule_dyas'] = _scheduleDyas;
    map['brochure'] = _brochure;
    if (_experts != null) {
      map['experts'] = _experts?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "76"
/// faculty_type : "core_team"
/// first_name : "Sachin"
/// last_name : "Dharwal"
/// profile_pic : "http://shivalik.institute/api/assets/uploads/profiles/Faculty-24.png"
/// email : "casachindharwal@gmail.com"
/// designation : ""

Experts expertsFromJson(String str) => Experts.fromJson(json.decode(str));
String expertsToJson(Experts data) => json.encode(data.toJson());
class Experts {
  Experts({
      String? id, 
      String? facultyType, 
      String? firstName, 
      String? lastName, 
      String? profilePic, 
      String? email, 
      String? designation,}){
    _id = id;
    _facultyType = facultyType;
    _firstName = firstName;
    _lastName = lastName;
    _profilePic = profilePic;
    _email = email;
    _designation = designation;
}

  Experts.fromJson(dynamic json) {
    _id = json['id'];
    _facultyType = json['faculty_type'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _profilePic = json['profile_pic'];
    _email = json['email'];
    _designation = json['designation'];
  }
  String? _id;
  String? _facultyType;
  String? _firstName;
  String? _lastName;
  String? _profilePic;
  String? _email;
  String? _designation;
Experts copyWith({  String? id,
  String? facultyType,
  String? firstName,
  String? lastName,
  String? profilePic,
  String? email,
  String? designation,
}) => Experts(  id: id ?? _id,
  facultyType: facultyType ?? _facultyType,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  profilePic: profilePic ?? _profilePic,
  email: email ?? _email,
  designation: designation ?? _designation,
);
  String? get id => _id;
  String? get facultyType => _facultyType;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get profilePic => _profilePic;
  String? get email => _email;
  String? get designation => _designation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['faculty_type'] = _facultyType;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['profile_pic'] = _profilePic;
    map['email'] = _email;
    map['designation'] = _designation;
    return map;
  }

}