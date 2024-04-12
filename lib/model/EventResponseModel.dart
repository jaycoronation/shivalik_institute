import 'dart:convert';
/// success : "1"
/// message : "List Found"
/// total_records : "2"
/// event_list : [{"id":"2","title":"Guest Lecture by Mr Chitrak Shah - Soar High","banner_image":"http://shivalik.institute/api/image-tool/index.php?src=http://shivalik.institute/api/assets/uploads/events/1698312793_gwySaI7M.jpeg","date":"2023-10-28","day":"28","monthyear":"October 2023","description":"Lecture by CS","created_at":"21-10-2023","is_active":"1","event_gallery":[{"event_id":"2","image":"http://shivalik.institute/api/image-tool/index.php?src=http://shivalik.institute/api/assets/uploads/events/1697870301Chitrak-Shah.jpeg","created_at":"21-10-2023"}]},{"id":"1","title":"Guest Lecture by Mr. Pranav Shah","banner_image":"http://shivalik.institute/api/image-tool/index.php?src=http://shivalik.institute/api/assets/uploads/events/1697613260_ldOZaIWX.jpg","date":"2023-10-29","day":"29","monthyear":"October 2023","description":"Mr Pranav Shah, Co-founder and Managing Director of Navratna Group, Ahmedabad has delivered a very interactive and insightful session on 'Journey of a Developer: Challenges and Opportunities' to the participants of SIRE.He took the audience on a virtual journey of each and every project he has delivered with interesting facts and story telling.\r\n\r\nHe conveyed a very important message that every challenge comes with an opportunity to overcome that challenge. He really inspired our participants to take risks, embark on the new path and excel as a developer.\r\n\r\nThe session was graced by Mr Chitrak Shah, founder and MD of Shivalik Group.","created_at":"18-10-2023","is_active":"1","event_gallery":[{"event_id":"1","image":"http://shivalik.institute/api/image-tool/index.php?src=http://shivalik.institute/api/assets/uploads/events/16976132605.webp","created_at":"18-10-2023"},{"event_id":"1","image":"http://shivalik.institute/api/image-tool/index.php?src=http://shivalik.institute/api/assets/uploads/events/16976132606.webp","created_at":"18-10-2023"},{"event_id":"1","image":"http://shivalik.institute/api/image-tool/index.php?src=http://shivalik.institute/api/assets/uploads/events/169761326010.webp","created_at":"18-10-2023"}]}]

EventResponseModel eventResponseModelFromJson(String str) => EventResponseModel.fromJson(json.decode(str));
String eventResponseModelToJson(EventResponseModel data) => json.encode(data.toJson());
class EventResponseModel {
  EventResponseModel({
      String? success, 
      String? message, 
      String? totalRecords, 
      List<EventList>? eventList,}){
    _success = success;
    _message = message;
    _totalRecords = totalRecords;
    _eventList = eventList;
}

  EventResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _totalRecords = json['total_records'];
    if (json['list'] != null) {
      _eventList = [];
      json['list'].forEach((v) {
        _eventList?.add(EventList.fromJson(v));
      });
    }
  }
  String? _success;
  String? _message;
  String? _totalRecords;
  List<EventList>? _eventList;
EventResponseModel copyWith({  String? success,
  String? message,
  String? totalRecords,
  List<EventList>? eventList,
}) => EventResponseModel(  success: success ?? _success,
  message: message ?? _message,
  totalRecords: totalRecords ?? _totalRecords,
  eventList: eventList ?? _eventList,
);
  String? get success => _success;
  String? get message => _message;
  String? get totalRecords => _totalRecords;
  List<EventList>? get eventList => _eventList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    map['total_records'] = _totalRecords;
    if (_eventList != null) {
      map['list'] = _eventList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "2"
/// title : "Guest Lecture by Mr Chitrak Shah - Soar High"
/// banner_image : "http://shivalik.institute/api/image-tool/index.php?src=http://shivalik.institute/api/assets/uploads/events/1698312793_gwySaI7M.jpeg"
/// date : "2023-10-28"
/// day : "28"
/// monthyear : "October 2023"
/// description : "Lecture by CS"
/// created_at : "21-10-2023"
/// is_active : "1"
/// event_gallery : [{"event_id":"2","image":"http://shivalik.institute/api/image-tool/index.php?src=http://shivalik.institute/api/assets/uploads/events/1697870301Chitrak-Shah.jpeg","created_at":"21-10-2023"}]

EventList eventListFromJson(String str) => EventList.fromJson(json.decode(str));
String eventListToJson(EventList data) => json.encode(data.toJson());
class EventList {
  EventList({
      String? id, 
      String? title, 
      String? bannerImage, 
      String? date, 
      String? day, 
      String? monthyear, 
      String? eventType,
      String? description,
      String? shortDescription,
      String? createdAt,
      String? isActive, 
      String? type,
      List<EventGallery>? eventGallery,}){
    _id = id;
    _title = title;
    _bannerImage = bannerImage;
    _date = date;
    _day = day;
    _monthyear = monthyear;
    _eventType = eventType;
    _description = description;
    _shortDescription = shortDescription;
    _createdAt = createdAt;
    _isActive = isActive;
    _type = type;
    _eventGallery = eventGallery;
}

  EventList.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _bannerImage = json['banner_image'];
    _date = json['date'];
    _day = json['day'];
    _monthyear = json['monthyear'];
    _eventType = json['event_type'];
    _description = json['description'];
    _shortDescription = json['short_description'];
    _createdAt = json['created_at'];
    _isActive = json['is_active'];
    _type = json['type'];
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
  String? _day;
  String? _monthyear;
  String? _eventType;
  String? _description;
  String? _shortDescription;
  String? _createdAt;
  String? _type;
  String? _isActive;
  List<EventGallery>? _eventGallery;
EventList copyWith({  String? id,
  String? title,
  String? bannerImage,
  String? date,
  String? day,
  String? monthyear,
  String? eventType,
  String? description,
  String? shortDescription,
  String? createdAt,
  String? isActive,
  String? type,
  List<EventGallery>? eventGallery,
}) => EventList(  id: id ?? _id,
  title: title ?? _title,
  bannerImage: bannerImage ?? _bannerImage,
  date: date ?? _date,
  day: day ?? _day,
  monthyear: monthyear ?? _monthyear,
  eventType: eventType ?? _eventType,
  shortDescription: shortDescription ?? _shortDescription,
  description: description ?? _description,
  createdAt: createdAt ?? _createdAt,
  isActive: isActive ?? _isActive,
  type: type ?? _type,
  eventGallery: eventGallery ?? _eventGallery,
);
  String? get id => _id;
  String? get title => _title;
  String? get bannerImage => _bannerImage;
  String? get date => _date;
  String? get day => _day;
  String? get monthyear => _monthyear;
  String? get eventType => _eventType;
  String? get description => _description;
  String? get shortDescription => _shortDescription;
  String? get createdAt => _createdAt;
  String? get isActive => _isActive;
  String? get type => _type;
  List<EventGallery>? get eventGallery => _eventGallery;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['banner_image'] = _bannerImage;
    map['date'] = _date;
    map['day'] = _day;
    map['monthyear'] = _monthyear;
    map['event_type'] = _eventType;
    map['description'] = _description;
    map['short_description'] = _shortDescription;
    map['created_at'] = _createdAt;
    map['is_active'] = _isActive;
    if (_eventGallery != null) {
      map['event_gallery'] = _eventGallery?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// event_id : "2"
/// image : "http://shivalik.institute/api/image-tool/index.php?src=http://shivalik.institute/api/assets/uploads/events/1697870301Chitrak-Shah.jpeg"
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