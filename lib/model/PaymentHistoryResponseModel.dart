import 'dart:convert';
/// success : "1"
/// message : "List Found"
/// total_records : "8"
/// list : [{"id":"340","student_id":"129","name":"Jay Mistry","email":"jay.m@coronation.in","phone":"7433036724","amount":"399","transaction_platform":"SIRE","batch":"JRE08","aadhar":"","description":"","transaction_number":"sire-780217","payment_status":"paid","transaction_id":"","payment_mode":"cash","transaction_type":"cash","created_at":"13-01-2024","receipt_name":""},{"id":"339","student_id":"129","name":"Jay  Mistry","email":"jay.m@coronation.in","phone":"7433036724","amount":"400","transaction_platform":"SIRE","batch":"JRE08","aadhar":"","description":"","transaction_number":"sire-758226","payment_status":"paid","transaction_id":"","payment_mode":"cash","transaction_type":"cash","created_at":"13-01-2024","receipt_name":""},{"id":"338","student_id":"129","name":"Jay  Mistry","email":"jay.m@coronation.in","phone":"7433036724","amount":"400","transaction_platform":"SIRE","batch":"JRE08","aadhar":"","description":"","transaction_number":"sire-910883","payment_status":"paid","transaction_id":"","payment_mode":"cash","transaction_type":"cash","created_at":"13-01-2024","receipt_name":""},{"id":"337","student_id":"129","name":"Jay  Mistry","email":"jay.m@coronation.in","phone":"7433036724","amount":"400","transaction_platform":"SIRE","batch":"JRE08","aadhar":"","description":"","transaction_number":"sire-155445","payment_status":"paid","transaction_id":"","payment_mode":"cash","transaction_type":"cash","created_at":"13-01-2024","receipt_name":""},{"id":"336","student_id":"129","name":"Jay  Mistry","email":"jay.m@coronation.in","phone":"7433036724","amount":"400","transaction_platform":"SIRE","batch":"JRE08","aadhar":"","description":"","transaction_number":"sire-329820","payment_status":"paid","transaction_id":"","payment_mode":"cheque","transaction_type":"cheque","created_at":"13-01-2024","receipt_name":""},{"id":"335","student_id":"129","name":"Jay  Mistry","email":"jay.m@coronation.in","phone":"7433036724","amount":"400","transaction_platform":"SIRE","batch":"JRE08","aadhar":"","description":"","transaction_number":"sire-588224","payment_status":"paid","transaction_id":"","payment_mode":"cheque","transaction_type":"cheque","created_at":"13-01-2024","receipt_name":""},{"id":"334","student_id":"129","name":"Jay  Mistry","email":"jay.m@coronation.in","phone":"7433036724","amount":"89000","transaction_platform":"SIRE","batch":"JRE08","aadhar":"","description":"","transaction_number":"sire-490168","payment_status":"paid","transaction_id":"","payment_mode":"online","transaction_type":"online","created_at":"13-01-2024","receipt_name":"https://shivalik.institute/api/assets/uploads//saved_invoice/Jay_Mistry_13_01_24_01:08_AM.pdf"},{"id":"333","student_id":"129","name":"Jay  Mistry","email":"jay.m@coronation.in","phone":"7433036724","amount":"5000","transaction_platform":"SIRE","batch":"JRE08","aadhar":"","description":"","transaction_number":"sire-132438","payment_status":"paid","transaction_id":"","payment_mode":"cash","transaction_type":"cash","created_at":"13-01-2024","receipt_name":"https://shivalik.institute/api/assets/uploads//saved_invoice/Jay_Mistry_13_01_24_01:07_AM.pdf"}]

PaymentHistoryResponseModel paymentHistoryResponseModelFromJson(String str) => PaymentHistoryResponseModel.fromJson(json.decode(str));
String paymentHistoryResponseModelToJson(PaymentHistoryResponseModel data) => json.encode(data.toJson());
class PaymentHistoryResponseModel {
  PaymentHistoryResponseModel({
      String? success, 
      String? message, 
      String? totalRecords,
    List<Payments>? list,}){
    _success = success;
    _message = message;
    _totalRecords = totalRecords;
    _list = list;
}

  PaymentHistoryResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _totalRecords = json['total_records'];
    if (json['list'] != null) {
      _list = [];
      json['list'].forEach((v) {
        _list?.add(Payments.fromJson(v));
      });
    }
  }
  String? _success;
  String? _message;
  String? _totalRecords;
  List<Payments>? _list;
PaymentHistoryResponseModel copyWith({  String? success,
  String? message,
  String? totalRecords,
  List<Payments>? list,
}) => PaymentHistoryResponseModel(  success: success ?? _success,
  message: message ?? _message,
  totalRecords: totalRecords ?? _totalRecords,
  list: list ?? _list,
);
  String? get success => _success;
  String? get message => _message;
  String? get totalRecords => _totalRecords;
  List<Payments>? get list => _list;

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

