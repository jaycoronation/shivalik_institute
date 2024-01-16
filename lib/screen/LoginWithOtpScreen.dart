import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shivalik_institute/constant/api_end_point.dart';
import 'package:shivalik_institute/model/CommonResponseModel.dart';
import 'package:shivalik_institute/screen/EnrollScreen.dart';
import 'package:shivalik_institute/viewmodels/CommonViewModel.dart';
import '../common_widget/common_widget.dart';
import '../constant/colors.dart';
import '../utils/app_utils.dart';
import '../utils/base_class.dart';
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

  @override
  void initState() {
    //FocusScope.of(context).unfocus();
    super.initState();
  }

  void openKeyboard(){
    FocusScope.of(context).requestFocus(inputNode);
  }

  @override
  Widget build(BuildContext context) {

    final loginViewModel = Provider.of<CommonViewModel>(context);

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

                                    Map<String, String> jsonBody = {
                                      'contact_no': contact,
                                      'country_code': "+91",
                                      'email': "",
                                      'mobile_no' : contact,
                                      'password' : "",
                                      "from_app" : FROM_APP
                                    };
                                    await loginViewModel.generateOTP(jsonBody);
                                    CommonResponseModel value = loginViewModel.response;
                                    if (value.success == "1")
                                      {
                                        startActivity(context, VerifyOTPScreen(mobileNumber: contact));
                                        showToast(value.message, context);
                                      }
                                    else if (value.success == "0")
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
                              child: loginViewModel.isLoading
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
                                const TextSpan(
                                  text: "Terms & Conditions",
                                  style: TextStyle(fontSize: 14, color: black, fontWeight: FontWeight.w500),
                                  // recognizer: TapGestureRecognizer()..onTap = () => launchCustomTab(context, TermsPolicy),
                                ),
                                const TextSpan(
                                  text: ' and ',
                                  style: TextStyle(fontSize: 14, color: grayDark, fontWeight: FontWeight.w400),
                                ),
                                TextSpan(
                                  text: "Privacy Policy",
                                  style: const TextStyle(fontSize: 14, color: black, fontWeight: FontWeight.w500),
                                  // recognizer: TapGestureRecognizer()..onTap = () => launchCustomTab(context, privacyPolicy),
                                    recognizer: TapGestureRecognizer()..onTap = () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => const WebViewContainer('https://www.shivalik.institute/privacy_policy/', 'Privacy Policy')));
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

  @override
  void castStatefulWidget() {
    widget is LoginWithOTPScreen;
  }


}