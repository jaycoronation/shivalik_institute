import 'dart:convert';
/// title : "Test"
/// date : "15/02/2024"
/// event_type : "holiday"

CalendarEventModel calendarEventModelFromJson(String str) => CalendarEventModel.fromJson(json.decode(str));
String calendarEventModelToJson(CalendarEventModel data) => json.encode(data.toJson());
class CalendarEventModel {
  CalendarEventModel({
      String? title, 
      String? date, 
      String? eventType,}){
    _title = title;
    _date = date;
    _eventType = eventType;
}

  CalendarEventModel.fromJson(dynamic json) {
    _title = json['title'];
    _date = json['date'];
    _eventType = json['event_type'];
  }
  String? _title;
  String? _date;
  String? _eventType;
CalendarEventModel copyWith({  String? title,
  String? date,
  String? eventType,
}) => CalendarEventModel(  title: title ?? _title,
  date: date ?? _date,
  eventType: eventType ?? _eventType,
);
  String? get title => _title;
  String? get date => _date;
  String? get eventType => _eventType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['date'] = _date;
    map['event_type'] = _eventType;
    return map;
  }

}