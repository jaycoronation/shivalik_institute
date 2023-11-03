import 'dart:convert';
/// success : "1"
/// message : ""
/// total_events : "2"
/// total_classes : "2"
/// total_modules : "11"
/// completed_module : "1"
/// pending_module : "10"
/// upcoming_classes : []
/// upcoming_events : [{"id":"2","title":"Guest Lecture by Mr Chitrak Shah - Soar High","banner_image":"http://shivalik.institute/api/assets/uploads/events/1698312793_gwySaI7M.jpeg","date":"28-10-2023 12:00 AM","date_timestamp":"1698431400","description":"Lecture by CS","created_at":"21-10-2023","event_gallery":[{"event_id":"2","image":"http://shivalik.institute/api/assets/uploads/events/1697870301Chitrak-Shah.jpeg","created_at":"21-10-2023"}]},{"id":"1","title":"Guest Lecture by Mr. Pranav Shah","banner_image":"http://shivalik.institute/api/assets/uploads/events/1697613260_ldOZaIWX.jpg","date":"29-10-2023 12:00 AM","date_timestamp":"1698517800","description":"Mr Pranav Shah, Co-founder and Managing Director of Navratna Group, Ahmedabad has delivered a very interactive and insightful session on 'Journey of a Developer: Challenges and Opportunities' to the participants of SIRE.He took the audience on a virtual journey of each and every project he has delivered with interesting facts and story telling.\r\n\r\nHe conveyed a very important message that every challenge comes with an opportunity to overcome that challenge. He really inspired our participants to take risks, embark on the new path and excel as a developer.\r\n\r\nThe session was graced by Mr Chitrak Shah, founder and MD of Shivalik Group.","created_at":"18-10-2023","event_gallery":[{"event_id":"1","image":"http://shivalik.institute/api/assets/uploads/events/16976132605.webp","created_at":"18-10-2023"},{"event_id":"1","image":"http://shivalik.institute/api/assets/uploads/events/16976132606.webp","created_at":"18-10-2023"},{"event_id":"1","image":"http://shivalik.institute/api/assets/uploads/events/169761326010.webp","created_at":"18-10-2023"}]}]
/// total_holidays : "2"
/// holidays_list : [{"id":"4","title":"Christmas","description":"Christmas Description","holiday_date":"25-12-2023","status":"1","created_at":"1698304935","updated_at":"1698305130","deleted_at":""},{"id":"3","title":"Diwali","description":"Festival of Lights","holiday_date":"12-11-2023","status":"1","created_at":"1698304510","updated_at":"1698305119","deleted_at":""}]
/// fees : {"payment_mode_cash_amount":"Array","payment_mode_cheque_amount":"Array","payment_mode_netbanking_amount":"0","total_fees":"94400","pending_fees":"0","paid_fees":"0"}

DashboardResponseModel dashboardResponseModelFromJson(String str) => DashboardResponseModel.fromJson(json.decode(str));
String dashboardResponseModelToJson(DashboardResponseModel data) => json.encode(data.toJson());
class DashboardResponseModel {
  DashboardResponseModel({
      String? success, 
      String? message, 
      String? totalEvents, 
      String? totalClasses, 
      String? totalModules, 
      String? completedModule, 
      String? pendingModule, 
      List<dynamic>? upcomingClasses, 
      List<UpcomingEvents>? upcomingEvents, 
      String? totalHolidays, 
      List<HolidaysList>? holidaysList, 
      Fees? fees,}){
    _success = success;
    _message = message;
    _totalEvents = totalEvents;
    _totalClasses = totalClasses;
    _totalModules = totalModules;
    _completedModule = completedModule;
    _pendingModule = pendingModule;
    _upcomingClasses = upcomingClasses;
    _upcomingEvents = upcomingEvents;
    _totalHolidays = totalHolidays;
    _holidaysList = holidaysList;
    _fees = fees;
}

  DashboardResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _totalEvents = json['total_events'];
    _totalClasses = json['total_classes'];
    _totalModules = json['total_modules'];
    _completedModule = json['completed_module'];
    _pendingModule = json['pending_module'];
    if (json['upcoming_classes'] != null) {
      _upcomingClasses = [];
      json['upcoming_classes'].forEach((v) {
        // _upcomingClasses?.add(Dynamic.fromJson(v));
      });
    }
    if (json['upcoming_events'] != null) {
      _upcomingEvents = [];
      json['upcoming_events'].forEach((v) {
        _upcomingEvents?.add(UpcomingEvents.fromJson(v));
      });
    }
    _totalHolidays = json['total_holidays'];
    if (json['holidays_list'] != null) {
      _holidaysList = [];
      json['holidays_list'].forEach((v) {
        _holidaysList?.add(HolidaysList.fromJson(v));
      });
    }
    _fees = json['fees'] != null ? Fees.fromJson(json['fees']) : null;
  }
  String? _success;
  String? _message;
  String? _totalEvents;
  String? _totalClasses;
  String? _totalModules;
  String? _completedModule;
  String? _pendingModule;
  List<dynamic>? _upcomingClasses;
  List<UpcomingEvents>? _upcomingEvents;
  String? _totalHolidays;
  List<HolidaysList>? _holidaysList;
  Fees? _fees;
