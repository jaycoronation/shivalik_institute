import 'dart:convert';
/// success : 1
/// message : "27 records found."
/// notifications : [{"id":"36","user_id":"96","class_id":"","batch_id":"","event_id":"","operation":"pedning_fees_reminder","message":"Please ensure timely payment of your outstanding fees to avoid any inconvenience. Take action now to stay updated with your financial commitments. Thank you! 💳💸","title":"📢 Attention Students: Friendly reminder about pending fees","created_at":"1704801081","time":"Today at 05:21 PM","is_read":0},{"id":"35","user_id":"96","class_id":"6","batch_id":"1","event_id":"","operation":"submission_reminder","message":"Friendly reminder to submit your worksheet for 'Land and Revenue ' module. Your hard work matters! Complete and submit your work to ensure you don't miss the deadline. Good luck! 📚✍️","title":"📢 Submission Reminder!","created_at":"1704800502","time":"Today at 05:11 PM","is_read":0},{"id":"33","user_id":"96","class_id":"6","batch_id":"1","event_id":"","operation":"submission_reminder","message":"Friendly reminder to submit your worksheet for 'Land and Revenue ' module. Your hard work matters! Complete and submit your work to ensure you don't miss the deadline. Good luck! 📚✍️","title":"📢 Submission Reminder!","created_at":"1704800498","time":"Today at 05:11 PM","is_read":0},{"id":"31","user_id":"","class_id":"7","batch_id":"1","event_id":"","operation":"lecture_reminder","message":"Join us for our upcoming session on 'Entrepreneurship in Real Estate' by Mr Jeet Shah and Mr Rajiv  Dave happening on 06:00 PM. Get ready to engage, learn, and discover new insights! Mark your calendar and be part of this enriching experience! 📚✨","title":"📢 Don't Miss Out! An exciting lecture awaits you!","created_at":"1704800275","time":"Today at 05:07 PM","is_read":0},{"id":"30","user_id":"","class_id":"7","batch_id":"1","event_id":"","operation":"lecture_complete","message":"Don't miss out on reinforcing your learning. The lecture materials are now available for review. Dive back in, solidify your understanding, and make the most of this valuable resource! 📖💡","title":"📚 Lecture Complete!","created_at":"1704800109","time":"Today at 05:05 PM","is_read":0},{"id":"29","user_id":"","class_id":"10","batch_id":"1","event_id":"","operation":"lecture_complete","message":"You have a lecture on 'Land Planning and Development ' by Mr. Sumedha MahajanDon't miss out on reinforcing your learning. The lecture materials are now available for review. Dive back in, solidify your understanding, and make the most of this valuable resource! 📖💡","title":"📚 Lecture Complete!","created_at":"1704800012","time":"Today at 05:03 PM","is_read":0},{"id":"28","user_id":"","class_id":"9","batch_id":"1","event_id":"","operation":"lecture_complete","message":"You have a lecture on 'Land Planning and Development ' by Mr. Viraj ShahDon't miss out on reinforcing your learning. The lecture materials are now available for review. Dive back in, solidify your understanding, and make the most of this valuable resource! 📖💡","title":"📚 Lecture Complete!","created_at":"1704800010","time":"Today at 05:03 PM","is_read":0},{"id":"27","user_id":"","class_id":"8","batch_id":"1","event_id":"","operation":"lecture_complete","message":"You have a lecture on 'Land and Revenue ' by Mr. Chitrak ShahDon't miss out on reinforcing your learning. The lecture materials are now available for review. Dive back in, solidify your understanding, and make the most of this valuable resource! 📖💡","title":"📚 Lecture Complete!","created_at":"1704800009","time":"Today at 05:03 PM","is_read":0},{"id":"26","user_id":"","class_id":"7","batch_id":"1","event_id":"","operation":"lecture_complete","message":"You have a lecture on 'Entrepreneurship in Real Estate' by Mr Jeet Shah and Mr Rajiv  DaveDon't miss out on reinforcing your learning. The lecture materials are now available for review. Dive back in, solidify your understanding, and make the most of this valuable resource! 📖💡","title":"📚 Lecture Complete!","created_at":"1704800008","time":"Today at 05:03 PM","is_read":0},{"id":"25","user_id":"","class_id":"4","batch_id":"1","event_id":"","operation":"lecture_complete","message":"You have a lecture on 'Introduction to Real Estate' by Mrs Avani  Sikka and Mr Monil  ParikhDon't miss out on reinforcing your learning. The lecture materials are now available for review. Dive back in, solidify your understanding, and make the most of this valuable resource! 📖💡","title":"📚 Lecture Complete!","created_at":"1704800007","time":"Today at 05:03 PM","is_read":0},{"id":"24","user_id":"","class_id":"","batch_id":"","event_id":"10","operation":"event_scheduled","message":"Join us on 10th Jun for an enriching experience focused on Masterclass by Mr. Yash Brahmbhatt. Save the date and be part of an insightful session filled with learning and networking opportunities! 📅🌟","title":"📢 A new Briefing Event has been scheduled!","created_at":"1704799503","time":"Today at 04:55 PM","is_read":0},{"id":"23","user_id":"","class_id":"10","batch_id":"1","event_id":"","operation":"lecture_scheduled","message":"Join us on 13th Jan at 09:00 PM for an engaging session on Land Planning and Development . Don't miss out! See you there! 📚","title":"📢 A new Master Class has been scheduled!","created_at":"1704798678","time":"Today at 04:41 PM","is_read":0},{"id":"22","user_id":"","class_id":"6","batch_id":"1","event_id":"","operation":"material_uploaded","message":"New materials have just been uploaded to our platform. Dive into the latest resources covering Appication Building, Appication Building from Land and Revenue . Expand your knowledge and stay ahead with our newest additions! 📚💡","title":"🚀 Great news!","created_at":"1704798198","time":"Today at 04:33 PM","is_read":0},{"id":"21","user_id":"","class_id":"10","batch_id":"1","event_id":"","operation":"lecture_scheduled","message":"Join us on 13th Jan at 09:00 PM for an engaging session on Land Planning and Development . Don't miss out! See you there! ????","title":"???? A new Master Class has been scheduled!","created_at":"1704797349","time":"Today at 04:19 PM","is_read":0},{"id":"20","user_id":"","class_id":"10","batch_id":"1","event_id":"","operation":"lecture_scheduled","message":"Join us on 13th Jan at 09:00 PM for an engaging session on Land Planning and Development . Don't miss out! See you there! ????","title":"???? A new Master Class has been scheduled!","created_at":"1704797288","time":"Today at 04:18 PM","is_read":0},{"id":"19","user_id":"","class_id":"10","batch_id":"1","event_id":"","operation":"lecture_scheduled","message":"Join us on 13th Jan at 09:00 PM for an engaging session on Land Planning and Development . Don't miss out! See you there! ????","title":"???? A new Master Class has been scheduled!","created_at":"1704797059","time":"Today at 04:14 PM","is_read":0},{"id":"18","user_id":"","class_id":"9","batch_id":"1","event_id":"","operation":"lecture_scheduled","message":"Join us on 12th Jan at 09:00 PM for an engaging session on Land Planning and Development . Don't miss out! See you there! 📚","title":"📢 A new Site Visit has been scheduled!","created_at":"1704796834","time":"Today at 04:10 PM","is_read":0},{"id":"17","user_id":"","class_id":"8","batch_id":"1","event_id":"","operation":"lecture_scheduled","message":"Join us on 10th Jan at 09:00 PM for an engaging session on Land and Revenue . Don't miss out! See you there! 📚","title":"📢 A new Guest lecture has been scheduled!","created_at":"1704796734","time":"Today at 04:08 PM","is_read":0},{"id":"12","user_id":"96","class_id":"6","batch_id":"1","event_id":"","operation":"submission_reminder","message":"Submit your worksheets for 'Land and Revenue ' module","title":"","created_at":"1704781991","time":"Today at 12:03 PM","is_read":0},{"id":"13","user_id":"96","class_id":"7","batch_id":"1","event_id":"","operation":"submission_reminder","message":"Submit your worksheets for 'Entrepreneurship in Real Estate' module","title":"","created_at":"1704781991","time":"Today at 12:03 PM","is_read":0},{"id":"11","user_id":"96","class_id":"6","batch_id":"1","event_id":"","operation":"submission_reminder","message":"Submit your worksheets for 'Land and Revenue ' module","title":"","created_at":"1704781909","time":"Today at 12:01 PM","is_read":0},{"id":"10","user_id":"96","class_id":"6","batch_id":"1","event_id":"","operation":"submission_reminder","message":"Submit your worksheets for 'Land and Revenue ' module","title":"","created_at":"1704781874","time":"Today at 12:01 PM","is_read":0},{"id":"5","user_id":"96","class_id":"6","batch_id":"1","event_id":"","operation":"submission_reminder","message":"Submit your worksheets for 'Land and Revenue ' module","title":"","created_at":"1704781809","time":"Today at 12:00 PM","is_read":0},{"id":"6","user_id":"96","class_id":"7","batch_id":"1","event_id":"","operation":"submission_reminder","message":"Submit your worksheets for 'Entrepreneurship in Real Estate' module","title":"","created_at":"1704781809","time":"Today at 12:00 PM","is_read":0},{"id":"4","user_id":"96","class_id":"6","batch_id":"1","event_id":"","operation":"submission_reminder","message":"Submit your worksheets for 'Land and Revenue ' module","title":"","created_at":"1704781734","time":"Today at 11:58 AM","is_read":0},{"id":"3","user_id":"96","class_id":"","batch_id":"1","event_id":"","operation":"submission_reminder","message":"Submit your worksheets for 'Land and Revenue ' module","title":"","created_at":"1704781627","time":"Today at 11:57 AM","is_read":0},{"id":"2","user_id":"","class_id":"7","batch_id":"1","event_id":"","operation":"lecture_reminder","message":"You have a lecture on '' by Mr Jeet Shah and Mr Rajiv  Dave at 06:00 PM - 09:00 PM","title":"","created_at":"1704778807","time":"Today at 11:10 AM","is_read":0}]
/// total_records : "27"

