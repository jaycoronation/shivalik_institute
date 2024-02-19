import 'dart:convert';
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:provider/provider.dart';
import 'package:shivalik_institute/constant/api_end_point.dart';
import 'package:shivalik_institute/model/CommonResponseModel.dart';
import 'package:shivalik_institute/model/GenerateOTPResponseModel.dart';
import 'package:shivalik_institute/screen/EnrollScreen.dart';
import 'package:shivalik_institute/viewmodels/CommonViewModel.dart';
import '../common_widget/common_widget.dart';
import '../constant/colors.dart';
import '../model/UpdateDeviceTokenModel.dart';
import '../utils/app_utils.dart';
import '../utils/base_class.dart';
import '../utils/session_manager_methods.dart';
import 'VerifyOTPScreen.dart';
import 'WebViewContainer.dart';

class LoginWithOTPScreen extends StatefulWidget {
  const LoginWithOTPScreen({super.key});

  @override
  BaseState<LoginWithOTPScreen> createState() => _LoginWithOTPScreenState();
}

class _LoginWithOTPScreenState extends BaseState<LoginWithOTPScreen> {
  bool _isLoading = false;
  String selectedUser = "Channel Partner";
  final TextEditingController _mobileCotroller = TextEditingController();
  FocusNode inputNode = FocusNode();

  List<Devices> listDevices = [];

