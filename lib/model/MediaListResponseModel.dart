import 'dart:convert';
/// success : 1
/// totalRecords : 2
/// mediaList : {"files":[{"id":38,"file_name":"Real_Estate_Intro_IBEF.pdf","caption":"","file_size":"612157","file_type":"application/pdf","is_private":"0","path":"assets/uploads/media/1733209751-jre21--introduction-to-real-estate/","alt_tag":"","media":"https://shivalik.institute/api/assets/uploads/media/1733209751-jre21--introduction-to-real-estate/Real_Estate_Intro_IBEF.pdf","folder_id":258,"save_timestamp":1736409730,"alt_timestamp":"","deleted_at":""},{"id":37,"file_name":"Ahmedabad_Market_report.pdf","caption":"","file_size":"2712949","file_type":"application/pdf","is_private":"0","path":"assets/uploads/media/1733209751-jre21--introduction-to-real-estate/","alt_tag":"","media":"https://shivalik.institute/api/assets/uploads/media/1733209751-jre21--introduction-to-real-estate/Ahmedabad_Market_report.pdf","folder_id":258,"save_timestamp":1736409717,"alt_timestamp":"","deleted_at":""}],"breadcrumbs":[{"folder_id":"258","parent_folder_id":null,"folder_name":"Resource Center"}]}

MediaListResponseModel mediaListResponseModelFromJson(String str) => MediaListResponseModel.fromJson(json.decode(str));
String mediaListResponseModelToJson(MediaListResponseModel data) => json.encode(data.toJson());
class MediaListResponseModel {
  MediaListResponseModel({
      num? success, 
      num? totalRecords, 
      MediaList? mediaList,}){
    _success = success;
    _totalRecords = totalRecords;
    _mediaList = mediaList;
}

  MediaListResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _totalRecords = json['totalRecords'];
    _mediaList = json['mediaList'] != null ? MediaList.fromJson(json['mediaList']) : null;;
  }
  num? _success;
  num? _totalRecords;
  MediaList? _mediaList;
MediaListResponseModel copyWith({  num? success,
  num? totalRecords,
  MediaList? mediaList,
}) => MediaListResponseModel(  success: success ?? _success,
  totalRecords: totalRecords ?? _totalRecords,
  mediaList: mediaList ?? _mediaList,
);
  num? get success => _success;
  num? get totalRecords => _totalRecords;
  MediaList? get mediaList => _mediaList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['totalRecords'] = _totalRecords;
    map['mediaList'] = _mediaList;
    return map;
  }

}

/// files : [{"id":38,"file_name":"Real_Estate_Intro_IBEF.pdf","caption":"","file_size":"612157","file_type":"application/pdf","is_private":"0","path":"assets/uploads/media/1733209751-jre21--introduction-to-real-estate/","alt_tag":"","media":"https://shivalik.institute/api/assets/uploads/media/1733209751-jre21--introduction-to-real-estate/Real_Estate_Intro_IBEF.pdf","folder_id":258,"save_timestamp":1736409730,"alt_timestamp":"","deleted_at":""},{"id":37,"file_name":"Ahmedabad_Market_report.pdf","caption":"","file_size":"2712949","file_type":"application/pdf","is_private":"0","path":"assets/uploads/media/1733209751-jre21--introduction-to-real-estate/","alt_tag":"","media":"https://shivalik.institute/api/assets/uploads/media/1733209751-jre21--introduction-to-real-estate/Ahmedabad_Market_report.pdf","folder_id":258,"save_timestamp":1736409717,"alt_timestamp":"","deleted_at":""}]
/// breadcrumbs : [{"folder_id":"258","parent_folder_id":null,"folder_name":"Resource Center"}]

MediaList mediaListFromJson(String str) => MediaList.fromJson(json.decode(str));
String mediaListToJson(MediaList data) => json.encode(data.toJson());
class MediaList {
  MediaList({
      List<Files>? files, 
      List<Breadcrumbs>? breadcrumbs,}){
    _files = files;
    _breadcrumbs = breadcrumbs;
}

  MediaList.fromJson(dynamic json) {
    if (json['files'] != null) {
      _files = [];
      json['files'].forEach((v) {
        _files?.add(Files.fromJson(v));
      });
    }
    /*if (json['breadcrumbs'] != null) {
      _breadcrumbs = [];
      json['breadcrumbs'].forEach((v) {
        _breadcrumbs?.add(Breadcrumbs.fromJson(v));
      });
    }*/
  }
  List<Files>? _files;
  List<Breadcrumbs>? _breadcrumbs;
MediaList copyWith({  List<Files>? files,
  List<Breadcrumbs>? breadcrumbs,
}) => MediaList(  files: files ?? _files,
  breadcrumbs: breadcrumbs ?? _breadcrumbs,
);
  List<Files>? get files => _files;
  List<Breadcrumbs>? get breadcrumbs => _breadcrumbs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_files != null) {
      map['files'] = _files?.map((v) => v.toJson()).toList();
    }
    if (_breadcrumbs != null) {
      map['breadcrumbs'] = _breadcrumbs?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// folder_id : "258"
/// parent_folder_id : null
/// folder_name : "Resource Center"

Breadcrumbs breadcrumbsFromJson(String str) => Breadcrumbs.fromJson(json.decode(str));
String breadcrumbsToJson(Breadcrumbs data) => json.encode(data.toJson());
class Breadcrumbs {
  Breadcrumbs({
      String? folderId, 
      dynamic parentFolderId, 
      String? folderName,}){
    _folderId = folderId;
    _parentFolderId = parentFolderId;
    _folderName = folderName;
}

  Breadcrumbs.fromJson(dynamic json) {
    _folderId = json['folder_id'];
    _parentFolderId = json['parent_folder_id'];
    _folderName = json['folder_name'];
  }
  String? _folderId;
  dynamic _parentFolderId;
  String? _folderName;
Breadcrumbs copyWith({  String? folderId,
  dynamic parentFolderId,
  String? folderName,
}) => Breadcrumbs(  folderId: folderId ?? _folderId,
  parentFolderId: parentFolderId ?? _parentFolderId,
  folderName: folderName ?? _folderName,
);
  String? get folderId => _folderId;
  dynamic get parentFolderId => _parentFolderId;
  String? get folderName => _folderName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['folder_id'] = _folderId;
    map['parent_folder_id'] = _parentFolderId;
    map['folder_name'] = _folderName;
    return map;
  }

}

