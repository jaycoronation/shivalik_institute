import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
/// id : "4"
/// name : "JRE11"
/// batch_size : "30"
/// start_date : "12-01-2024"
/// end_date : "23-03-2024"
/// start_time : "06:00 PM"
/// end_time : "09:00 PM"
/// is_active : "1"
/// created_at : "29-09-2023"
/// updated_at : "1709121404"
/// timezone : "Evening"
/// batch_status : "ongoing"
/// batch_priority : 1
/// registration_close_date : "12-01-2024"
/// batch_month_year : "2024-01"
/// student_enrolled : "30"
/// formated_date_time : "12th Jan 2024 (06:00 PM to 09:00 PM)"
/// last_message : {"content":"Test","senderId":"12","sender_name":"Jay Mistry","timestamp":21341254,"type":"12"}
/// message_count : 1

ConversationSchema conversationSchemaFromJson(String str) => ConversationSchema.fromJson(json.decode(str));
String conversationSchemaToJson(ConversationSchema data) => json.encode(data.toJson());
class ConversationSchema {
  ConversationSchema({
      String? id,
      String? name,
      String? batchSize,
      String? startDate,
      String? endDate,
      String? startTime,
      String? endTime,
      String? isActive,
      String? createdAt,
      String? updatedAt,
      String? timezone,
      String? batchStatus,
      num? batchPriority,
      String? registrationCloseDate,
      String? batchMonthYear,
      String? studentEnrolled,
      String? formatedDateTime,
      LastMessage? lastMessage,
      num? messageCount,}){
    _id = id;
    _name = name;
    _batchSize = batchSize;
    _startDate = startDate;
    _endDate = endDate;
    _startTime = startTime;
    _endTime = endTime;
    _isActive = isActive;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _timezone = timezone;
    _batchStatus = batchStatus;
    _batchPriority = batchPriority;
    _registrationCloseDate = registrationCloseDate;
    _batchMonthYear = batchMonthYear;
    _studentEnrolled = studentEnrolled;
    _formatedDateTime = formatedDateTime;
    _lastMessage = lastMessage;
    _messageCount = messageCount;
}

  ConversationSchema.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _batchSize = json['batch_size'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _isActive = json['is_active'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _timezone = json['timezone'];
    _batchStatus = json['batch_status'];
    _batchPriority = json['batch_priority'];
    _registrationCloseDate = json['registration_close_date'];
    _batchMonthYear = json['batch_month_year'];
    _studentEnrolled = json['student_enrolled'];
    _formatedDateTime = json['formated_date_time'];
    _lastMessage = json['last_message'] != null ? LastMessage.fromJson(json['last_message']) : null;
    _messageCount = json['message_count'];
  }
  String? _id;
  String? _name;
  String? _batchSize;
  String? _startDate;
  String? _endDate;
  String? _startTime;
  String? _endTime;
  String? _isActive;
  String? _createdAt;
  String? _updatedAt;
  String? _timezone;
  String? _batchStatus;
  num? _batchPriority;
  String? _registrationCloseDate;
  String? _batchMonthYear;
  String? _studentEnrolled;
  String? _formatedDateTime;
  LastMessage? _lastMessage;
  num? _messageCount;
ConversationSchema copyWith({  String? id,
  String? name,
  String? batchSize,
  String? startDate,
  String? endDate,
  String? startTime,
  String? endTime,
  String? isActive,
  String? createdAt,
  String? updatedAt,
  String? timezone,
  String? batchStatus,
  num? batchPriority,
  String? registrationCloseDate,
  String? batchMonthYear,
  String? studentEnrolled,
  String? formatedDateTime,
  LastMessage? lastMessage,
  num? messageCount,
}) => ConversationSchema(  id: id ?? _id,
  name: name ?? _name,
  batchSize: batchSize ?? _batchSize,
  startDate: startDate ?? _startDate,
  endDate: endDate ?? _endDate,
  startTime: startTime ?? _startTime,
  endTime: endTime ?? _endTime,
  isActive: isActive ?? _isActive,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  timezone: timezone ?? _timezone,
  batchStatus: batchStatus ?? _batchStatus,
  batchPriority: batchPriority ?? _batchPriority,
  registrationCloseDate: registrationCloseDate ?? _registrationCloseDate,
  batchMonthYear: batchMonthYear ?? _batchMonthYear,
  studentEnrolled: studentEnrolled ?? _studentEnrolled,
  formatedDateTime: formatedDateTime ?? _formatedDateTime,
  lastMessage: lastMessage ?? _lastMessage,
  messageCount: messageCount ?? _messageCount,
);
  String? get id => _id;
  String? get name => _name;
  String? get batchSize => _batchSize;
  String? get startDate => _startDate;
  String? get endDate => _endDate;
  String? get startTime => _startTime;
  String? get endTime => _endTime;
  String? get isActive => _isActive;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get timezone => _timezone;
  String? get batchStatus => _batchStatus;
  num? get batchPriority => _batchPriority;
  String? get registrationCloseDate => _registrationCloseDate;
  String? get batchMonthYear => _batchMonthYear;
  String? get studentEnrolled => _studentEnrolled;
  String? get formatedDateTime => _formatedDateTime;
  LastMessage? get lastMessage => _lastMessage;
  num? get messageCount => _messageCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['batch_size'] = _batchSize;
    map['start_date'] = _startDate;
    map['end_date'] = _endDate;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['is_active'] = _isActive;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['timezone'] = _timezone;
    map['batch_status'] = _batchStatus;
    map['batch_priority'] = _batchPriority;
    map['registration_close_date'] = _registrationCloseDate;
    map['batch_month_year'] = _batchMonthYear;
    map['student_enrolled'] = _studentEnrolled;
    map['formated_date_time'] = _formatedDateTime;
    if (_lastMessage != null) {
      map['last_message'] = _lastMessage?.toJson();
    }
    map['message_count'] = _messageCount;
    return map;
  }

}

/// content : "Test"
/// senderId : "12"
/// sender_name : "Jay Mistry"
/// timestamp : 21341254
/// type : "12"

LastMessage lastMessageFromJson(String str) => LastMessage.fromJson(json.decode(str));
String lastMessageToJson(LastMessage data) => json.encode(data.toJson());
class LastMessage {
  LastMessage({
      String? content,
      String? senderId,
      String? senderName,
    Timestamp? timestamp,
      String? type,}){
    _content = content;
    _senderId = senderId;
    _senderName = senderName;
    _timestamp = timestamp;
    _type = type;
}

  LastMessage.fromJson(dynamic json) {
    _content = json['content'];
    _senderId = json['senderId'];
    _senderName = json['sender_name'];
    _timestamp = json['timestamp'];
    _type = json['type'];
  }
  String? _content;
  String? _senderId;
  String? _senderName;
  Timestamp? _timestamp;
  String? _type;
LastMessage copyWith({  String? content,
  String? senderId,
  String? senderName,
  Timestamp? timestamp,
  String? type,
}) => LastMessage(  content: content ?? _content,
  senderId: senderId ?? _senderId,
  senderName: senderName ?? _senderName,
  timestamp: timestamp ?? _timestamp,
  type: type ?? _type,
);
  String? get content => _content;
  String? get senderId => _senderId;
  String? get senderName => _senderName;
  Timestamp? get timestamp => _timestamp;
  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['content'] = _content;
    map['senderId'] = _senderId;
    map['sender_name'] = _senderName;
    map['timestamp'] = _timestamp;
    map['type'] = _type;
    return map;
  }

}