import 'dart:convert';
/// success : "1"
/// message : "Details Found"
/// details : {"id":"7","course_id":"1","prefix_name":"","first_name":"Priya","last_name":"Gohil","email":"priya@coronation.in","contact_no":"9033629230","user_type":"3","profile_pic":"","gender":"female","date_of_birth":"1994-05-22","highest_education":"BE CE","college_name":"GEC Rajkot","designation":"Software developer","years_of_experience":"5","teaching_experience":"","industrial_experience":"","motivation_for_teaching":"","linkedin_profile_link":"","facebook_profile_link":"","cv":"","is_active":"1","created_at":"1697612179","updated_at":"1698830927","deleted_at":"","paid_fees":94400,"pending_fees":0,"batch_id":"1","age":"29","address":"Corporate Road, Prahalad Nagar\r\n506-Pinnacle business park,","payment_mode":"Cash","payment_details":"Paid in Cash","document_submitted":["Aadhar Card"],"start_date_course":"","enrolled_by":"","total_fees":94400,"aadhar_card":"http://shivalik.institute/api/image-tool/index.php?src=http://shivalik.institute/api/assets/uploads/1697612179_Rea7nF8H.jpg","receipt":"","photo":"","family_background":"","country":"101","state":"12","city":"1019","country_name":"India","state_name":"Gujarat","city_name":"Ahmedabad","hourly_rate":"","bank_name":"","account_no":"","ifsc_code":"","past":"","skills":"","education":"","alt_email":"","payment_mode_cash":1,"payment_mode_cheque":1,"payment_mode_netbanking":0,"payment_mode_cash_amount":"60000","payment_mode_cheque_amount":"34400","payment_mode_netbanking_amount":"","holding_seat":0,"enrolled_in_course":1,"holding_seat_desc":"","enrolled_in_course_desc":"test","pan_card":"","payment_link":"https://www.shivalik.institute/payment/7"}

UserProfileResponseModel userProfileResponseModelFromJson(String str) => UserProfileResponseModel.fromJson(json.decode(str));
String userProfileResponseModelToJson(UserProfileResponseModel data) => json.encode(data.toJson());
class UserProfileResponseModel {
  UserProfileResponseModel({
      String? success, 
      String? message, 
      Details? details,}){
    _success = success;
    _message = message;
    _details = details;
}

  UserProfileResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _details = json['details'] != null
        ? json['details'] is String
        ? Details()
        : Details.fromJson(json['details'])
        : null;
  }
  String? _success;
  String? _message;
  Details? _details;
UserProfileResponseModel copyWith({  String? success,
  String? message,
  Details? details,
}) => UserProfileResponseModel(  success: success ?? _success,
  message: message ?? _message,
  details: details ?? _details,
);
  String? get success => _success;
  String? get message => _message;
  Details? get details => _details;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_details != null) {
      map['details'] = _details?.toJson();
    }
    return map;
  }

}

/// id : "7"
/// course_id : "1"
/// prefix_name : ""
/// first_name : "Priya"
/// last_name : "Gohil"
/// email : "priya@coronation.in"
/// contact_no : "9033629230"
/// user_type : "3"
/// profile_pic : ""
/// gender : "female"
/// date_of_birth : "1994-05-22"
/// highest_education : "BE CE"
/// college_name : "GEC Rajkot"
/// designation : "Software developer"
/// years_of_experience : "5"
/// teaching_experience : ""
/// industrial_experience : ""
/// motivation_for_teaching : ""
/// linkedin_profile_link : ""
/// facebook_profile_link : ""
/// cv : ""
/// is_active : "1"
/// created_at : "1697612179"
/// updated_at : "1698830927"
/// deleted_at : ""
/// paid_fees : 94400
/// pending_fees : 0
/// batch_id : "1"
/// age : "29"
/// address : "Corporate Road, Prahalad Nagar\r\n506-Pinnacle business park,"
/// payment_mode : "Cash"
/// payment_details : "Paid in Cash"
/// document_submitted : ["Aadhar Card"]
/// start_date_course : ""
/// enrolled_by : ""
/// total_fees : 94400
/// aadhar_card : "http://shivalik.institute/api/image-tool/index.php?src=http://shivalik.institute/api/assets/uploads/1697612179_Rea7nF8H.jpg"
/// receipt : ""
/// photo : ""
/// family_background : ""
/// country : "101"
/// state : "12"
/// city : "1019"
/// country_name : "India"
/// state_name : "Gujarat"
/// city_name : "Ahmedabad"
/// hourly_rate : ""
/// bank_name : ""
/// account_no : ""
/// ifsc_code : ""
/// past : ""
/// skills : ""
/// education : ""
/// alt_email : ""
/// payment_mode_cash : 1
/// payment_mode_cheque : 1
/// payment_mode_netbanking : 0
/// payment_mode_cash_amount : "60000"
/// payment_mode_cheque_amount : "34400"
/// payment_mode_netbanking_amount : ""
/// holding_seat : 0
/// enrolled_in_course : 1
/// holding_seat_desc : ""
/// enrolled_in_course_desc : "test"
/// pan_card : ""
/// payment_link : "https://www.shivalik.institute/payment/7"

