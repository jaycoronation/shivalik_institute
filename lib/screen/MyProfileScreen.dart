import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shivalik_institute/common_widget/placeholder.dart';
import 'package:shivalik_institute/screen/HolidayScreen.dart';
import 'package:shivalik_institute/screen/NotificationListScreen.dart';
import 'package:shivalik_institute/screen/PaymentHistroyScreen.dart';
import 'package:shivalik_institute/utils/pdf_viewer.dart';
import '../common_widget/common_widget.dart';
import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../model/UpdateDeviceTokenModel.dart';
import '../model/UserProfileResponseModel.dart';
import '../utils/app_utils.dart';
import '../utils/base_class.dart';
import '../utils/session_manager_methods.dart';
import '../viewmodels/UserViewModel.dart';
import 'LoginWithOtpScreen.dart';
import 'ProfileScreen.dart';
import 'package:to_do_package_shivalik/screens/todo_list_screen.dart';


class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  BaseState<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends BaseState<MyProfileScreen> {
  bool _isLoadingMore = false;
  Details getSet = Details();

  late PackageInfo packageInfo;
  String version = '';
  String buildNumber = '';
  String appName = '';
  String packageName = '';


  @override
  void initState(){
    getAppVersion();
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
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade100 ,
                highlightColor: Colors.grey.shade400,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 12),
                          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(150)), color: grayLight),
                          width: 100,
                          height: 100,
                          child:  ClipOval(
                              child:Image.asset('assets/images/ic_user_placeholder.png', fit: BoxFit.cover,)
                          ),
                        ),
                      ),
                      Container(height: 38,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LargeContainerPlaceholder(width: MediaQuery.of(context).size.width),
                      ),
                      Container(height: 12,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LargeContainerPlaceholder(width: MediaQuery.of(context).size.width),
                      )
                    ],
                  ),
                ),
              );
            }
            else
            {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
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
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(150),),
                                        color: grayLight,
                                      border: Border.all(color: grayLight,width: 0.5)
                                    ),
                                    width: 100,
                                    height: 100,
                                    child:  ClipOval(
                                        child: getSet.profilePic.toString().isEmpty
                                            ? Image.asset('assets/images/ic_user_placeholder.png', fit: BoxFit.cover,)
                                            : Image.network(getSet.profilePic.toString(), fit: BoxFit.cover)
                                    ),
                                  ),
                                  Visibility(
                                    visible: false,
                                    child: Positioned(
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
                                    ),
                                  )
                                ],
                              )
                          ),
                        ),
                        Container(height: 22,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Spacer(),
                                const Gap(34),
                                Text(
                                  "${getSet.firstName ?? ''} ${getSet.lastName ?? ''}",
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(fontWeight: FontWeight.w500, color: black, fontSize: 22, fontFamily: 'Colfax'),
                                ),
                                const Gap(12),
                                InkWell(
                                  customBorder: const CircleBorder(),
                                  onTap: () async {
                                    var value = await Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
                                    getUserData();
                                  },
                                  child: Container(
                                    width: 34,
                                    height: 34,
                                    decoration: const BoxDecoration(color: grayButton, shape: BoxShape.circle),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Image.asset('assets/images/ic_edit_pencil.png', width: 28, height: 28, color: black),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                            const Gap(6),
                            Container(
                              decoration: BoxDecoration(color: grayNew, borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.fromLTRB(9, 6, 9, 6),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    getSet.batchName ?? "",
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(fontWeight: FontWeight.w400, color: black, fontSize: 14, fontFamily: 'Colfax'),
                                  ),
                                  const Gap(6),
                                  Image.asset(
                                    'assets/images/ic_arrow_right.png',
                                    width: 8,
                                    height: 8,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: false,
                          child: Container(
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
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Image.asset('assets/images/ic_profile.png', width: 22,height: 22,),
                                            Container(width: 12,),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children:  [
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                                                    child: Text("${getSet.firstName} ${getSet.lastName}",
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
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Image.asset('assets/images/ic_Mail.png', width: 22,height: 22,),
                                            Container(width: 12,),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children:  [
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                                                    child: Text(getSet.email ?? "",
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
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Image.asset('assets/images/ic_Phone.png', width: 22,height: 22,),
                                            Container(width: 12,),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children:  [
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                                                    child: Text((getSet.contactNo ?? ""),
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
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Image.asset('assets/images/ic_birthdate.png', width: 22,height: 22,),
                                            Container(width: 12,),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children:  [
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
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
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Image.asset('assets/images/ic_course.png', width: 22,height: 22,),
                                            Container(width: 12,),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children:  [
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                                                    child: Text(getSet.courseName ?? "",
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
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Image.asset('assets/images/ic_batch.png', width: 22,height: 22,),
                                            Container(width: 12,),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children:  [
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                                                    child: Text(getSet.batchName ?? "",
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
                                      const Gap(12),


                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(height: 22,),
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
                                    logFirebase("invoice_profile", {});
                                    startActivity(context, PdfViewer(getSet.invoiceFile ?? '',"0","Payment_Invoice.pdf"));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.asset('assets/images/ic_download.png', width: 22,height: 22,),
                                        Container(width: 12),
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
                                  logFirebase("payment_history_profile", {});
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentHistoryScreen()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.asset('assets/images/ic_payment.png', width: 22,height: 22,),
                                      Container(width: 12),
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
                                  logFirebase("holidays_profile", {});
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HolidayScreen()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.asset('assets/images/ic_calendar.png', width: 22,height: 22,),
                                      Container(width: 12),
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
                                  logFirebase("notifications_profile", {});
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationListScreen()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.asset('assets/images/ic_notification.png', width: 22,height: 22,),
                                      Container(width: 12),
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
                              Visibility(
                                visible: sessionManager.getIsBatchAdmin() == "1",
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: (){
                                    logFirebase("Tasks", {});
                                    // Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationListScreen()));
                                    // startActivity(context, ToDoListScreen(sessionManager.getToken() ?? "", sessionManager.getRoleId() ?? "", sessionManager.getUserId() ?? "",  "${sessionManager.getName() ?? ""} ${sessionManager.getLastName() ?? ""}", sessionManager.getProfilePic() ?? ""));

                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                        ToDoListScreen(
                                            // sessionManager.getaccessToken()?? "",
                                            AuthHeader,
                                            sessionManager.getUserId() ?? "",
                                            sessionManager.getUserId() ?? "",
                                            "${sessionManager.getName() ?? ""} ${sessionManager.getLastName() ?? ""}",
                                            sessionManager.getProfilePic() ?? ""
                                        )
                                    ));

                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.asset('assets/images/ic_followUp.png', width: 22,height: 22,),
                                        Container(width: 12),
                                         const Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children:  [
                                              Padding(
                                                padding: EdgeInsets.only(bottom: 8.0,),
                                                child: Text("Follow-up",
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
                                  _logOutDialog();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.asset('assets/images/ic_logout.png', width: 22,height: 22,),
                                      Container(width: 12),
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
                              const Gap(12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("App Version : $version",style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: brandColor),),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const Gap(22),
                      ],
                    ),

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
                                forceLogout();
                                Navigator.pop(context);
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

  forceLogout() async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(removeDeviceToken);


    Map<String, String> jsonBody = {};
    jsonBody = {
      'device_token': sessionManager.getDeviceToken().toString(),
    };

    final response = await http.post(url, body: jsonBody);

    SessionManagerMethods.clear();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginWithOTPScreen()), (Route<dynamic> route) => false);
    showSnackBar("Please login again to continue", context);

    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> apiResponse = jsonDecode(body);
    var dataResponse = UpdateDeviceTokenModel.fromJson(apiResponse);

    if (statusCode == 200 && dataResponse.success == 1)
    {
    }
    else
    {

    }
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

  Future<void> getAppVersion() async {
    packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo.appName;
    packageName = packageInfo.packageName;
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
  }

}