/// id : "340"
/// student_id : "129"
/// name : "Jay Mistry"
/// email : "jay.m@coronation.in"
/// phone : "7433036724"
/// amount : "399"
/// transaction_platform : "SIRE"
/// batch : "JRE08"
/// aadhar : ""
/// description : ""
/// transaction_number : "sire-780217"
/// payment_status : "paid"
/// transaction_id : ""
/// payment_mode : "cash"
/// transaction_type : "cash"
/// created_at : "13-01-2024"
/// receipt_name : ""

Payments listFromJson(String str) => Payments.fromJson(json.decode(str));
String listToJson(Payments data) => json.encode(data.toJson());
class Payments {
  Payments({
      String? id, 
      String? studentId, 
      String? name, 
      String? email, 
      String? phone, 
      String? amount, 
      String? transactionPlatform, 
      String? batch, 
      String? aadhar, 
      String? description, 
      String? transactionNumber, 
      String? paymentStatus, 
      String? transactionId, 
      String? paymentMode, 
      String? transactionType, 
      String? createdAt, 
      String? receiptName,}){
    _id = id;
    _studentId = studentId;
    _name = name;
    _email = email;
    _phone = phone;
    _amount = amount;
    _transactionPlatform = transactionPlatform;
    _batch = batch;
    _aadhar = aadhar;
    _description = description;
    _transactionNumber = transactionNumber;
    _paymentStatus = paymentStatus;
    _transactionId = transactionId;
    _paymentMode = paymentMode;
    _transactionType = transactionType;
    _createdAt = createdAt;
    _receiptName = receiptName;
}

  Payments.fromJson(dynamic json) {
    _id = json['id'];
    _studentId = json['student_id'];
    _name = json['name'];
    _email = json['email'];
    _phone = json['phone'];
    _amount = json['amount'];
    _transactionPlatform = json['transaction_platform'];
    _batch = json['batch'];
    _aadhar = json['aadhar'];
    _description = json['description'];
    _transactionNumber = json['transaction_number'];
    _paymentStatus = json['payment_status'];
    _transactionId = json['transaction_id'];
    _paymentMode = json['payment_mode'];
    _transactionType = json['transaction_type'];
    _createdAt = json['created_at'];
    _receiptName = json['receipt_name'];
  }
  String? _id;
  String? _studentId;
  String? _name;
  String? _email;
  String? _phone;
  String? _amount;
  String? _transactionPlatform;
  String? _batch;
  String? _aadhar;
  String? _description;
  String? _transactionNumber;
  String? _paymentStatus;
  String? _transactionId;
  String? _paymentMode;
  String? _transactionType;
  String? _createdAt;
  String? _receiptName;
Payments copyWith({  String? id,
  String? studentId,
  String? name,
  String? email,
  String? phone,
  String? amount,
  String? transactionPlatform,
  String? batch,
  String? aadhar,
  String? description,
  String? transactionNumber,
  String? paymentStatus,
  String? transactionId,
  String? paymentMode,
  String? transactionType,
  String? createdAt,
  String? receiptName,
}) => Payments(  id: id ?? _id,
  studentId: studentId ?? _studentId,
  name: name ?? _name,
  email: email ?? _email,
  phone: phone ?? _phone,
  amount: amount ?? _amount,
  transactionPlatform: transactionPlatform ?? _transactionPlatform,
  batch: batch ?? _batch,
  aadhar: aadhar ?? _aadhar,
  description: description ?? _description,
  transactionNumber: transactionNumber ?? _transactionNumber,
  paymentStatus: paymentStatus ?? _paymentStatus,
  transactionId: transactionId ?? _transactionId,
  paymentMode: paymentMode ?? _paymentMode,
  transactionType: transactionType ?? _transactionType,
  createdAt: createdAt ?? _createdAt,
  receiptName: receiptName ?? _receiptName,
);
  String? get id => _id;
  String? get studentId => _studentId;
  String? get name => _name;
  String? get email => _email;
  String? get phone => _phone;
  String? get amount => _amount;
  String? get transactionPlatform => _transactionPlatform;
  String? get batch => _batch;
  String? get aadhar => _aadhar;
  String? get description => _description;
  String? get transactionNumber => _transactionNumber;
  String? get paymentStatus => _paymentStatus;
  String? get transactionId => _transactionId;
  String? get paymentMode => _paymentMode;
  String? get transactionType => _transactionType;
  String? get createdAt => _createdAt;
  String? get receiptName => _receiptName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['student_id'] = _studentId;
    map['name'] = _name;
    map['email'] = _email;
    map['phone'] = _phone;
    map['amount'] = _amount;
    map['transaction_platform'] = _transactionPlatform;
    map['batch'] = _batch;
    map['aadhar'] = _aadhar;
    map['description'] = _description;
    map['transaction_number'] = _transactionNumber;
    map['payment_status'] = _paymentStatus;
    map['transaction_id'] = _transactionId;
    map['payment_mode'] = _paymentMode;
    map['transaction_type'] = _transactionType;
    map['created_at'] = _createdAt;
    map['receipt_name'] = _receiptName;
    return map;
  }

}