  void openKeyboard(){
    FocusScope.of(context).requestFocus(inputNode);
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: grayLight,
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      statusBarBrightness: Brightness.dark,
    ));

    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
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
                          margin: const EdgeInsets.only(left: 8, right: 8,top: 80),
                          child: TextField(
                            cursorColor: black,
                            controller: _mobileCotroller,
                            focusNode: inputNode,
                            autofocus:true,
                            maxLength: 10,
                            keyboardType: TextInputType.number,
                            style: getTextFiledStyle(),
                            decoration: InputDecoration(
                              hintText: 'Mobile Number',
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
                                String contact = _mobileCotroller.text.toString().trim();
                                if (contact.isEmpty)
                                {
                                  showSnackBar("Please enter a mobile number", context);
                                }
                                else if (contact.length != 10)
                                {
                                  showSnackBar("Please enter valid mobile number", context);
                                }
                                else
                                {
                                  if (isOnline)
                                  {
                                    sendOTP();

                                  }
                                  else
                                  {
                                    noInterNet(context);
                                  }
                                }
                              },
                              child: _isLoading
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
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(bottom: 22, left: 14, top: 25),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: const TextStyle(fontSize: 14, color: black, fontWeight: FontWeight.w400),
                              children: [
                                const TextSpan(
                                  text: 'By clicking above you agree to\n',
                                  style: TextStyle(fontSize: 14, color: grayDark, fontWeight: FontWeight.w400),
                                ),
                                TextSpan(
                                  text: "Terms & Conditions",
                                  style: TextStyle(fontSize: 14, color: black, fontWeight: FontWeight.w500),
                                    recognizer: TapGestureRecognizer()..onTap = () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => const WebViewContainer('https://www.shivalik.institute/terms-conditions/', 'Terms & Conditions', '0')));
                                    }
                                ),
                                const TextSpan(
                                  text: ' and ',
                                  style: TextStyle(fontSize: 14, color: grayDark, fontWeight: FontWeight.w400),
                                ),
                                TextSpan(
                                  text: "Privacy Policy",
                                  style: const TextStyle(fontSize: 14, color: black, fontWeight: FontWeight.w500),
                                    recognizer: TapGestureRecognizer()..onTap = () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => const WebViewContainer('https://www.shivalik.institute/privacy-policy/', 'Privacy Policy', '0')));
                                    }
                                ),
                                const TextSpan(
                                  text: ' of Shivalik Institute of Real Estate.',
                                  style: TextStyle(fontSize: 14, color: grayDark, fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          startActivity(context, const EnrollScreen());
                        },
                        child: const Text.rich(
                          TextSpan(
                            style: TextStyle(fontWeight: FontWeight.w400, color: black, fontSize: 16),
                            children: <TextSpan>[
                              TextSpan(text: "Not yet enrolled?", style: TextStyle(fontWeight: FontWeight.w400, color: black, fontSize: 14)),
                              TextSpan(text: ' Enroll Now', style: TextStyle(fontWeight: FontWeight.w500, color: brandColor, fontSize: 14)),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const Gap(12)
                  ],
                )
              ],
            ),
          ),
        ),
        onWillPop: (){
          SystemNavigator.pop();
          return Future.value(true);
        }
    );
  }

  sendOTP() async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(generateOTPUrl);
    String contact = _mobileCotroller.text.toString().trim();
    Map<String, String> jsonBody = {
      'contact_no': contact,
      'country_code': "+91",
      'email': "",
      'mobile_no' : contact,
      'password' : "",
      "from_app" : FROM_APP
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> apiResponse = jsonDecode(body);
    var dataResponse = GenerateOtpResponseModel.fromJson(apiResponse);
    if (statusCode == 200 && dataResponse.success == "1")
    {
      startActivity(context, VerifyOTPScreen(mobileNumber: contact));
      showToast(dataResponse.message, context);
      setState(() {
        _isLoading = false;
      });
    }
    else if (dataResponse.success == "2")
      {
        listDevices = dataResponse.devices ?? [];
        openDeviceListBottoSheet();
        setState(() {
          _isLoading = false;
        });
      }
    else
    {
      setState(() {
        _isLoading = false;
      });
      showToast(dataResponse.message, context);
    }
  }

  @override
  void castStatefulWidget() {
    widget is LoginWithOTPScreen;
  }

  void openDeviceListBottoSheet() {

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)
          )
      ),
      elevation: 5,
      isDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, updateState) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                children: [
                  Container(height: 8,),
                  Center(
                    child: Container(
                        height: 2,
                        width: 40,
                        color: black,
                        margin: const EdgeInsets.only(bottom: 12)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Logout from another device",
                          style: TextStyle(
                              fontSize: 18, color: black,fontWeight: FontWeight.w500),textAlign: TextAlign.left,
                        ),
                        Container(
                          height: 10,
                        ),
                        const Text("Please logout from another device to login here",
                            style: TextStyle(
                                color: black,
                                fontWeight: FontWeight.normal,
                                fontSize: 14),
                            textAlign: TextAlign.center
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: listDevices.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(top: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 40,
                                      decoration: const BoxDecoration(
                                        color: grayNew,
                                        shape: BoxShape.circle
                                      ),
                                      padding: const EdgeInsets.all(8),
                                      child: Image.asset('assets/images/ic_device.png',height: 22,width: 22),
                                    ),
                                    const Gap(12),
                                    Expanded(
                                        child: Text(listDevices[index].deviceName ?? 'Device ${index + 1}',style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w500),)
                                    ),
                                    GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        forceLogout(index);
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: black,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                                        child: const Text("Logout",style: TextStyle(color: white,fontWeight: FontWeight.w600,fontSize: 16)),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );

  }

  forceLogout(int index) async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(updateDeviceToken);

    var deviceType = "";
    if (Platform.isIOS)
    {
      deviceType = "IOS";
    }
    else
    {
      deviceType = "Android";
    }

    Map<String, String> jsonBody = {};
    jsonBody = {
      'user_id': listDevices[index].userId ?? '',
      'device_token': listDevices[index].deviceToken ?? '',
      'device_type': listDevices[index].deviceType ?? '',
      'is_logout': '1',
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> apiResponse = jsonDecode(body);
    var dataResponse = UpdateDeviceTokenModel.fromJson(apiResponse);

    if (statusCode == 200 && dataResponse.success == 1)
    {
      if (listDevices.length > 2)
        {
          listDevices.removeAt(index);
          showToast("Please login again", context);
        }
      else
        {
          sendOTP();
        }
    }
    else
    {

    }
  }

}