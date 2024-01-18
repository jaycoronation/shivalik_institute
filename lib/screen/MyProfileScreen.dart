import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shivalik_institute/screen/HolidayScreen.dart';
import 'package:shivalik_institute/screen/NotificationListScreen.dart';
import 'package:shivalik_institute/screen/PaymentHistroyScreen.dart';
import 'package:shivalik_institute/utils/pdf_viewer.dart';
import '../common_widget/common_widget.dart';
import '../common_widget/loading.dart';
import '../common_widget/loading_more.dart';
import '../constant/colors.dart';
import '../model/UserProfileResponseModel.dart';
import '../utils/app_utils.dart';
import '../utils/base_class.dart';
import '../utils/session_manager_methods.dart';
import '../viewmodels/UserViewModel.dart';
import 'LoginWithOtpScreen.dart';
import 'ProfileScreen.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  BaseState<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends BaseState<MyProfileScreen> {
  bool _isLoadingMore = false;
  Details getSet = Details();

  @override
  void initState(){
    getUserData();
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
          title: getTitle("My Profile",),
        ),
        body:  Consumer<UserViewModel>(
          builder: (context, value, child) {
            if ((value.isLoading) && (_isLoadingMore == false))
            {
              return const LoadingWidget();
            }
            else
            {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 16,),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        // startActivity(context, ProfileScreen());
                        var value = await Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
                        getUserData();
                      },
                      child: Center(
                          child: Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 12),
                                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(150)), color: grayLight),
                                width: 100,
                                height: 100,
                                child:  ClipOval(
                                    child:getSet.profilePic.toString().isEmpty
                                        ? Image.asset('assets/images/ic_user_placeholder.png', fit: BoxFit.cover,)
                                        : Image.network(getSet.profilePic.toString(), fit: BoxFit.cover)
                                ),
                              ),
                              Positioned(
                                  right: 0,
                                  bottom: 12,
                                  child: Container(
                                      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),
                                        color: grayLight,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Image.asset('assets/images/ic_edit.png', height: 18, width: 18,),
                                      )
                                  )
                              )
                            ],
                          )
                      ),
                    ),
                    Container(height: 32,),
                    Container(
                      margin: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0, right: 18,top: 12,bottom: 12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                Visibility(
                                  visible: getSet.firstName?.isNotEmpty ?? false,
                                  child: Row(
                                    children: [
                                      Image.asset('assets/images/ic_profile.png', width: 26,height: 26,),
                                      Container(width: 12,),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children:  [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                              child: Text("${getSet.firstName} ${getSet.lastName}" ,
                                                  style: const TextStyle(fontSize: 16, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center
                                              ),
                                            ),
                                            const Divider(
                                              thickness: 0.5,
                                              endIndent: 0,
                                              indent: 0,
                                              color: grayLight,
                                            ),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: getSet.email?.isNotEmpty ?? false,
                                  child: Row(
                                    children: [
                                      Image.asset('assets/images/ic_Mail.png', width: 26,height: 26,),
                                      Container(width: 12,),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children:  [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                              child: Text((getSet.email.toString()),
                                                  style: const TextStyle(fontSize: 16, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center
                                              ),
                                            ),
                                            const Divider(
                                              thickness: 0.5,
                                              endIndent: 0,
                                              indent: 0,
                                              color: grayLight,
                                            ),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: getSet.contactNo?.isNotEmpty ?? false,
                                  child: Row(
                                    children: [
                                      Image.asset('assets/images/ic_Phone.png', width: 26,height: 26,),
                                      Container(width: 12,),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children:  [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                              child: Text((getSet.contactNo.toString()),
                                                  style: const TextStyle(fontSize: 16, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center
                                              ),
                                            ),
                                            const Divider(
                                              thickness: 0.5,
                                              endIndent: 0,
                                              indent: 0,
                                              color: grayLight,
                                            ),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: getSet.dateOfBirth?.isNotEmpty ?? false,
                                  child: Row(
                                    children: [
                                      Image.asset('assets/images/ic_birthdate.png', width: 26,height: 26,),
                                      Container(width: 12,),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children:  [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                              child: Text(universalDateConverter("yyyy-MM-dd", "dd MMM, yyyy", getSet.dateOfBirth ?? ""),
                                                  style: const TextStyle(fontSize: 16, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center
                                              ),
                                            ),
                                            const Divider(
                                              thickness: 0.5,
                                              endIndent: 0,
                                              indent: 0,
                                              color: grayLight,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: getSet.courseName?.isNotEmpty ?? false,
                                  child: Row(
                                    children: [
                                      Image.asset('assets/images/ic_course.png', width: 26,height: 26,),
                                      Container(width: 12,),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children:  [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                              child: Text(getSet.courseName.toString(),
                                                  style: const TextStyle(fontSize: 16, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center
                                              ),
                                            ),
                                            const Divider(
                                              thickness: 0.5,
                                              endIndent: 0,
                                              indent: 0,
                                              color: grayLight,
                                            ),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: getSet.batchName?.isNotEmpty ?? false,
                                  child: Row(
                                    children: [
                                      Image.asset('assets/images/ic_batch.png', width: 26,height: 26,),
                                      Container(width: 12,),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children:  [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                              child: Text(getSet.batchName.toString(),
                                                  style: const TextStyle(fontSize: 16, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center
                                              ),
                                            ),
                                            const Divider(
                                              thickness: 0.5,
                                              endIndent: 0,
                                              indent: 0,
                                              color: grayLight,
                                            ),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                const Gap(22),


                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(12),
                      padding: const EdgeInsets.only(left: 18.0, right: 18,top: 12,bottom: 12),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: getSet.invoiceFile?.isNotEmpty ?? false,
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: (){
                                startActivity(context, PdfViewer(getSet.invoiceFile ?? '',"0"));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset('assets/images/ic_download.png', width: 26,height: 26,),
                                    Container(width: 20),
                                    const Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children:  [
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 8.0,),
                                            child: Text(
                                              "Invoice",
                                              style: TextStyle(fontSize: 16, color: black,fontWeight: FontWeight.w400, height: 1.4),
                                            ),
                                          ),
                                          Divider(
                                            thickness: 0.5,
                                            endIndent: 0,
                                            indent: 0,
                                            color: grayLight,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentHistoryScreen()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset('assets/images/ic_payment.png', width: 26,height: 26,),
                                  Container(width: 20),
                                  const Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:  [
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 8.0,),
                                          child: Text("Payment History",
                                            style: TextStyle(fontSize: 16, color: black,fontWeight: FontWeight.w400, height: 1.4),
                                          ),
                                        ),
                                        Divider(
                                          thickness: 0.5,
                                          endIndent: 0,
                                          indent: 0,
                                          color: grayLight,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const HolidayScreen()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset('assets/images/ic_calendar.png', width: 26,height: 26,),
                                  Container(width: 20),
                                  const Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:  [
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 8.0,),
                                          child: Text("Holidays",
                                            style: TextStyle(fontSize: 16, color: black,fontWeight: FontWeight.w400, height: 1.4),
                                          ),
                                        ),
                                        Divider(
                                          thickness: 0.5,
                                          endIndent: 0,
                                          indent: 0,
                                          color: grayLight,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationListScreen()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset('assets/images/ic_notification.png', width: 26,height: 26,),
                                  Container(width: 20),
                                  const Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:  [
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 8.0,),
                                          child: Text("Notifications",
                                            style: TextStyle(fontSize: 16, color: black,fontWeight: FontWeight.w400, height: 1.4),
                                          ),
                                        ),
                                        Divider(
                                          thickness: 0.5,
                                          endIndent: 0,
                                          indent: 0,
                                          color: grayLight,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: (){
                              _logOutDialog();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset('assets/images/ic_logout.png', height: 26, width: 26,),
                                  Container(width: 18),
                                  const Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:  [
                                        Padding(
                                          padding:  EdgeInsets.only(bottom: 8.0,),
                                          child:  Text("Logout",
                                            style: TextStyle(fontSize: 16, color: black,fontWeight: FontWeight.w400, height: 1.4),),
                                        ),
                                        Divider(
                                          thickness: 0.5,
                                          endIndent: 0,
                                          indent: 0,
                                          color: grayLight,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(22)
                  ],
                ),
              );
            }
          },
        ),
      ),
      onWillPop: () {
        Navigator.pop(context, true);
        return Future.value(true);
      },
    );
  }

  _logOutDialog() async {
    bool isLoading = false;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      elevation: 5,
      isDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, updateState) {
            return Wrap(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 16,
                    ),
                    Container(
                        height: 2,
                        width: 40,
                        color: black,
                        margin: const EdgeInsets.only(bottom: 12)
                    ),
                    const Text("Logout",
                      style: TextStyle(
                          fontSize: 18, color: black,fontWeight: FontWeight.w500),textAlign: TextAlign.left,
                    ),
                    Container(
                      height: 10,
                    ),
                    const Text("Are you sure you want to logout from app?",
                        style: TextStyle(
                            color: black,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                        textAlign: TextAlign.center
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(
                                left: 12, right: 12, bottom: 30, top: 18),
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: black,
                                        width: 1,
                                        style: BorderStyle.solid
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                backgroundColor:
                                MaterialStateProperty.all<Color>(black),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(6.0),
                                child: Text(
                                  "No",
                                  style: TextStyle(
                                      color: white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(
                                left: 12, right: 12, bottom: 30, top: 12),
                            child: TextButton(
                              onPressed: () async {
                                SessionManagerMethods.clear();
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginWithOTPScreen()), (Route<dynamic> route) => false);
                              },
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: black,
                                          width: 1,
                                          style: BorderStyle.solid
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all<Color>(black)
                              ),
                              child: isLoading
                                  ? const Padding(
                                padding: EdgeInsets.only(top: 10,bottom: 10),
                                child: SizedBox(width: 20,height: 20,child: CircularProgressIndicator(color: black,strokeWidth: 2)),
                              )
                                  : const Padding(
                                padding: EdgeInsets.all(6.0),
                                child: Text(
                                  "Yes",
                                  style: TextStyle(
                                      color: white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            );
          },
        );
      },
    );
  }

  @override
  void castStatefulWidget() {
    widget is MyProfileScreen;
  }

  Future<void> getUserData() async {
    Map<String, String> jsonBody = {
      'user_id':sessionManager.getUserId() ?? '',
      "user_type":'3'
    };

    UserViewModel userViewModel = Provider.of<UserViewModel>(context,listen: false);
    await userViewModel.getUserDetails(jsonBody);

    if (userViewModel.response.success == '1')
    {
      getSet = userViewModel.response.details ?? Details();
    }
    else
    {

    }

  }

}