Details detailsFromJson(String str) => Details.fromJson(json.decode(str));
String detailsToJson(Details data) => json.encode(data.toJson());
class Details {
  Details({
      String? about,
      String? id,
      String? courseId,
      String? isAlumini,
      String? pincode,
      String? lastFeedbackClassId,
      String? prefixName,
      String? batchName,
      String? courseName,
      String? firstName,
      String? lastName, 
      String? email, 
      String? contactNo, 
      String? userType, 
      String? profilePic, 
      String? gender, 
      String? dateOfBirth, 
      String? highestEducation, 
      String? collegeName, 
      String? designation, 
      String? yearsOfExperience, 
      String? teachingExperience, 
      String? industrialExperience, 
      String? motivationForTeaching, 
      String? linkedinProfileLink, 
      String? facebookProfileLink, 
      String? cv, 
      String? isActive, 
      String? createdAt, 
      String? updatedAt, 
      String? deletedAt, 
      num? paidFees, 
      num? pendingFees, 
      String? batchId, 
      String? age, 
      String? address, 
      String? paymentMode, 
      String? paymentDetails, 
      List<String>? documentSubmitted, 
      String? startDateCourse, 
      String? enrolledBy, 
      num? totalFees, 
      String? aadharCard, 
      String? receipt, 
      String? photo, 
      String? familyBackground, 
      String? country, 
      String? state, 
      String? city, 
      String? countryName, 
      String? stateName, 
      String? cityName, 
      String? hourlyRate, 
      String? bankName, 
      String? accountNo, 
      String? ifscCode, 
      String? past, 
      String? skills, 
      String? education, 
      String? altEmail, 
      num? paymentModeCash, 
      num? paymentModeCheque, 
      num? paymentModeNetbanking, 
      String? paymentModeCashAmount, 
      String? paymentModeChequeAmount, 
      String? paymentModeNetbankingAmount, 
      num? holdingSeat, 
      num? enrolledInCourse, 
      String? holdingSeatDesc, 
      String? enrolledInCourseDesc, 
      String? panCard, 
      String? invoiceFile,
      String? paymentLink,}){
    _id = id;
    _about = about;
    _pincode = pincode;
    _lastFeedbackClassId = lastFeedbackClassId;
    _courseId = courseId;
    _isAlumini = isAlumini;
    _prefixName = prefixName;
    _batchName = batchName;
    _courseName = courseName;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _contactNo = contactNo;
    _userType = userType;
    _profilePic = profilePic;
    _gender = gender;
    _dateOfBirth = dateOfBirth;
    _highestEducation = highestEducation;
    _collegeName = collegeName;
    _designation = designation;
    _yearsOfExperience = yearsOfExperience;
    _teachingExperience = teachingExperience;
    _industrialExperience = industrialExperience;
    _motivationForTeaching = motivationForTeaching;
    _linkedinProfileLink = linkedinProfileLink;
    _facebookProfileLink = facebookProfileLink;
    _cv = cv;
    _isActive = isActive;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _paidFees = paidFees;
    _pendingFees = pendingFees;
    _batchId = batchId;
    _age = age;
    _address = address;
    _paymentMode = paymentMode;
    _paymentDetails = paymentDetails;
    _documentSubmitted = documentSubmitted;
    _startDateCourse = startDateCourse;
    _enrolledBy = enrolledBy;
    _totalFees = totalFees;
    _aadharCard = aadharCard;
    _receipt = receipt;
    _photo = photo;
    _familyBackground = familyBackground;
    _country = country;
    _state = state;
    _city = city;
    _countryName = countryName;
    _stateName = stateName;
    _cityName = cityName;
    _hourlyRate = hourlyRate;
    _bankName = bankName;
    _accountNo = accountNo;
    _ifscCode = ifscCode;
    _past = past;
    _skills = skills;
    _education = education;
    _altEmail = altEmail;
    _paymentModeCash = paymentModeCash;
    _paymentModeCheque = paymentModeCheque;
    _paymentModeNetbanking = paymentModeNetbanking;
    _paymentModeCashAmount = paymentModeCashAmount;
    _paymentModeChequeAmount = paymentModeChequeAmount;
    _paymentModeNetbankingAmount = paymentModeNetbankingAmount;
    _holdingSeat = holdingSeat;
    _enrolledInCourse = enrolledInCourse;
    _holdingSeatDesc = holdingSeatDesc;
    _enrolledInCourseDesc = enrolledInCourseDesc;
    _panCard = panCard;
    _invoiceFile = invoiceFile;
    _paymentLink = paymentLink;
}

