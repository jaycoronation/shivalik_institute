import 'package:cloud_firestore/cloud_firestore.dart';

String fcmSendURL = "https://fcm.googleapis.com/fcm/send";
String contentType = "application/json";
String fcmServerKey = "key=AAAA7_KCXOk:APA91bHf7lEHDiWFC9tHheLyORs_QN6P-t6TkkgROsOdSVAuGUbAHtb0BptF9AgEGXzwXdEeIlSvNa7F424NtSdB3x6l-wIdcKNLJCRssrgih4QPzmQK1GPoqhrAJgIQtIMaW49Pamo4";

final firestoreInstance = FirebaseFirestore.instance;

String batch = "Batch";
String messages = "Message";