NotificationListResponseModel notificationListResponseModelFromJson(String str) => NotificationListResponseModel.fromJson(json.decode(str));
String notificationListResponseModelToJson(NotificationListResponseModel data) => json.encode(data.toJson());
class NotificationListResponseModel {
  NotificationListResponseModel({
      num? success, 
      String? message, 
      List<Notifications>? notifications, 
      String? totalRecords,}){
    _success = success;
    _message = message;
    _notifications = notifications;
    _totalRecords = totalRecords;
}

  NotificationListResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    if (json['notifications'] != null) {
      _notifications = [];
      json['notifications'].forEach((v) {
        _notifications?.add(Notifications.fromJson(v));
      });
    }
    _totalRecords = json['total_records'];
  }
  num? _success;
  String? _message;
  List<Notifications>? _notifications;
  String? _totalRecords;
NotificationListResponseModel copyWith({  num? success,
  String? message,
  List<Notifications>? notifications,
  String? totalRecords,
}) => NotificationListResponseModel(  success: success ?? _success,
  message: message ?? _message,
  notifications: notifications ?? _notifications,
  totalRecords: totalRecords ?? _totalRecords,
);
  num? get success => _success;
  String? get message => _message;
  List<Notifications>? get notifications => _notifications;
  String? get totalRecords => _totalRecords;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_notifications != null) {
      map['notifications'] = _notifications?.map((v) => v.toJson()).toList();
    }
    map['total_records'] = _totalRecords;
    return map;
  }

}