/// id : 38
/// file_name : "Real_Estate_Intro_IBEF.pdf"
/// caption : ""
/// file_size : "612157"
/// file_type : "application/pdf"
/// is_private : "0"
/// path : "assets/uploads/media/1733209751-jre21--introduction-to-real-estate/"
/// alt_tag : ""
/// media : "https://shivalik.institute/api/assets/uploads/media/1733209751-jre21--introduction-to-real-estate/Real_Estate_Intro_IBEF.pdf"
/// folder_id : 258
/// save_timestamp : 1736409730
/// alt_timestamp : ""
/// deleted_at : ""

Files filesFromJson(String str) => Files.fromJson(json.decode(str));
String filesToJson(Files data) => json.encode(data.toJson());
class Files {
  Files({
      num? id, 
      String? fileName, 
      String? caption, 
      String? fileSize, 
      String? fileType, 
      String? isPrivate, 
      String? path, 
      String? altTag, 
      String? media, 
      num? folderId, 
      num? saveTimestamp, 
      String? altTimestamp, 
      String? deletedAt,}){
    _id = id;
    _fileName = fileName;
    _caption = caption;
    _fileSize = fileSize;
    _fileType = fileType;
    _isPrivate = isPrivate;
    _path = path;
    _altTag = altTag;
    _media = media;
    _folderId = folderId;
    _saveTimestamp = saveTimestamp;
    _altTimestamp = altTimestamp;
    _deletedAt = deletedAt;
}

  Files.fromJson(dynamic json) {
    _id = json['id'];
    _fileName = json['file_name'];
    _caption = json['caption'];
    _fileSize = json['file_size'];
    _fileType = json['file_type'];
    _isPrivate = json['is_private'];
    _path = json['path'];
    _altTag = json['alt_tag'];
    _media = json['media'];
    _folderId = json['folder_id'];
    _saveTimestamp = json['save_timestamp'];
    _altTimestamp = json['alt_timestamp'];
    _deletedAt = json['deleted_at'];
  }
  num? _id;
  String? _fileName;
  String? _caption;
  String? _fileSize;
  String? _fileType;
  String? _isPrivate;
  String? _path;
  String? _altTag;
  String? _media;
  num? _folderId;
  num? _saveTimestamp;
  String? _altTimestamp;
  String? _deletedAt;
Files copyWith({  num? id,
  String? fileName,
  String? caption,
  String? fileSize,
  String? fileType,
  String? isPrivate,
  String? path,
  String? altTag,
  String? media,
  num? folderId,
  num? saveTimestamp,
  String? altTimestamp,
  String? deletedAt,
}) => Files(  id: id ?? _id,
  fileName: fileName ?? _fileName,
  caption: caption ?? _caption,
  fileSize: fileSize ?? _fileSize,
  fileType: fileType ?? _fileType,
  isPrivate: isPrivate ?? _isPrivate,
  path: path ?? _path,
  altTag: altTag ?? _altTag,
  media: media ?? _media,
  folderId: folderId ?? _folderId,
  saveTimestamp: saveTimestamp ?? _saveTimestamp,
  altTimestamp: altTimestamp ?? _altTimestamp,
  deletedAt: deletedAt ?? _deletedAt,
);
  num? get id => _id;
  String? get fileName => _fileName;
  String? get caption => _caption;
  String? get fileSize => _fileSize;
  String? get fileType => _fileType;
  String? get isPrivate => _isPrivate;
  String? get path => _path;
  String? get altTag => _altTag;
  String? get media => _media;
  num? get folderId => _folderId;
  num? get saveTimestamp => _saveTimestamp;
  String? get altTimestamp => _altTimestamp;
  String? get deletedAt => _deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['file_name'] = _fileName;
    map['caption'] = _caption;
    map['file_size'] = _fileSize;
    map['file_type'] = _fileType;
    map['is_private'] = _isPrivate;
    map['path'] = _path;
    map['alt_tag'] = _altTag;
    map['media'] = _media;
    map['folder_id'] = _folderId;
    map['save_timestamp'] = _saveTimestamp;
    map['alt_timestamp'] = _altTimestamp;
    map['deleted_at'] = _deletedAt;
    return map;
  }

}