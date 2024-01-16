import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shivalik_institute/common_widget/loading.dart';
import 'package:shivalik_institute/common_widget/no_data_new.dart';
import 'package:shivalik_institute/constant/api_end_point.dart';
import 'package:shivalik_institute/constant/colors.dart';
import 'package:shivalik_institute/model/AttendanceListResponseModel.dart';
import 'package:shivalik_institute/model/PaymentHistoryResponseModel.dart';

import '../common_widget/common_widget.dart';
import '../utils/base_class.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  BaseState<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends BaseState<AttendanceScreen> {

  bool isLoading = false;
  List<Data> listPayments = [];


  @override
  void initState(){
    getAttendanceList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: appBg,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: appBg,
            leading:  InkWell(
              borderRadius: BorderRadius.circular(52),
              onTap: () {
                Navigator.pop(context, true);
              },
              child: getBackArrow(),
            ),
            titleSpacing: 0,
            centerTitle: false,
            title: getTitle("Payment History",),
          ),
          body: isLoading
              ? const LoadingWidget()
              : listPayments.isEmpty
              ? const MyNoDataNewWidget(msg: "No Payment History Found", img: '')
              : SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  itemCount: listPayments.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        ],
                      );
                    },
                )
              ],
            ),
          ),
        ),
        onWillPop: () {
          Navigator.pop(context);
          return Future.value(true);
        },
    );
  }

  getAttendanceList() async {
    setState(() {
      isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(attendanceListUrl);

    Map<String, String> jsonBody = {
      'batch_id': '',
      'class_id': '',
      'from_app': FROM_APP,
      'limit': "5555",
      'page': "1",
      'search': "",
      'status': "1",
      'module_id': "",
      'total': "0",
      'student_id': sessionManager.getUserId() ?? '',
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> apiResponse = jsonDecode(body);
    var dataResponse = PaymentHistoryResponseModel.fromJson(apiResponse);
    if (statusCode == 200 && dataResponse.success == "1") {
      setState(() {
      });
    } else {

    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void castStatefulWidget() {
    widget as AttendanceScreen;
  }
}