/// id : "36"
/// user_id : "96"
/// class_id : ""
/// batch_id : ""
/// event_id : ""
/// operation : "pedning_fees_reminder"
/// message : "Please ensure timely payment of your outstanding fees to avoid any inconvenience. Take action now to stay updated with your financial commitments. Thank you! 💳💸"
/// title : "📢 Attention Students: Friendly reminder about pending fees"
/// created_at : "1704801081"
/// time : "Today at 05:21 PM"
/// is_read : 0

Notifications notificationsFromJson(String str) => Notifications.fromJson(json.decode(str));
String notificationsToJson(Notifications data) => json.encode(data.toJson());
class Notifications {
  Notifications({
      String? id, 
      String? userId, 
      String? classId, 
      String? batchId, 
      String? eventId, 
      String? operation, 
      String? message, 
      String? title, 
      String? createdAt, 
      String? time, 
      String? task_id ,
      num? isRead,
  }){
    _id = id;
    _userId = userId;
    _classId = classId;
    _batchId = batchId;
    _eventId = eventId;
    _operation = operation;
    _message = message;
    _title = title;
    _createdAt = createdAt;
    _time = time;
    _task_id  = task_id;
    _isRead = isRead;
}

  Notifications.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _classId = json['class_id'];
    _batchId = json['batch_id'];
    _eventId = json['event_id'];
    _operation = json['operation'];
    _message = json['message'];
    _title = json['title'];
    _createdAt = json['created_at'];
    _time = json['time'];
    _task_id  = json['task_id'];
    _isRead = json['is_read'];
  }
  String? _id;
  String? _userId;
  String? _classId;
  String? _batchId;
  String? _eventId;
  String? _operation;
  String? _message;
  String? _title;
  String? _createdAt;
  String? _time;
  String? _task_id;
  num? _isRead;
Notifications copyWith({  String? id,
  String? userId,
  String? classId,
  String? batchId,
  String? eventId,
  String? operation,
  String? message,
  String? title,
  String? createdAt,
  String? time,
  String? task_id ,
  num? isRead,
}) => Notifications(  id: id ?? _id,
  userId: userId ?? _userId,
  classId: classId ?? _classId,
  batchId: batchId ?? _batchId,
  eventId: eventId ?? _eventId,
  operation: operation ?? _operation,
  message: message ?? _message,
  title: title ?? _title,
  createdAt: createdAt ?? _createdAt,
  time: time ?? _time,
  task_id : task_id  ?? _task_id,
  isRead: isRead ?? _isRead,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get classId => _classId;
  String? get batchId => _batchId;
  String? get eventId => _eventId;
  String? get operation => _operation;
  String? get message => _message;
  String? get title => _title;
  String? get createdAt => _createdAt;
  String? get time => _time;
  String? get task_id  => _task_id;
  num? get isRead => _isRead;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['class_id'] = _classId;
    map['batch_id'] = _batchId;
    map['event_id'] = _eventId;
    map['operation'] = _operation;
    map['message'] = _message;
    map['title'] = _title;
    map['created_at'] = _createdAt;
    map['time'] = _time;
    map['task_id '] = _task_id;
    map['is_read'] = _isRead;
    return map;
  }

}