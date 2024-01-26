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
      String? name,
      String? facultyId1,
      String? facultyId2,
      String? eventType,}){
    _title = title;
    _date = date;
    _facultyId1 = facultyId1;
    _facultyId2 = facultyId2;
    _name = name;
    _eventType = eventType;
}

  CalendarEventModel.fromJson(dynamic json) {
    _title = json['title'];
    _date = json['date'];
    _facultyId1 = json['facultyId1'];
    _facultyId2 = json['facultyId1'];
    _name = json['name'];
    _eventType = json['event_type'];
  }
  String? _title;
  String? _date;
  String? _facultyId1;
  String? _facultyId2;
  String? _name;
  String? _eventType;
CalendarEventModel copyWith({  String? title,
  String? date,
  String? facultyId1,
  String? facultyId2,
  String? name,
  String? eventType,
}) => CalendarEventModel(  title: title ?? _title,
  date: date ?? _date,
  facultyId1: facultyId1 ?? _facultyId1,
  facultyId2: facultyId2 ?? _facultyId2,
  name: name ?? _name,
  eventType: eventType ?? _eventType,
);
  String? get title => _title;
  String? get date => _date;
  String? get facultyId1 => _facultyId1;
  String? get facultyId2 => _facultyId2;
  String? get name => _name;
  String? get eventType => _eventType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['date'] = _date;
    map['name'] = _name;
    map['event_type'] = _eventType;
    return map;
  }

}