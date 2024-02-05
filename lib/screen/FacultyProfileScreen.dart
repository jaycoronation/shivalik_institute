import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shivalik_institute/common_widget/loading.dart';
import 'package:shivalik_institute/common_widget/no_data_new.dart';
import 'package:shivalik_institute/constant/api_end_point.dart';
import 'package:shivalik_institute/constant/colors.dart';
import 'package:shivalik_institute/model/UserProfileResponseModel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common_widget/common_widget.dart';
import '../utils/base_class.dart';
import '../viewmodels/UserViewModel.dart';
import 'DashboardScreen.dart';

class FacultyProfileScreen extends StatefulWidget {
  final String facultyId;
  const FacultyProfileScreen(this.facultyId, {super.key});

  @override
  BaseState<FacultyProfileScreen> createState() => _FacultyProfileScreenState();
}

class _FacultyProfileScreenState extends BaseState<FacultyProfileScreen> {

  Details getSet = Details();
  String facultyId = '';
  bool isLoading = false;
  bool isNoDataFound = false;

  @override
  void initState(){
    super.initState();
    facultyId = (widget as FacultyProfileScreen).facultyId;
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: appBg,
          leading:  InkWell(
            borderRadius: BorderRadius.circular(52),
            onTap: () {
              if (Navigator.canPop(context))
              {
                Navigator.pop(context);
              }
              else
              {
                startActivityRemove(context, const DashboardScreen());
              }
            },
            child: getBackArrow(),
          ),
          titleSpacing: 0,
          centerTitle: false,
          title: getTitle("Faculty Profile",),
        ),
        body: isLoading
            ? const LoadingWidget()
            : isNoDataFound
            ? const MyNoDataNewWidget(msg: "Faculty Profile not found", img: '')
            : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /*Container(
                    margin: const EdgeInsets.only(top: 12),
                    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(150)), color: grayLight),
                    width: 100,
                    height: 100,
                    child:  ClipOval(
                        child:getSet.profilePic.toString().isEmpty
                            ? Image.asset('assets/images/ic_user_placeholder.png', fit: BoxFit.cover,)
                            : Image.network(getSet.profilePic.toString(), fit: BoxFit.cover)
                    ),
                  ),*/

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(12),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(top: 12),
                          decoration: BoxDecoration(color: grayLight,borderRadius: BorderRadius.circular(8)),
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: getSet.profilePic.toString().isEmpty
                                ? Image.asset('assets/images/ic_user_placeholder.png', fit: BoxFit.cover,)
                                : Image.network("${getSet.profilePic}&h=500&zc=2", fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Gap(22),
                            Text("${getSet.prefixName} ${getSet.firstName} ${getSet.lastName}",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: brandColor),),
                            Visibility(
                              visible: getSet.designation?.isNotEmpty ?? false,
                              child: Container(
                                  margin: const EdgeInsets.only(top: 8),
                                  child: Row(
                                    children: [
                                      Image.asset('assets/images/ic_designation.png',width: 22,height: 22,),
                                      const Gap(8),
                                      Text("${getSet.designation}",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black),),
                                    ],
                                  )
                              ),
                            ),
                            Visibility(
                              visible: getSet.email?.isNotEmpty ?? false,
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  sendEmail(getSet.email ?? '');
                                },
                                child: Container(
                                    margin: const EdgeInsets.only(top: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.asset('assets/images/ic_email.png',width: 22,height: 22,),
                                        const Gap(8),
                                        Expanded(child: Text("${getSet.email}",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black),overflow: TextOverflow.clip,)),
                                      ],
                                    )
                                ),
                              ),
                            ),
                            Visibility(
                                visible: getSet.contactNo?.isNotEmpty ?? false,
                                child: GestureDetector(
                                  onTap: () {
                                    launchPhoneURL(getSet.contactNo ?? '');
                                  },
                                  behavior: HitTestBehavior.opaque,
                                  child: Container(
                                      margin: const EdgeInsets.only(top: 8),
                                      child: Row(
                                        children: [
                                          Image.asset('assets/images/ic_Phone.png',width: 22,height: 22,),
                                          const Gap(8),
                                          Text("${getSet.contactNo}",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black),),
                                        ],
                                      )
                                  ),
                                )
                            ),
                            Visibility(
                                visible: getSet.industrialExperience?.isNotEmpty ?? false,
                                child: Container(
                                    margin: const EdgeInsets.only(top: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.asset('assets/images/ic_experience.png',width: 22,height: 22,),
                                        const Gap(8),
                                        Expanded(child: Text("${getSet.industrialExperience} Years of Industrial Experience",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black),overflow: TextOverflow.clip)),
                                      ],
                                    )
                                )
                            ),
                            Visibility(
                                visible: getSet.highestEducation?.isNotEmpty ?? false,
                                child: Container(
                                    margin: const EdgeInsets.only(top: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.asset('assets/images/ic_education.png',width: 22,height: 22,),
                                        const Gap(8),
                                        Expanded(child: Text("${getSet.highestEducation}",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black),overflow: TextOverflow.clip)),
                                      ],
                                    )
                                )
                            ),
                          ],
                        ),
                      ),
                      const Gap(12),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(22),
                        Container(alignment: Alignment.centerLeft,child: const Text("About",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black),)),
                        const Gap(12),
                        HtmlWidget(getSet.about ?? '',textStyle: const TextStyle(fontWeight: FontWeight.w400,fontSize: 16,color: black)),
                        const Gap(22),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      ),
      onWillPop: (){
        if (Navigator.canPop(context))
          {
            Navigator.pop(context);
          }
        else
          {
            startActivityRemove(context, const DashboardScreen());
          }
        return Future.value(true);
      },
    );
  }

  Future<void> sendEmail(String email) async {
    String mail = "mailto:$email?subject=&body=${Uri.encodeFull("")}";
    if (await canLaunchUrl(Uri.parse(mail)))
    {
      await launchUrl(Uri.parse(mail));
    }
    else
    {
      throw Exception("Unable to open the email");
    }
  }

  void launchPhoneURL(String phoneNumber) async {
    String url = 'tel:$phoneNumber';

    if (await canLaunchUrl(Uri.parse(url)))
    {
      await launchUrl(Uri.parse(url));
    }
    else
    {
      throw 'Could not launch $url';
    }
  }

  Future<void> getUserData() async {
    setState(() {
      isLoading = true;
    });
    Map<String, String> jsonBody = {
      'from_app': FROM_APP,
      "user_id": facultyId
    };

    UserViewModel userViewModel = Provider.of<UserViewModel>(context,listen: false);
    await userViewModel.getUserDetails(jsonBody);

    if (userViewModel.response.success == '1')
    {
      setState(() {
        getSet = userViewModel.response.details ?? Details();
        isLoading = false;
        isNoDataFound = false;
      });

    }
    else
    {
      setState(() {
        isLoading = false;
        isNoDataFound = true;
      });
    }
  }

  @override
  void castStatefulWidget() {
    widget is FacultyProfileScreen;
  }
}