  Details.fromJson(dynamic json) {
    _id = json['id'];
    _about = json['about'];
    _pincode = json['pincode'];
    _lastFeedbackClassId = json['last_feedback_class_id'];
    _courseId = json['course_id'];
    _isAlumini = json['is_alumini'];
    _prefixName = json['prefix_name'];
    _batchName = json['batch_name'];
    _courseName = json['course_name'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _contactNo = json['contact_no'];
    _userType = json['user_type'];
    _profilePic = json['profile_pic'];
    _gender = json['gender'];
    _dateOfBirth = json['date_of_birth'];
    _highestEducation = json['highest_education'];
    _collegeName = json['college_name'];
    _designation = json['designation'];
    _yearsOfExperience = json['years_of_experience'];
    _teachingExperience = json['teaching_experience'];
    _industrialExperience = json['industrial_experience'];
    _motivationForTeaching = json['motivation_for_teaching'];
    _linkedinProfileLink = json['linkedin_profile_link'];
    _facebookProfileLink = json['facebook_profile_link'];
    _cv = json['cv'];
    _isActive = json['is_active'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
    _paidFees = json['paid_fees'];
    _pendingFees = json['pending_fees'];
    _batchId = json['batch_id'];
    _age = json['age'];
    _address = json['address'];
    _paymentMode = json['payment_mode'];
    _paymentDetails = json['payment_details'];
    //_documentSubmitted = json['document_submitted'] != null ? json['document_submitted'].cast<String>() : [];
    _startDateCourse = json['start_date_course'];
    _enrolledBy = json['enrolled_by'];
    _totalFees = json['total_fees'];
    _aadharCard = json['aadhar_card'];
    _receipt = json['receipt'];
    _photo = json['photo'];
    _familyBackground = json['family_background'];
    _country = json['country'];
    _state = json['state'];
    _city = json['city'];
    _countryName = json['country_name'];
    _stateName = json['state_name'];
    _cityName = json['city_name'];
    _hourlyRate = json['hourly_rate'];
    _bankName = json['bank_name'];
    _accountNo = json['account_no'];
    _ifscCode = json['ifsc_code'];
    _past = json['past'];
    _skills = json['skills'];
    _education = json['education'];
    _altEmail = json['alt_email'];
    _paymentModeCash = json['payment_mode_cash'];
    _paymentModeCheque = json['payment_mode_cheque'];
    _paymentModeNetbanking = json['payment_mode_netbanking'];
    _paymentModeCashAmount = json['payment_mode_cash_amount'];
    _paymentModeChequeAmount = json['payment_mode_cheque_amount'];
    _paymentModeNetbankingAmount = json['payment_mode_netbanking_amount'];
    _holdingSeat = json['holding_seat'];
    _enrolledInCourse = json['enrolled_in_course'];
    _holdingSeatDesc = json['holding_seat_desc'];
    _enrolledInCourseDesc = json['enrolled_in_course_desc'];
    _panCard = json['pan_card'];
    _invoiceFile = json['invoice_file'];
    _paymentLink = json['payment_link'];
  }
  String? _about;
  String? _id;
  String? _courseId;
  String? _isAlumini;
  String? _pincode;
  String? _lastFeedbackClassId;
  String? _prefixName;
  String? _batchName;
  String? _courseName;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _contactNo;
  String? _userType;
  String? _profilePic;
  String? _gender;
  String? _dateOfBirth;
  String? _highestEducation;
  String? _collegeName;
  String? _designation;
  String? _yearsOfExperience;
  String? _teachingExperience;
  String? _industrialExperience;
  String? _motivationForTeaching;
  String? _linkedinProfileLink;
  String? _facebookProfileLink;
  String? _cv;
  String? _isActive;
  String? _createdAt;
  String? _updatedAt;
  String? _deletedAt;
  num? _paidFees;
  num? _pendingFees;
  String? _batchId;
  String? _age;
  String? _address;
  String? _paymentMode;
  String? _paymentDetails;
  List<String>? _documentSubmitted;
  String? _startDateCourse;
  String? _enrolledBy;
  num? _totalFees;
  String? _aadharCard;
  String? _receipt;
  String? _photo;
  String? _familyBackground;
  String? _country;
  String? _state;
  String? _city;
  String? _countryName;
  String? _stateName;
  String? _cityName;
  String? _hourlyRate;
  String? _bankName;
  String? _accountNo;
  String? _ifscCode;
  String? _past;
  String? _skills;
  String? _education;
  String? _altEmail;
  num? _paymentModeCash;
  num? _paymentModeCheque;
  num? _paymentModeNetbanking;
  String? _paymentModeCashAmount;
  String? _paymentModeChequeAmount;
  String? _paymentModeNetbankingAmount;
  num? _holdingSeat;
  num? _enrolledInCourse;
  String? _holdingSeatDesc;
  String? _enrolledInCourseDesc;
  String? _panCard;
  String? _invoiceFile;
  String? _paymentLink;
Details copyWith({  String? id,
  String? about,
  String? courseId,
  String? isAlumini,
  String? pincode,
  String? lastFeedbackClassId,
  String? prefixName,
  String? batchName,
  String? courseName,
  String? firstName,
  String? lastName,
  String? email,
  String? contactNo,
  String? userType,
  String? profilePic,
  String? gender,
  String? dateOfBirth,
  String? highestEducation,
  String? collegeName,
  String? designation,
  String? yearsOfExperience,
  String? teachingExperience,
  String? industrialExperience,
  String? motivationForTeaching,
  String? linkedinProfileLink,
  String? facebookProfileLink,
  String? cv,
  String? isActive,
  String? createdAt,
  String? updatedAt,
  String? deletedAt,
  num? paidFees,
  num? pendingFees,
  String? batchId,
  String? age,
  String? address,
  String? paymentMode,
  String? paymentDetails,
  List<String>? documentSubmitted,
  String? startDateCourse,
  String? enrolledBy,
  num? totalFees,
  String? aadharCard,
  String? receipt,
  String? photo,
  String? familyBackground,
  String? country,
  String? state,
  String? city,
  String? countryName,
  String? stateName,
  String? cityName,
  String? hourlyRate,
  String? bankName,
  String? accountNo,
  String? ifscCode,
  String? past,
  String? skills,
  String? education,
  String? altEmail,
  num? paymentModeCash,
  num? paymentModeCheque,
  num? paymentModeNetbanking,
  String? paymentModeCashAmount,
  String? paymentModeChequeAmount,
  String? paymentModeNetbankingAmount,
  num? holdingSeat,
  num? enrolledInCourse,
  String? holdingSeatDesc,
  String? enrolledInCourseDesc,
  String? panCard,
  String? invoiceFile,
  String? paymentLink,
}) => Details(  id: id ?? _id,
  about: about ?? _about,
  courseId: courseId ?? _courseId,
  isAlumini: isAlumini ?? _isAlumini,
  pincode: pincode ?? _pincode,
  lastFeedbackClassId: lastFeedbackClassId ?? _lastFeedbackClassId,
  prefixName: prefixName ?? _prefixName,
  batchName: batchName ?? _batchName,
  courseName: courseName ?? _courseName,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  email: email ?? _email,
  contactNo: contactNo ?? _contactNo,
  userType: userType ?? _userType,
  profilePic: profilePic ?? _profilePic,
  gender: gender ?? _gender,
  dateOfBirth: dateOfBirth ?? _dateOfBirth,
  highestEducation: highestEducation ?? _highestEducation,
  collegeName: collegeName ?? _collegeName,
  designation: designation ?? _designation,
  yearsOfExperience: yearsOfExperience ?? _yearsOfExperience,
  teachingExperience: teachingExperience ?? _teachingExperience,
  industrialExperience: industrialExperience ?? _industrialExperience,
  motivationForTeaching: motivationForTeaching ?? _motivationForTeaching,
  linkedinProfileLink: linkedinProfileLink ?? _linkedinProfileLink,
  facebookProfileLink: facebookProfileLink ?? _facebookProfileLink,
  cv: cv ?? _cv,
  isActive: isActive ?? _isActive,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
  paidFees: paidFees ?? _paidFees,
  pendingFees: pendingFees ?? _pendingFees,
  batchId: batchId ?? _batchId,
  age: age ?? _age,
  address: address ?? _address,
  paymentMode: paymentMode ?? _paymentMode,
  paymentDetails: paymentDetails ?? _paymentDetails,
  documentSubmitted: documentSubmitted ?? _documentSubmitted,
  startDateCourse: startDateCourse ?? _startDateCourse,
  enrolledBy: enrolledBy ?? _enrolledBy,
  totalFees: totalFees ?? _totalFees,
  aadharCard: aadharCard ?? _aadharCard,
  receipt: receipt ?? _receipt,
  photo: photo ?? _photo,
  familyBackground: familyBackground ?? _familyBackground,
  country: country ?? _country,
  state: state ?? _state,
  city: city ?? _city,
  countryName: countryName ?? _countryName,
  stateName: stateName ?? _stateName,
  cityName: cityName ?? _cityName,
  hourlyRate: hourlyRate ?? _hourlyRate,
  bankName: bankName ?? _bankName,
  accountNo: accountNo ?? _accountNo,
  ifscCode: ifscCode ?? _ifscCode,
  past: past ?? _past,
  skills: skills ?? _skills,
  education: education ?? _education,
  altEmail: altEmail ?? _altEmail,
  paymentModeCash: paymentModeCash ?? _paymentModeCash,
  paymentModeCheque: paymentModeCheque ?? _paymentModeCheque,
  paymentModeNetbanking: paymentModeNetbanking ?? _paymentModeNetbanking,
  paymentModeCashAmount: paymentModeCashAmount ?? _paymentModeCashAmount,
  paymentModeChequeAmount: paymentModeChequeAmount ?? _paymentModeChequeAmount,
  paymentModeNetbankingAmount: paymentModeNetbankingAmount ?? _paymentModeNetbankingAmount,
  holdingSeat: holdingSeat ?? _holdingSeat,
  enrolledInCourse: enrolledInCourse ?? _enrolledInCourse,
  holdingSeatDesc: holdingSeatDesc ?? _holdingSeatDesc,
  enrolledInCourseDesc: enrolledInCourseDesc ?? _enrolledInCourseDesc,
  panCard: panCard ?? _panCard,
  invoiceFile: invoiceFile ?? _invoiceFile,
  paymentLink: paymentLink ?? _paymentLink,
);
  String? get id => _id;
  String? get about => _about;
  String? get pincode => _pincode;
  String? get lastFeedbackClassId => _lastFeedbackClassId;
  String? get courseId => _courseId;
  String? get isAlumini => _isAlumini;
  String? get prefixName => _prefixName;
  String? get batchName => _batchName;
  String? get courseName => _courseName;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get contactNo => _contactNo;
  String? get userType => _userType;
  String? get profilePic => _profilePic;
  String? get gender => _gender;
  String? get dateOfBirth => _dateOfBirth;
  String? get highestEducation => _highestEducation;
  String? get collegeName => _collegeName;
  String? get designation => _designation;
  String? get yearsOfExperience => _yearsOfExperience;
  String? get teachingExperience => _teachingExperience;
  String? get industrialExperience => _industrialExperience;
  String? get motivationForTeaching => _motivationForTeaching;
  String? get linkedinProfileLink => _linkedinProfileLink;
  String? get facebookProfileLink => _facebookProfileLink;
  String? get cv => _cv;
  String? get isActive => _isActive;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get deletedAt => _deletedAt;
  num? get paidFees => _paidFees;
  num? get pendingFees => _pendingFees;
  String? get batchId => _batchId;
  String? get age => _age;
  String? get address => _address;
  String? get paymentMode => _paymentMode;
  String? get paymentDetails => _paymentDetails;
  List<String>? get documentSubmitted => _documentSubmitted;
  String? get startDateCourse => _startDateCourse;
  String? get enrolledBy => _enrolledBy;
  num? get totalFees => _totalFees;
  String? get aadharCard => _aadharCard;
  String? get receipt => _receipt;
  String? get photo => _photo;
  String? get familyBackground => _familyBackground;
  String? get country => _country;
  String? get state => _state;
  String? get city => _city;
  String? get countryName => _countryName;
  String? get stateName => _stateName;
  String? get cityName => _cityName;
  String? get hourlyRate => _hourlyRate;
  String? get bankName => _bankName;
  String? get accountNo => _accountNo;
  String? get ifscCode => _ifscCode;
  String? get past => _past;
  String? get skills => _skills;
  String? get education => _education;
  String? get altEmail => _altEmail;
  num? get paymentModeCash => _paymentModeCash;
  num? get paymentModeCheque => _paymentModeCheque;
  num? get paymentModeNetbanking => _paymentModeNetbanking;
  String? get paymentModeCashAmount => _paymentModeCashAmount;
  String? get paymentModeChequeAmount => _paymentModeChequeAmount;
  String? get paymentModeNetbankingAmount => _paymentModeNetbankingAmount;
  num? get holdingSeat => _holdingSeat;
  num? get enrolledInCourse => _enrolledInCourse;
  String? get holdingSeatDesc => _holdingSeatDesc;
  String? get enrolledInCourseDesc => _enrolledInCourseDesc;
  String? get panCard => _panCard;
  String? get invoiceFile => _invoiceFile;
  String? get paymentLink => _paymentLink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['about'] = _about;
    map['pincode'] = _pincode;
    map['last_feedback_class_id'] = _lastFeedbackClassId;
    map['course_id'] = _courseId;
    map['is_alumini'] = _isAlumini;
    map['prefix_name'] = _prefixName;
    map['batch_name'] = _batchName;
    map['course_name'] = _courseName;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['contact_no'] = _contactNo;
    map['user_type'] = _userType;
    map['profile_pic'] = _profilePic;
    map['gender'] = _gender;
    map['date_of_birth'] = _dateOfBirth;
    map['highest_education'] = _highestEducation;
    map['college_name'] = _collegeName;
    map['designation'] = _designation;
    map['years_of_experience'] = _yearsOfExperience;
    map['teaching_experience'] = _teachingExperience;
    map['industrial_experience'] = _industrialExperience;
    map['motivation_for_teaching'] = _motivationForTeaching;
    map['linkedin_profile_link'] = _linkedinProfileLink;
    map['facebook_profile_link'] = _facebookProfileLink;
    map['cv'] = _cv;
    map['is_active'] = _isActive;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    map['paid_fees'] = _paidFees;
    map['pending_fees'] = _pendingFees;
    map['batch_id'] = _batchId;
    map['age'] = _age;
    map['address'] = _address;
    map['payment_mode'] = _paymentMode;
    map['payment_details'] = _paymentDetails;
    map['document_submitted'] = _documentSubmitted;
    map['start_date_course'] = _startDateCourse;
    map['enrolled_by'] = _enrolledBy;
    map['total_fees'] = _totalFees;
    map['aadhar_card'] = _aadharCard;
    map['receipt'] = _receipt;
    map['photo'] = _photo;
    map['family_background'] = _familyBackground;
    map['country'] = _country;
    map['state'] = _state;
    map['city'] = _city;
    map['country_name'] = _countryName;
    map['state_name'] = _stateName;
    map['city_name'] = _cityName;
    map['hourly_rate'] = _hourlyRate;
    map['bank_name'] = _bankName;
    map['account_no'] = _accountNo;
    map['ifsc_code'] = _ifscCode;
    map['past'] = _past;
    map['skills'] = _skills;
    map['education'] = _education;
    map['alt_email'] = _altEmail;
    map['payment_mode_cash'] = _paymentModeCash;
    map['payment_mode_cheque'] = _paymentModeCheque;
    map['payment_mode_netbanking'] = _paymentModeNetbanking;
    map['payment_mode_cash_amount'] = _paymentModeCashAmount;
    map['payment_mode_cheque_amount'] = _paymentModeChequeAmount;
    map['payment_mode_netbanking_amount'] = _paymentModeNetbankingAmount;
    map['holding_seat'] = _holdingSeat;
    map['enrolled_in_course'] = _enrolledInCourse;
    map['holding_seat_desc'] = _holdingSeatDesc;
    map['enrolled_in_course_desc'] = _enrolledInCourseDesc;
    map['pan_card'] = _panCard;
    map['invoice_file'] = _invoiceFile;
    map['payment_link'] = _paymentLink;
    return map;
  }

}