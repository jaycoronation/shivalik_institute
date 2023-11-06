import 'dart:convert';
/// success : "1"
/// message : "List Found"
/// total_records : "1"
/// list : [{"case_id":"2","title":"Shivalik Platinum","description":"A redevelopment project in real estate refers to the process of revitalizing or transforming an existing property or area to enhance its value, functionality, or aesthetics. This value addition involves upgrading or renovating older buildings, repurposing underutilized spaces, or revitalizing dilapidated buildings in urban neighborhoods.","tag_line":"REDEVELOPMENT TO REFORM","notes":"","cover_image":"http://shivalik.institute/api/image-tool/index.php?src=http://shivalik.institute/api/assets/uploads/case_studies/1698991650_pvql5tBO.jpg","published_by":"http://shivalik.institute/api/image-tool/index.php?src=http://shivalik.institute/api/assets/uploads/case_studies/1698991650_1qlAodGu.png","affiliated_with":"http://shivalik.institute/api/image-tool/index.php?src=http://shivalik.institute/api/assets/uploads/case_studies/1699015993_UYKvVVM5.png","brochure":"","is_active":"1","created_at":"02-11-2023","updated_at":"1699015993","deleted_at":""}]

CaseStudyResponseModel caseStudyResponseModelFromJson(String str) => CaseStudyResponseModel.fromJson(json.decode(str));
String caseStudyResponseModelToJson(CaseStudyResponseModel data) => json.encode(data.toJson());
class CaseStudyResponseModel {
  CaseStudyResponseModel({
      String? success, 
      String? message, 
      String? totalRecords, 
      List<CaseStudyList>? list,}){
    _success = success;
    _message = message;
    _totalRecords = totalRecords;
    _list = list;
}

  CaseStudyResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _totalRecords = json['total_records'];
    if (json['list'] != null) {
      _list = [];
      json['list'].forEach((v) {
        _list?.add(CaseStudyList.fromJson(v));
      });
    }
  }
  String? _success;
  String? _message;
  String? _totalRecords;
  List<CaseStudyList>? _list;
CaseStudyResponseModel copyWith({  String? success,
  String? message,
  String? totalRecords,
  List<CaseStudyList>? list,
}) => CaseStudyResponseModel(  success: success ?? _success,
  message: message ?? _message,
  totalRecords: totalRecords ?? _totalRecords,
  list: list ?? _list,
);
  String? get success => _success;
  String? get message => _message;
  String? get totalRecords => _totalRecords;
  List<CaseStudyList>? get list => _list;

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

/// case_id : "2"
/// title : "Shivalik Platinum"
/// description : "A redevelopment project in real estate refers to the process of revitalizing or transforming an existing property or area to enhance its value, functionality, or aesthetics. This value addition involves upgrading or renovating older buildings, repurposing underutilized spaces, or revitalizing dilapidated buildings in urban neighborhoods."
/// tag_line : "REDEVELOPMENT TO REFORM"
/// notes : ""
/// cover_image : "http://shivalik.institute/api/image-tool/index.php?src=http://shivalik.institute/api/assets/uploads/case_studies/1698991650_pvql5tBO.jpg"
/// published_by : "http://shivalik.institute/api/image-tool/index.php?src=http://shivalik.institute/api/assets/uploads/case_studies/1698991650_1qlAodGu.png"
/// affiliated_with : "http://shivalik.institute/api/image-tool/index.php?src=http://shivalik.institute/api/assets/uploads/case_studies/1699015993_UYKvVVM5.png"
/// brochure : ""
/// is_active : "1"
/// created_at : "02-11-2023"
/// updated_at : "1699015993"
/// deleted_at : ""

CaseStudyList listFromJson(String str) => CaseStudyList.fromJson(json.decode(str));
String listToJson(CaseStudyList data) => json.encode(data.toJson());
class CaseStudyList {
  CaseStudyList({
      String? caseId, 
      String? title, 
      String? description, 
      String? tagLine, 
      String? notes, 
      String? coverImage, 
      String? publishedBy, 
      String? affiliatedWith, 
      String? brochure, 
      String? isActive, 
      String? createdAt, 
      String? updatedAt, 
      String? deletedAt,}){
    _caseId = caseId;
    _title = title;
    _description = description;
    _tagLine = tagLine;
    _notes = notes;
    _coverImage = coverImage;
    _publishedBy = publishedBy;
    _affiliatedWith = affiliatedWith;
    _brochure = brochure;
    _isActive = isActive;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
}

  CaseStudyList.fromJson(dynamic json) {
    _caseId = json['case_id'];
    _title = json['title'];
    _description = json['description'];
    _tagLine = json['tag_line'];
    _notes = json['notes'];
    _coverImage = json['cover_image'];
    _publishedBy = json['published_by'];
    _affiliatedWith = json['affiliated_with'];
    _brochure = json['brochure'];
    _isActive = json['is_active'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
  }
  String? _caseId;
  String? _title;
  String? _description;
  String? _tagLine;
  String? _notes;
  String? _coverImage;
  String? _publishedBy;
  String? _affiliatedWith;
  String? _brochure;
  String? _isActive;
  String? _createdAt;
  String? _updatedAt;
  String? _deletedAt;
CaseStudyList copyWith({  String? caseId,
  String? title,
  String? description,
  String? tagLine,
  String? notes,
  String? coverImage,
  String? publishedBy,
  String? affiliatedWith,
  String? brochure,
  String? isActive,
  String? createdAt,
  String? updatedAt,
  String? deletedAt,
}) => CaseStudyList(  caseId: caseId ?? _caseId,
  title: title ?? _title,
  description: description ?? _description,
  tagLine: tagLine ?? _tagLine,
  notes: notes ?? _notes,
  coverImage: coverImage ?? _coverImage,
  publishedBy: publishedBy ?? _publishedBy,
  affiliatedWith: affiliatedWith ?? _affiliatedWith,
  brochure: brochure ?? _brochure,
  isActive: isActive ?? _isActive,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
);
  String? get caseId => _caseId;
  String? get title => _title;
  String? get description => _description;
  String? get tagLine => _tagLine;
  String? get notes => _notes;
  String? get coverImage => _coverImage;
  String? get publishedBy => _publishedBy;
  String? get affiliatedWith => _affiliatedWith;
  String? get brochure => _brochure;
  String? get isActive => _isActive;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get deletedAt => _deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['case_id'] = _caseId;
    map['title'] = _title;
    map['description'] = _description;
    map['tag_line'] = _tagLine;
    map['notes'] = _notes;
    map['cover_image'] = _coverImage;
    map['published_by'] = _publishedBy;
    map['affiliated_with'] = _affiliatedWith;
    map['brochure'] = _brochure;
    map['is_active'] = _isActive;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    return map;
  }

}