DashboardResponseModel copyWith({  String? success,
  String? message,
  String? totalEvents,
  String? totalClasses,
  String? totalModules,
  String? completedModule,
  String? pendingModule,
  List<dynamic>? upcomingClasses,
  List<UpcomingEvents>? upcomingEvents,
  String? totalHolidays,
  List<HolidaysList>? holidaysList,
  Fees? fees,
}) => DashboardResponseModel(  success: success ?? _success,
  message: message ?? _message,
  totalEvents: totalEvents ?? _totalEvents,
  totalClasses: totalClasses ?? _totalClasses,
  totalModules: totalModules ?? _totalModules,
  completedModule: completedModule ?? _completedModule,
  pendingModule: pendingModule ?? _pendingModule,
  upcomingClasses: upcomingClasses ?? _upcomingClasses,
  upcomingEvents: upcomingEvents ?? _upcomingEvents,
  totalHolidays: totalHolidays ?? _totalHolidays,
  holidaysList: holidaysList ?? _holidaysList,
  fees: fees ?? _fees,
);
  String? get success => _success;
  String? get message => _message;
  String? get totalEvents => _totalEvents;
  String? get totalClasses => _totalClasses;
  String? get totalModules => _totalModules;
  String? get completedModule => _completedModule;
  String? get pendingModule => _pendingModule;
  List<dynamic>? get upcomingClasses => _upcomingClasses;
  List<UpcomingEvents>? get upcomingEvents => _upcomingEvents;
  String? get totalHolidays => _totalHolidays;
  List<HolidaysList>? get holidaysList => _holidaysList;
  Fees? get fees => _fees;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    map['total_events'] = _totalEvents;
    map['total_classes'] = _totalClasses;
    map['total_modules'] = _totalModules;
    map['completed_module'] = _completedModule;
    map['pending_module'] = _pendingModule;
    if (_upcomingClasses != null) {
      map['upcoming_classes'] = _upcomingClasses?.map((v) => v.toJson()).toList();
    }
    if (_upcomingEvents != null) {
      map['upcoming_events'] = _upcomingEvents?.map((v) => v.toJson()).toList();
    }
    map['total_holidays'] = _totalHolidays;
    if (_holidaysList != null) {
      map['holidays_list'] = _holidaysList?.map((v) => v.toJson()).toList();
    }
    if (_fees != null) {
      map['fees'] = _fees?.toJson();
    }
    return map;
  }

}

/// payment_mode_cash_amount : "Array"
/// payment_mode_cheque_amount : "Array"
/// payment_mode_netbanking_amount : "0"
/// total_fees : "94400"
/// pending_fees : "0"
/// paid_fees : "0"

Fees feesFromJson(String str) => Fees.fromJson(json.decode(str));
String feesToJson(Fees data) => json.encode(data.toJson());
class Fees {
  Fees({
      String? paymentModeCashAmount, 
      String? paymentModeChequeAmount, 
      String? paymentModeNetbankingAmount, 
      String? totalFees, 
      String? pendingFees, 
      String? paidFees,}){
    _paymentModeCashAmount = paymentModeCashAmount;
    _paymentModeChequeAmount = paymentModeChequeAmount;
    _paymentModeNetbankingAmount = paymentModeNetbankingAmount;
    _totalFees = totalFees;
    _pendingFees = pendingFees;
    _paidFees = paidFees;
}

  Fees.fromJson(dynamic json) {
    _paymentModeCashAmount = json['payment_mode_cash_amount'];
    _paymentModeChequeAmount = json['payment_mode_cheque_amount'];
    _paymentModeNetbankingAmount = json['payment_mode_netbanking_amount'];
    _totalFees = json['total_fees'];
    _pendingFees = json['pending_fees'];
    _paidFees = json['paid_fees'];
  }
  String? _paymentModeCashAmount;
  String? _paymentModeChequeAmount;
  String? _paymentModeNetbankingAmount;
  String? _totalFees;
  String? _pendingFees;
  String? _paidFees;
Fees copyWith({  String? paymentModeCashAmount,
  String? paymentModeChequeAmount,
  String? paymentModeNetbankingAmount,
  String? totalFees,
  String? pendingFees,
  String? paidFees,
}) => Fees(  paymentModeCashAmount: paymentModeCashAmount ?? _paymentModeCashAmount,
  paymentModeChequeAmount: paymentModeChequeAmount ?? _paymentModeChequeAmount,
  paymentModeNetbankingAmount: paymentModeNetbankingAmount ?? _paymentModeNetbankingAmount,
  totalFees: totalFees ?? _totalFees,
  pendingFees: pendingFees ?? _pendingFees,
  paidFees: paidFees ?? _paidFees,
);
  String? get paymentModeCashAmount => _paymentModeCashAmount;
  String? get paymentModeChequeAmount => _paymentModeChequeAmount;
  String? get paymentModeNetbankingAmount => _paymentModeNetbankingAmount;
  String? get totalFees => _totalFees;
  String? get pendingFees => _pendingFees;
  String? get paidFees => _paidFees;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['payment_mode_cash_amount'] = _paymentModeCashAmount;
    map['payment_mode_cheque_amount'] = _paymentModeChequeAmount;
    map['payment_mode_netbanking_amount'] = _paymentModeNetbankingAmount;
    map['total_fees'] = _totalFees;
    map['pending_fees'] = _pendingFees;
    map['paid_fees'] = _paidFees;
    return map;
  }

}

