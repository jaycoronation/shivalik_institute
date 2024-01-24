import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shivalik_institute/common_widget/loading.dart';
import 'package:shivalik_institute/common_widget/no_data_new.dart';
import 'package:shivalik_institute/constant/api_end_point.dart';
import 'package:shivalik_institute/constant/colors.dart';
import 'package:shivalik_institute/model/PaymentHistoryResponseModel.dart';
import 'package:shivalik_institute/utils/pdf_viewer.dart';

import '../common_widget/common_widget.dart';
import '../common_widget/placeholder.dart';
import '../utils/base_class.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({super.key});

  @override
  BaseState<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends BaseState<PaymentHistoryScreen> {

  bool isLoading = false;
  List<Payments> listPayments = [];

  @override
  void initState(){
    getPaymentList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
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
              ? Shimmer.fromColors(
                  baseColor: Colors.grey.shade100 ,
                  highlightColor: Colors.grey.shade400,
                  child: const SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BannerPlaceholder(),
                          Gap(12),
                          BannerPlaceholder(),
                          Gap(12),
                          BannerPlaceholder(),
                          Gap(12),
                          BannerPlaceholder(),
                        ],
                      ),
                    ),
                  ),
                )
              : listPayments.isEmpty
              ? const MyNoDataNewWidget(msg: "No Payment History Found", img: '')
              : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimationLimiter(
                        child: ListView.builder(
                          itemCount: listPayments.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var getSet = listPayments[index];
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 375),
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 12),
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Expanded(
                                                    flex: 1,
                                                    child: Text("Transaction No.",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                                  ),
                                                  const Text(" : ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(getSet.transactionNumber ?? "",style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w500),),
                                                  ),
                                                ],
                                              ),
                                              const Gap(12),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Expanded(
                                                    flex: 1,
                                                    child: Text("Amount",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                                  ),
                                                  const Text(" : ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text("${getSet.amount}",style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w500),),
                                                  ),
                                                ],
                                              ),
                                              const Gap(12),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Expanded(
                                                    flex: 1,
                                                    child: Text("Payment Mode	",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                                  ),
                                                  const Text(" : ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(getSet.paymentMode ?? getSet.transactionPlatform.toString(),style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w500),),
                                                  ),
                                                ],
                                              ),
                                              const Gap(12),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Expanded(
                                                    flex: 1,
                                                    child: Text("Payment Date",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                                  ),
                                                  const Text(" : ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(getSet.createdAt ?? "",style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w500),),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Visibility(
                                            visible: getSet.receiptName?.isNotEmpty ?? false,
                                            child: GestureDetector(
                                                behavior: HitTestBehavior.opaque,
                                                onTap: () {
                                                  startActivity(context, PdfViewer(getSet.receiptName ?? '',"0"));
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.all(6.0),
                                                  child: Image.asset("assets/images/ic_download.png",height: 22,width: 22,),
                                                )
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                        ),
                      )
                    ],
                  ),
                ),
              ),
        ),
        onWillPop: () {
          Navigator.pop(context);
          return Future.value(true);
        },
    );
  }

  getPaymentList() async {
    setState(() {
      isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(paymentHistoryUrl);
    /**/

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
        listPayments = dataResponse.list ?? [];
      });
    } else {

    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void castStatefulWidget() {
    widget as PaymentHistoryScreen;
  }
}