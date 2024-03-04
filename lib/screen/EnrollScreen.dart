import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:provider/provider.dart';
import 'package:shivalik_institute/constant/api_end_point.dart';
import 'package:shivalik_institute/model/CommonResponseModel.dart';
import 'package:shivalik_institute/utils/app_utils.dart';

import '../common_widget/common_widget.dart';
import '../constant/colors.dart';
import '../model/BatchResponseModel.dart';
import '../utils/base_class.dart';
import '../viewmodels/BatchViewModel.dart';

class EnrollScreen extends StatefulWidget {
  const EnrollScreen({super.key});

  @override
  BaseState<EnrollScreen> createState() => _EnrollScreenState();
}

class _EnrollScreenState extends BaseState<EnrollScreen> {

  bool isLoading = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController batchController = TextEditingController();

  List<BatchList> listBatches = [];

  String batchId = "";
  String batchName = "";

  @override
  void initState(){
    super.initState();
    getBatchData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            toolbarHeight: 55,
            automaticallyImplyLeading: false,
            leading: InkWell(
                borderRadius: BorderRadius.circular(52),
                customBorder: const CircleBorder(),
                onTap: () {
                  Navigator.pop(context);
                },
                child: getBackArrow()
            ),
            title: getTitle("Enroll Now"),
            centerTitle: false,
            elevation: 0,
            titleSpacing: 0,
            backgroundColor: white,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(50),
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset( 'assets/images/ic_shivalik_ins_logo.png', width: 160, height: 70),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 8, right: 8,top: 60),
                    child: TextField(
                      cursorColor: black,
                      controller: nameController,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.name,
                      style: getTextFiledStyle(),
                      decoration: InputDecoration(
                        hintText: 'Name',
                        counterText: "",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(kEditTextCornerRadius),
                            borderSide:  const BorderSide(width: 1, style: BorderStyle.solid, color: gray)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(kEditTextCornerRadius),
                            borderSide:  const BorderSide(width: 1, style: BorderStyle.solid, color: gray)),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 8, right: 8,top: 22),
                    child: TextField(
                      cursorColor: black,
                      controller: emailController,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.emailAddress,
                      style: getTextFiledStyle(),
                      decoration: InputDecoration(
                        hintText: 'Email',
                        counterText: "",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(kEditTextCornerRadius),
                            borderSide:  const BorderSide(width: 1, style: BorderStyle.solid, color: gray)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(kEditTextCornerRadius),
                            borderSide:  const BorderSide(width: 1, style: BorderStyle.solid, color: gray)),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 8, right: 8,top: 22),
                    child: TextField(
                      cursorColor: black,
                      controller: mobileController,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      style: getTextFiledStyle(),
                      decoration: InputDecoration(
                        hintText: 'Contact No',
                        counterText: "",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(kEditTextCornerRadius),
                            borderSide:  const BorderSide(width: 1, style: BorderStyle.solid, color: gray)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(kEditTextCornerRadius),
                            borderSide:  const BorderSide(width: 1, style: BorderStyle.solid, color: gray)),
                      ),
                    ),
                  ),
                  Consumer<BatchViewModel>(
                    builder: (context, value, child) {
                      return Container(
                        margin: const EdgeInsets.only(left: 8, right: 8,top: 22),
                        child: Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            TextField(
                              onTap: (){
                                openBatchBottomSheet(value.response.batchList ?? []);
                              },
                              readOnly: true,
                              cursorColor: black,
                              textCapitalization: TextCapitalization.words,
                              controller: batchController,
                              keyboardType: TextInputType.text,
                              style: getTextFiledStyle(),
                              decoration: const InputDecoration(
                                labelText: 'Select Batch',
                                  suffixIcon: Icon(Icons.arrow_drop_down,size: 22,color: black),
                              ),
                            ),
                            Visibility(
                              visible: value.isLoading,
                              child: Container(
                                alignment: Alignment.centerRight,
                                margin: const EdgeInsets.only(right: 12),
                                child: const Padding(
                                  padding: EdgeInsets.only(top: 10,bottom: 10),
                                  child: SizedBox(width: 20,height: 20,child: CircularProgressIndicator(color: black,strokeWidth: 2)),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30,left: 8, right: 8),
                    width: double.infinity,
                    child: TextButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(kBorderRadius),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(black)
                        ),
                        onPressed: () async {
                          FocusScope.of(context).requestFocus(FocusNode());

                          if (nameController.value.text.isEmpty)
                            {
                              showSnackBar("Please enter a name", context);
                            }
                          else if (emailController.value.text.isEmpty)
                            {
                              showSnackBar("Please enter a email address", context);
                            }
                          else if (mobileController.value.text.isEmpty)
                            {
                              showSnackBar("Please enter a mobile number", context);
                            }
                          else if (mobileController.value.text.length != 10)
                            {
                              showSnackBar("Please enter valid mobile number", context);
                            }
                          else if (batchController.value.text.isEmpty)
                            {
                              showSnackBar("Please select batch", context);
                            }
                          else
                            {

                            }
                        },
                        child: isLoading
                            ? const Padding(
                              padding: EdgeInsets.only(top: 10,bottom: 10),
                              child: SizedBox(width: 20,height: 20,child: CircularProgressIndicator(color: white,strokeWidth: 2)),
                            )
                            : const Padding(
                              padding: EdgeInsets.only(top: 10,bottom: 10),
                              child: Text(
                                "Submit",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16, color: white, fontWeight: FontWeight.w400),
                              ),
                            )
                    ),
                  ),

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

  void openBatchBottomSheet(List<BatchList> list) {

    showModalBottomSheet<void>(
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)
          )
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, updateState) {
            return ConstrainedBox(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.88),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(height: 10,),
                    Center(
                      child: Container(
                          height: 2,
                          width: 40,
                          color: black,
                          margin: const EdgeInsets.only(bottom: 12)
                      ),
                    ),
                    Container(height: 8,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text("Select Batch" ,
                              style: TextStyle(fontSize: 16, color:black,fontWeight: FontWeight.w600),textAlign: TextAlign.center),
                        ),
                        Container(height: 12,),
                        ListView.builder(
                          itemCount: list.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: ( context, index, ) {
                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                setState((){
                                  batchId = list[index].id ?? '';
                                  batchName = list[index].name ?? '';
                                  batchController.text = "${list[index].name ?? "" } - ${list[index].formatedDateTime ?? "" }";
                                });
                                Navigator.pop(context);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0, right: 18, top: 8, bottom: 8),
                                    child: Text("${list[index].name ?? "" } (${list[index].timezone}) - Registration Closes on:(${list[index].registrationCloseDate ?? "" })",
                                        style: const TextStyle(fontSize: 14, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.start),
                                  ),
                                  const Divider(
                                    thickness: 0.5,
                                    endIndent: 22,
                                    indent: 22,
                                    color: grayLight,
                                  ),

                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  enrollNow() async {

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(registerUrl);

    Map<String, String> jsonBody = {
      'admin_module_id' : '32',
      'agree_tandc' : '1',
      'agree_tandc_display' : 'true',
      'batch' : batchName,
      'batch_id' : batchId,
      'contact_no' : '91 ${mobileController.value.text}',
      'contact_no_display' : mobileController.value.text,
      'course' : 'Journey of Real Estate',
      'email_address' : emailController.value.text,
      'from_app' : FROM_APP,
      'lead_sub_source' : 'Application',
      'logged_in_master_user_id' : '1',
      'master_user_id' : '1',
      'name' : nameController.value.text,
      'page_id' : '12',
      'payment_amount' : '94400',
      'remarks' : '',
    };

    final response = await http.post(url, body: jsonBody, headers: {
      "Authorization": AuthHeader,
    });

    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = CommonResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == "1")
    {
      showSnackBar(dataResponse.message, context);
    }
    else
    {

      showSnackBar(dataResponse.message, context);
    }
  }

  Future<void> getBatchData() async {
    Map<String, String> jsonBody = {
      'future_data':'1',
      'is_active':'1',
      'limit':'50',
      'order_by':"asc",
      'page':'1',
      'status': "1",
      'from_app': FROM_APP
    };
    BatchViewModel batchViewModel = Provider.of<BatchViewModel>(context,listen: false);
    await batchViewModel.batchData(jsonBody);

    if (batchViewModel.response.success == '1')
    {
      setState(() {
        BatchResponseModel getSet = batchViewModel.response;
        listBatches = getSet.batchList ?? [];
      });
    }
  }

  @override
  void castStatefulWidget() {
    widget is EnrollScreen;
  }
}