import 'dart:convert';

import 'package:flutter/cupertino.dart';
/// success : "1"
/// message : "Form details!"
/// details : {"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","status":"1","timestamp":"1697797574","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]}]}

FeedbackFormResponseModel feedbackFormResponseModelFromJson(String str) => FeedbackFormResponseModel.fromJson(json.decode(str));
String feedbackFormResponseModelToJson(FeedbackFormResponseModel data) => json.encode(data.toJson());
class FeedbackFormResponseModel {
  FeedbackFormResponseModel({
      String? success, 
      String? message, 
      Details? details,}){
    _success = success;
    _message = message;
    _details = details;
}

  FeedbackFormResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _details = json['details'] != null ? Details.fromJson(json['details']) : null;
  }
  String? _success;
  String? _message;
  Details? _details;
FeedbackFormResponseModel copyWith({  String? success,
  String? message,
  Details? details,
}) => FeedbackFormResponseModel(  success: success ?? _success,
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

/// form_id : "1"
/// form_name : "Session Feedback Form"
/// form_type : "feedback"
/// status : "1"
/// timestamp : "1697797574"
/// questions : [{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]}]

Details detailsFromJson(String str) => Details.fromJson(json.decode(str));
String detailsToJson(Details data) => json.encode(data.toJson());
class Details {
  Details({
      String? formId, 
      String? formName, 
      String? formType, 
      String? status, 
      String? timestamp, 
      List<Questions>? questions,}){
    _formId = formId;
    _formName = formName;
    _formType = formType;
    _status = status;
    _timestamp = timestamp;
    _questions = questions;
}

  Details.fromJson(dynamic json) {
    _formId = json['form_id'];
    _formName = json['form_name'];
    _formType = json['form_type'];
    _status = json['status'];
    _timestamp = json['timestamp'];
    if (json['questions'] != null) {
      _questions = [];
      json['questions'].forEach((v) {
        _questions?.add(Questions.fromJson(v));
      });
    }
  }
  String? _formId;
  String? _formName;
  String? _formType;
  String? _status;
  String? _timestamp;
  List<Questions>? _questions;
Details copyWith({  String? formId,
  String? formName,
  String? formType,
  String? status,
  String? timestamp,
  List<Questions>? questions,
}) => Details(  formId: formId ?? _formId,
  formName: formName ?? _formName,
  formType: formType ?? _formType,
  status: status ?? _status,
  timestamp: timestamp ?? _timestamp,
  questions: questions ?? _questions,
);
  String? get formId => _formId;
  String? get formName => _formName;
  String? get formType => _formType;
  String? get status => _status;
  String? get timestamp => _timestamp;
  List<Questions>? get questions => _questions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['form_id'] = _formId;
    map['form_name'] = _formName;
    map['form_type'] = _formType;
    map['status'] = _status;
    map['timestamp'] = _timestamp;
    if (_questions != null) {
      map['questions'] = _questions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// question_id : "1"
/// form_id : "1"
/// title : "How did you find today's session?"
/// input_id : "2"
/// input_name : "radio"
/// no_lines : ""
/// status : "1"
/// options : [{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]

Questions questionsFromJson(String str) => Questions.fromJson(json.decode(str));
String questionsToJson(Questions data) => json.encode(data.toJson());
class Questions {
  Questions({
      String? questionId, 
      String? formId, 
      String? title, 
      String? inputId, 
      String? inputName, 
      String? noLines, 
      String? status, 
      bool isOpen = false,
      List<Options>? options,}){
    _questionId = questionId;
    _formId = formId;
    _title = title;
    _inputId = inputId;
    _inputName = inputName;
    _noLines = noLines;
    _status = status;
    _isOpen = isOpen;
    _options = options;
}

  Questions.fromJson(dynamic json) {
    _questionId = json['question_id'];
    _formId = json['form_id'];
    _title = json['title'];
    _inputId = json['input_id'];
    _inputName = json['input_name'];
    _noLines = json['no_lines'];
    _status = json['status'];
    if (json['options'] != null) {
      _options = [];
      json['options'].forEach((v) {
        _options?.add(Options.fromJson(v));
      });
    }
  }
  String? _questionId;
  String? _formId;
  String? _title;
  String? _inputId;
  String? _inputName;
  String? _noLines;
  String? _status;
  bool _isOpen = false;
  List<Options>? _options;
Questions copyWith({  String? questionId,
  String? formId,
  String? title,
  String? inputId,
  String? inputName,
  String? noLines,
  String? status,
  bool isOpen = false,
  List<Options>? options,
}) => Questions(  questionId: questionId ?? _questionId,
  formId: formId ?? _formId,
  title: title ?? _title,
  inputId: inputId ?? _inputId,
  inputName: inputName ?? _inputName,
  noLines: noLines ?? _noLines,
  status: status ?? _status,
  isOpen: isOpen ?? _isOpen,
  options: options ?? _options,
);
  String? get questionId => _questionId;
  String? get formId => _formId;
  String? get title => _title;
  String? get inputId => _inputId;
  String? get inputName => _inputName;
  String? get noLines => _noLines;
  String? get status => _status;
  bool get isOpen => _isOpen;
  late AnimationController animationController;

  set isOpen(bool value) {
    _isOpen = value;
  }

  List<Options>? get options => _options;
  TextEditingController controller = TextEditingController();

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['question_id'] = _questionId;
    map['form_id'] = _formId;
    map['title'] = _title;
    map['input_id'] = _inputId;
    map['input_name'] = _inputName;
    map['no_lines'] = _noLines;
    map['status'] = _status;
    if (_options != null) {
      map['options'] = _options?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// opt_id : "1"
/// options : "Excellent"
/// correct_answer : ""

Options optionsFromJson(String str) => Options.fromJson(json.decode(str));
String optionsToJson(Options data) => json.encode(data.toJson());
class Options {
  Options({
      String? optId, 
      String? options, 
      bool isSelected = false,
      String? correctAnswer,}){
    _optId = optId;
    _options = options;
    _isSelected = isSelected;
    _correctAnswer = correctAnswer;
}

  Options.fromJson(dynamic json) {
    _optId = json['opt_id'];
    _options = json['options'];
    _correctAnswer = json['correct_answer'];
  }
  String? _optId;
  String? _options;
  bool _isSelected = false;
  String? _correctAnswer;
Options copyWith({  String? optId,
  String? options,
  bool isSelected = false,
  String? correctAnswer,
}) => Options(  optId: optId ?? _optId,
  options: options ?? _options,
  isSelected: isSelected ?? _isSelected,
  correctAnswer: correctAnswer ?? _correctAnswer,
);
  String? get optId => _optId;
  String? get options => _options;
  bool get isSelected => _isSelected;

  set isSelected(bool value) {
    _isSelected = value;
  }

  String? get correctAnswer => _correctAnswer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['opt_id'] = _optId;
    map['options'] = _options;
    map['isSelected'] = _isSelected;
    map['correct_answer'] = _correctAnswer;
    return map;
  }

}