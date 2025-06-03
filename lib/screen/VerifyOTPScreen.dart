import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:provider/provider.dart';
import 'package:shivalik_institute/constant/api_end_point.dart';
import 'package:shivalik_institute/model/VerifyOtpResponseModel.dart';
import '../common_widget/common_widget.dart';
import '../constant/colors.dart';
import '../model/GenerateOTPResponseModel.dart';
import '../utils/app_utils.dart';
import '../utils/base_class.dart';
import '../viewmodels/CommonViewModel.dart';
import '../viewmodels/VerifyOtpViewModel.dart';
import 'DashboardScreen.dart';

class VerifyOTPScreen extends StatefulWidget {
  final String? mobileNumber;

  const VerifyOTPScreen({Key? key, this.mobileNumber,}) : super(key: key);

  @override
  BaseState<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends BaseState<VerifyOTPScreen> {

  bool _isLoading = false;
  bool _isLoadingResend = false;
  late Timer _timer;
  int _start = 60;
  bool visibilityResend = false;
  String strPin = "";
  FocusNode inputNode = FocusNode();
  TextEditingController otpController = TextEditingController();

  void startTimer() {
    const oneSec = Duration(milliseconds: 1000);
    _timer = Timer.periodic(
      oneSec, (Timer timer) {
        if (_start == 0) {
          setState(() {
            visibilityResend = true;
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    startTimer();
    Future.delayed(
      const Duration(seconds: 1), () {
            openKeyboard();
      },
    );
    super.initState();
  }

  void openKeyboard(){
    FocusScope.of(context).requestFocus(inputNode);
  }

  @override
  Widget build(BuildContext context) {
    final verifyOtpViewModel = Provider.of<VerifyOtpViewModel>(context);

    final loginViewModel = Provider.of<CommonViewModel>(context);

    return WillPopScope(
        child: Scaffold(
          backgroundColor: appBg,
          appBar: AppBar(
            backgroundColor: appBg,
            elevation: 0,
            titleSpacing: 0,
            centerTitle: false,
            leading: InkWell(
              borderRadius: BorderRadius.circular(52),
              onTap: (){
                Navigator.pop(context,true);
              },
              child: getBackArrow(),
            ),
          ),
          body: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: const Text(
                                  'Enter 4 Digit OTP',
                                  style: TextStyle(fontSize: 22, color: black, fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(bottom: 10, left: 14, top: 14),
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: const TextSpan(
                                    style: TextStyle(fontSize: 16, color: black, fontWeight: FontWeight.w400),
                                    children: [
                                      TextSpan(
                                        text: 'We just sent a OTP to your mobile\nnumber',
                                        style: TextStyle(fontSize: 16, color: black, fontWeight: FontWeight.w400),
                                      ),
                                      // TextSpan(
                                      //   text: " ${(widget as VerifyOTPScreen).getSet.contactNo}",
                                      //   style: const TextStyle(fontSize: 16, color: black, fontWeight: FontWeight.w600),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(top: 4, bottom: 4, left: 34, right: 34),
                                child: PinCodeTextField(
                                  focusNode: inputNode,
                                  autoDisposeControllers: false,
                                  controller: otpController,
                                  appContext: context,
                                  pastedTextStyle: const TextStyle(
                                    color: black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600, color: black),
                                  length: 4,
                                  autoFocus: true,
                                  obscureText: false,
                                  blinkWhenObscuring: true,
                                  autoDismissKeyboard: true,
                                  animationType: AnimationType.fade,
                                  pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.circle,
                                    borderWidth: 1,
                                    fieldHeight: 50,
                                    fieldWidth: 50,
                                    activeColor: black,
                                    selectedColor: grayDarkNew,
                                    disabledColor: grayDark,
                                    inactiveColor: grayDark,
                                    activeFillColor: Colors.transparent,
                                    selectedFillColor: Colors.transparent,
                                    inactiveFillColor: Colors.transparent,
                                  ),
                                  cursorColor: black,
                                  animationDuration: const Duration(milliseconds: 300),
                                  enableActiveFill: true,
                                  keyboardType: TextInputType.number,
                                  onCompleted: (v) async {
                                    FocusScope.of(context).unfocus();
                                    setState(() {
                                      strPin = v;
                                    });
                                    if (isOnline) {
                                      FocusScope.of(context).requestFocus(FocusNode());
                                      String contact = otpController.text.toString().trim();
                                      if (contact.isEmpty)
                                      {
                                        showSnackBar("Please enter a OTP", context);
                                      }
                                      else if (contact.length != 4)
                                      {
                                        showSnackBar("Please enter valid OTP", context);
                                      }
                                      else
                                      {
                                        if (isOnline)
                                        {
                                          Map<String, String> jsonBody = {
                                            'contact_no': (widget as VerifyOTPScreen).mobileNumber.toString(),
                                            'otp': otpController.value.text,
                                            'user_id': "",
                                            'from_app' : FROM_APP
                                          };
                                          await verifyOtpViewModel.verifyOTP(jsonBody);
                                          VerifyOtpResponseModel value = verifyOtpViewModel.response;
                                          if (value.success == "1")
                                          {
                                            await sessionManager.createLoginSession(
                                              value.user?.id ?? "",
                                              value.user?.firstName ?? "",
                                              value.user?.lastName ?? "",
                                              value.user?.userType ?? "",
                                              value.user?.accessToken ?? "",
                                              value.user?.profilePic ?? "",
                                              value.user?.isAlumini ?? '',
                                              value.user?.isBatchAdmin ?? ''
                                            );
                                            startActivity(context, const DashboardScreen());
                                          }
                                          else
                                          {
                                            showToast(value.message, context);
                                          }
                                        }
                                        else
                                        {
                                          noInterNet(context);
                                        }
                                      }
                                    } else {
                                      noInterNet(context);
                                    }
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      strPin = value;
                                    });
                                  },
                                  beforeTextPaste: (text) {

                                    return true;
                                  },
                                ),
                              ),
                              !visibilityResend
                                  ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 14,
                                        height: 14,
                                        child: CircularProgressIndicator(color: black,strokeWidth: 3),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.only(bottom: 10, left: 6, top: 14,right: 44),
                                        child: RichText(
                                              text: TextSpan(
                                                style: Theme.of(context).textTheme.bodyMedium,
                                                children: [
                                                  const WidgetSpan(child: Gap(10)),
                                                  const TextSpan(
                                                    text: '  Waiting For OTP... ',
                                                    style:
                                                    TextStyle(fontSize: 14, color: black, fontWeight: FontWeight.w400),
                                                  ),
                                                  const TextSpan(
                                                    text: "00 :",
                                                    style: TextStyle(fontSize: 14, color: black, fontWeight: FontWeight.w600),
                                                  ),
                                                  TextSpan(
                                                    text:_start < 10 ? " 0$_start Second" : " $_start Seconds",
                                                    style: const TextStyle(fontSize: 14, color: black, fontWeight: FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                        ),
                                      ),
                                    ],
                                  )
                                  : GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () async {
                                        FocusScope.of(context).requestFocus(FocusNode());
                                        setState(() {
                                          visibilityResend = false;
                                          _isLoadingResend = false;
                                          _start = 60;
                                        });
                                        startTimer();
                                        if (isOnline)
                                        {

                                        }
                                        else
                                        {
                                          noInterNet(context);
                                        }
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: const Text("Resend OTP",style: TextStyle(fontSize: 16, color: black, fontWeight: FontWeight.w400),),
                                      ),
                                  ),
                              const Spacer(flex: 2),
                              Container(
                                margin: const EdgeInsets.only(top: 12,left: 8, right: 8,bottom: 22),
                                width: double.infinity,
                                child: TextButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(kBorderRadius),
                                          ),
                                        ),
                                        backgroundColor: MaterialStateProperty.all<Color>(strPin.length != 4 ? gray : black)
                                    ),
                                    onPressed: strPin.length != 4 ? null: () async {
                                      FocusScope.of(context).unfocus();
                                      String contact = otpController.text.toString().trim();
                                      if (contact.isEmpty)
                                      {
                                        showSnackBar("Please enter a OTP", context);
                                      }
                                      else if (contact.length != 4)
                                      {
                                        showSnackBar("Please enter valid OTP", context);
                                      }
                                      else
                                      {
                                        if (isOnline)
                                        {
                                          Map<String, String> jsonBody = {
                                            'contact_no': (widget as VerifyOTPScreen).mobileNumber.toString(),
                                            'otp': otpController.value.text,
                                            'user_id': "",
                                            'from_app' : FROM_APP
                                          };
                                          await verifyOtpViewModel.verifyOTP(jsonBody);
                                          VerifyOtpResponseModel value = verifyOtpViewModel.response;
                                          if (value.success == "1")
                                          {
                                            await sessionManager.createLoginSession(
                                              value.user?.id ?? "",
                                              value.user?.firstName ?? "",
                                              value.user?.lastName ?? "",
                                              value.user?.userType ?? "",
                                              value.user?.accessToken ?? "",
                                              value.user?.profilePic ?? "",
                                              value.user?.isAlumini ?? '',
                                              value.user?.isBatchAdmin ?? ''
                                            );
                                            startActivity(context, DashboardScreen());
                                            showToast(value.message, context);
                                          }
                                          else
                                          {
                                            showToast(value.message, context);
                                          }
                                        }
                                        else
                                        {
                                          noInterNet(context);
                                        }
                                      }
                                    },
                                    child: verifyOtpViewModel.isLoading
                                        ? const Padding(
                                          padding: EdgeInsets.only(top: 6,bottom: 6),
                                          child: SizedBox(width: 24,height: 24,child: CircularProgressIndicator(color: white,strokeWidth: 2,)),
                                        )
                                        :  const Padding(
                                            padding: EdgeInsets.only(top: 6,bottom: 6),
                                            child: Text(
                                              "Verify OTP",
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
                  );
                },
              ),
        ),
        onWillPop: (){
          Navigator.pop(context,true);
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
    String contact = (widget as VerifyOTPScreen).mobileNumber ??'';
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
      showToast(dataResponse.message, context);
      setState(() {
        _isLoading = false;
      });
    }
    else if (dataResponse.success == "2")
      {
        showDeviceListBottomSheet();
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
    widget is VerifyOTPScreen;
  }

  void showDeviceListBottomSheet() {}
}