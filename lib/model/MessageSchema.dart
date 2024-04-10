import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shivalik_institute/model/ReactionModel.dart';
import 'package:video_player/video_player.dart';
/// sender : "Jay Mistry"
/// sender_id : "96"
/// content : "Hi this is jay mistry"
/// type : "text"
/// timestamp : 123143253

//MessageSchema messageSchemaFromJson(String str) => MessageSchema.fromJson(json.decode(str));
String messageSchemaToJson(MessageSchema data) => json.encode(data.toJson());
class MessageSchema {
  MessageSchema({
      String? sender, 
      String? senderId, 
      String? content, 
      String? type, 
      String? fileName,
      String? documentId,
      String? passedDateFormate,
      bool? isEdited,
      bool? isDelete,
      List<dynamic>? reactions,
      Timestamp? timestamp,}){
    _sender = sender;
    _senderId = senderId;
    _content = content;
    _type = type;
    _fileName = fileName;
    _documentId = documentId;
    _passedDateFormate = passedDateFormate;
    _isEdited = isEdited;
    _isDelete = isDelete;
    _reactions = reactions;
    _timestamp = timestamp;
}

  /*MessageSchema.fromJson(dynamic json) {
    _sender = json['sender'];
    _senderId = json['sender_id'];
    _content = json['content'];
    _type = json['type'];
    _fileName = json['file_name'];
    _documentId = json['document_id'];
    _isEdited = json['isEdited'];
    _timestamp = json['timestamp'];
  }*/
  String? _sender;
  String? _senderId;
  String? _content;
  String? _type;
  String? _fileName;
  String? _documentId;
  String? _passedDateFormate;
  bool? _isEdited;
  bool? _isDelete;
  List<dynamic>? _reactions;
  Timestamp? _timestamp;
MessageSchema copyWith({  String? sender,
  String? senderId,
  String? content,
  String? type,
  String? fileName,
  String? documentId,
  String? passedDateFormate,
  bool? isEdited,
  List<dynamic>? reactions,
  bool? isDelete,
  Timestamp? timestamp,
}) => MessageSchema(  sender: sender ?? _sender,
  senderId: senderId ?? _senderId,
  content: content ?? _content,
  type: type ?? _type,
  fileName: fileName ?? _fileName,
  documentId: documentId ?? _documentId,
  passedDateFormate: passedDateFormate ?? _passedDateFormate,
  isEdited: isEdited ?? _isEdited,
  isDelete: isDelete ?? _isDelete,
  reactions: reactions ?? _reactions,
  timestamp: timestamp ?? _timestamp,
);
  String? get sender => _sender;
  String? get senderId => _senderId;
  String? get content => _content;
  String? get type => _type;
  String? get fileName => _fileName;
  String? get documentId => _documentId;
  String? get passedDateFormate => _passedDateFormate;
  bool? get isEdited => _isEdited;
  bool? get isDelete => _isDelete;
  List<dynamic>? get reactions => _reactions;
  Timestamp? get timestamp => _timestamp;

  late VideoPlayerController controller;
  late Future<void> initializeVideoPlayerFuture;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sender'] = _sender;
    map['sender_id'] = _senderId;
    map['content'] = _content;
    map['type'] = _type;
    map['file_name'] = _fileName;
    map['document_id'] = _documentId;
    map['passed_date_formate'] = _passedDateFormate;
    map['is_edited'] = _isEdited;
    map['is_delete'] = _isDelete;
    map['timestamp'] = _timestamp;
    return map;
  }

}