/// id : "4"
/// title : "Christmas"
/// description : "Christmas Description"
/// holiday_date : "25-12-2023"
/// status : "1"
/// created_at : "1698304935"
/// updated_at : "1698305130"
/// deleted_at : ""

HolidaysList holidaysListFromJson(String str) => HolidaysList.fromJson(json.decode(str));
String holidaysListToJson(HolidaysList data) => json.encode(data.toJson());
class HolidaysList {
  HolidaysList({
      String? id, 
      String? title, 
      String? description, 
      String? holidayDate, 
      String? status, 
      String? createdAt, 
      String? updatedAt, 
      String? deletedAt,}){
    _id = id;
    _title = title;
    _description = description;
    _holidayDate = holidayDate;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
}

  HolidaysList.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _holidayDate = json['holiday_date'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
  }
  String? _id;
  String? _title;
  String? _description;
  String? _holidayDate;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  String? _deletedAt;
HolidaysList copyWith({  String? id,
  String? title,
  String? description,
  String? holidayDate,
  String? status,
  String? createdAt,
  String? updatedAt,
  String? deletedAt,
}) => HolidaysList(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
  holidayDate: holidayDate ?? _holidayDate,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
);
  String? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get holidayDate => _holidayDate;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get deletedAt => _deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['holiday_date'] = _holidayDate;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    return map;
  }

}

/// id : "2"
/// title : "Guest Lecture by Mr Chitrak Shah - Soar High"
/// banner_image : "http://shivalik.institute/api/assets/uploads/events/1698312793_gwySaI7M.jpeg"
/// date : "28-10-2023 12:00 AM"
/// date_timestamp : "1698431400"
/// description : "Lecture by CS"
/// created_at : "21-10-2023"
/// event_gallery : [{"event_id":"2","image":"http://shivalik.institute/api/assets/uploads/events/1697870301Chitrak-Shah.jpeg","created_at":"21-10-2023"}]

UpcomingEvents upcomingEventsFromJson(String str) => UpcomingEvents.fromJson(json.decode(str));
String upcomingEventsToJson(UpcomingEvents data) => json.encode(data.toJson());
class UpcomingEvents {
  UpcomingEvents({
      String? id, 
      String? title, 
      String? bannerImage, 
      String? date, 
      String? dateTimestamp, 
      String? description, 
      String? createdAt, 
      List<EventGallery>? eventGallery,}){
    _id = id;
    _title = title;
    _bannerImage = bannerImage;
    _date = date;
    _dateTimestamp = dateTimestamp;
    _description = description;
    _createdAt = createdAt;
    _eventGallery = eventGallery;
}

  UpcomingEvents.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _bannerImage = json['banner_image'];
    _date = json['date'];
    _dateTimestamp = json['date_timestamp'];
    _description = json['description'];
    _createdAt = json['created_at'];
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
  String? _dateTimestamp;
  String? _description;
  String? _createdAt;
  List<EventGallery>? _eventGallery;
UpcomingEvents copyWith({  String? id,
  String? title,
  String? bannerImage,
  String? date,
  String? dateTimestamp,
  String? description,
  String? createdAt,
  List<EventGallery>? eventGallery,
}) => UpcomingEvents(  id: id ?? _id,
  title: title ?? _title,
  bannerImage: bannerImage ?? _bannerImage,
  date: date ?? _date,
  dateTimestamp: dateTimestamp ?? _dateTimestamp,
  description: description ?? _description,
  createdAt: createdAt ?? _createdAt,
  eventGallery: eventGallery ?? _eventGallery,
);
  String? get id => _id;
  String? get title => _title;
  String? get bannerImage => _bannerImage;
  String? get date => _date;
  String? get dateTimestamp => _dateTimestamp;
  String? get description => _description;
  String? get createdAt => _createdAt;
  List<EventGallery>? get eventGallery => _eventGallery;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['banner_image'] = _bannerImage;
    map['date'] = _date;
    map['date_timestamp'] = _dateTimestamp;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    if (_eventGallery != null) {
      map['event_gallery'] = _eventGallery?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// event_id : "2"
/// image : "http://shivalik.institute/api/assets/uploads/events/1697870301Chitrak-Shah.jpeg"
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