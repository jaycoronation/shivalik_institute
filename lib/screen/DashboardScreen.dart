import 'package:countup/countup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shivalik_institute/common_widget/common_widget.dart';
import 'package:shivalik_institute/common_widget/loading.dart';
import 'package:shivalik_institute/common_widget/no_internet.dart';
import 'package:shivalik_institute/screen/CaseStudyScreen.dart';
import 'package:shivalik_institute/screen/EventsScreen.dart';
import 'package:shivalik_institute/screen/HolidayScreen.dart';
import 'package:shivalik_institute/screen/LectureScreen.dart';
import 'package:shivalik_institute/screen/ManagmentScreen.dart';
import 'package:shivalik_institute/screen/ModuleListScreen.dart';
import 'package:shivalik_institute/screen/ResourceCenterScreen.dart';
import 'package:shivalik_institute/screen/TestimonialsScreen.dart';
import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../model/DashboardResponseModel.dart';
import '../model/ModuleResponseModel.dart';
import '../utils/app_utils.dart';
import '../utils/base_class.dart';
import '../viewmodels/DashboardViewModel.dart';
import 'ProfileScreen.dart';
import '../common_widget/no_data_new.dart';

class DashboardScreen extends StatefulWidget {

  @override
  BaseState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends BaseState<DashboardScreen> {

  @override
 void initState() {
    Map<String, String> jsonBody = {
      'student_id': sessionManager.getUserId().toString(),
      'filter': 'upcoming_class',
      'from_app' : FROM_APP
    };
    Provider.of<DashboardViewModel>(context,listen: false).dashboardData(jsonBody);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: appBg,
              statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
              statusBarBrightness: Brightness.light,
            ) ,
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: appBg,
            title: getTitle("Dashboard"),
            actions: [
              InkWell(
                onTap: (){
                  openAllScreenBottomSheet();
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 9,right: 9.0, top: 12, bottom: 12),
                  child: Icon(Icons.add),
                ),
              ),
              InkWell(
                onTap: (){
                  startActivity(context, ProfileScreen());
                  //startActivity(context, CaseStudyScreen());
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 9,right: 9.0, top: 12, bottom: 12),
                  child: Image.asset('assets/images/ic_user_placeholder.png',),
                ),
              ),
            ],
          ),
          body: Consumer<DashboardViewModel>(
            builder: (context, value, child) {
              if (value.isLoading)
                {
                  return const LoadingWidget();
                }
              else
                {
                  if (value.response.success == "1")
                    {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 16, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () async {
                                        startActivity(context, const ModuleListScreen("all"));
                                      },
                                      child: Container(
                                        decoration:  BoxDecoration(
                                          border: Border.all(color: white, width: 0.5),
                                          borderRadius:const BorderRadius.all(Radius.circular(8),) ,
                                          color: white,
                                        ),
                                        width: 120,
                                        height: 120,
                                        margin: const EdgeInsets.only(right: 4, top: 8),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            // Text(getSet.unibharReceived.toString(),
                                            //   style: TextStyle(fontSize: 24, color: blue,fontWeight: FontWeight.w500),),
                                            Countup(
                                              begin: 0,
                                              // end: double.parse(getSet.unibharReceived.toString()),
                                              end: double.parse(value.response.totalModules ?? "0"),
                                              duration: const Duration(seconds: 2),
                                              separator: ',',
                                              style: const TextStyle(
                                                  fontSize: 24, color: black,fontWeight: FontWeight.w500
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.only(top: 8.0, left: 4, right: 4),
                                              child: Text('Total \nModules',
                                                  style: TextStyle(fontSize: 14, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(width: 4,),
                                  Expanded(
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () async {
                                        startActivity(context, const ModuleListScreen("pending"));
                                      },
                                      child: Container(
                                        decoration:  BoxDecoration(
                                          border: Border.all(color: white, width: 0.5),
                                          borderRadius:const BorderRadius.all(Radius.circular(8),) ,
                                          color: white,
                                        ),
                                        width: 120,
                                        height: 120,
                                        margin: const EdgeInsets.only(right: 4, top: 8),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children:  [
                                            // Text(getSet.unibharGiven.toString(),
                                            //   style: const TextStyle(fontSize: 24, color: blue,fontWeight: FontWeight.w500),),
                                            Countup(
                                              begin: 0,
                                              // end: double.parse(getSet.unibharGiven.toString()),
                                              end: double.parse(value.response.pendingModule ?? "0"),
                                              duration: const Duration(seconds: 2),
                                              separator: ',',
                                              style: const TextStyle(
                                                  fontSize: 24, color: black,fontWeight: FontWeight.w500
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.only(top: 8.0, left: 4, right: 4),
                                              child: Text('Pending\n Modules',
                                                  style: TextStyle(fontSize: 14, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(width: 4,),
                                  Expanded(
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () async {
                                        startActivity(context, const ModuleListScreen("completed"));
                                      },
                                      child: Container(
                                        decoration:  BoxDecoration(
                                          border: Border.all(color: white, width: 0.5),
                                          borderRadius:const BorderRadius.all(Radius.circular(8),) ,
                                          color: white,
                                        ),
                                        width: 120,
                                        height: 120,
                                        margin: const EdgeInsets.only(right: 4, top: 8),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            // Text(getSet.unisuchanGiven.toString(),
                                            //   style: const TextStyle(fontSize: 24, color: blue,fontWeight: FontWeight.w500),),
                                            Countup(
                                              begin: 0,
                                              // end: double.parse(getSet.unisuchanGiven.toString()),
                                              end: double.parse(value.response.completedModule ?? "0"),
                                              duration: const Duration(seconds: 2),
                                              separator: ',',
                                              style: const TextStyle(
                                                fontSize: 24, color: black,fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.only(top: 8.0, left: 4, right: 4),
                                              child: Text('Completed Modules',
                                                  style: TextStyle(fontSize: 14, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(height: 20,),
                            Container(
                              padding: const EdgeInsets.only(left: 18, right: 18),
                              alignment: Alignment.centerLeft,
                              child: const Text("Upcoming Events",
                                style: TextStyle(fontSize: 16, color: black,fontWeight: FontWeight.w600),),
                            ),
                            Container(height: 12,),
                            AnimationLimiter(
                              child: ListView.builder(
                                itemCount: value.response.upcomingEvents?.length,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: ( context, index) {
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 600),
                                    child: SlideAnimation(
                                      verticalOffset: 100.0,
                                      child: FadeInAnimation(
                                        child: GestureDetector(
                                          onTap: (){
                                            // Navigator.push(context, MaterialPageRoute(builder: (context) => ThankYouScreen(UniaabharList[index].message.toString())));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(bottom: 18.0, left: 18, right: 18),
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration:  BoxDecoration(
                                                border: Border.all(color: white, width: 0.5),
                                                borderRadius:const BorderRadius.all(Radius.circular(8),) ,
                                                color: white,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Image.network(value.response.upcomingEvents?[index].bannerImage ?? "",
                                                      width : MediaQuery.of(context).size.width,
                                                      height: 200,
                                                      fit: BoxFit.cover,),
                                                     Container(height: 12,),
                                                     Text(value.response.upcomingEvents?[index].title ?? "",
                                                      style: const TextStyle(fontSize: 14, color: black,fontWeight: FontWeight.w500),),
                                                    Container(height: 12,),
                                                    Text(value.response.upcomingEvents?[index].date ?? "",
                                                      style: const TextStyle(fontSize: 12, color: black,fontWeight: FontWeight.w400),),

                                                  ],
                                                ),
                                              ),
                                            ),
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
                      );
                    }
                  else
                    {
                      return const MyNoDataNewWidget(msg: "No Data Found", img: '',);
                      // NO Data
                    }
                }
            },
          ),
        ),
      onWillPop: (){
        SystemNavigator.pop();
        return Future.value(true);
      },
    );
  }

  @override
  void castStatefulWidget() {
    widget is DashboardScreen;
  }

  void openAllScreenBottomSheet() {
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
                  Container(height: 8,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text("Open Screen" ,
                            style: TextStyle(fontSize: 16, color:black,fontWeight: FontWeight.w600),textAlign: TextAlign.center),
                      ),
                      Container(height: 12,),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          startActivity(context, LectureScreen(ModuleList(id: ""), "upcoming_class"));
                        },
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Lectures" ,
                                style: TextStyle(fontSize: 14, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                            Divider(
                              thickness: 0.5,
                              endIndent: 0,
                              indent: 0,
                              color: grayLight,
                            ),
                            Gap(12)
                          ],
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          startActivity(context, const EventsScreen());
                        },
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Events" ,
                                style: TextStyle(fontSize: 14, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                            Divider(
                              thickness: 0.5,
                              endIndent: 0,
                              indent: 0,
                              color: grayLight,
                            ),
                            Gap(12)
                          ],
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          startActivity(context, const ResourceCenterScreen());
                        },
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Resource Center" ,
                                style: TextStyle(fontSize: 14, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                            Divider(
                              thickness: 0.5,
                              endIndent: 0,
                              indent: 0,
                              color: grayLight,
                            ),
                            Gap(12)
                          ],
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          startActivity(context, const HolidayScreen());
                        },
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Holiday" ,
                                style: TextStyle(fontSize: 14, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                            Divider(
                              thickness: 0.5,
                              endIndent: 0,
                              indent: 0,
                              color: grayLight,
                            ),
                            Gap(12)
                          ],
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          startActivity(context, const CaseStudyScreen());
                        },
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Case Study" ,
                                style: TextStyle(fontSize: 14, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                            Divider(
                              thickness: 0.5,
                              endIndent: 0,
                              indent: 0,
                              color: grayLight,
                            ),
                            Gap(12)
                          ],
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          startActivity(context, const TestimonialsScreen());
                        },
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Testimonials" ,
                                style: TextStyle(fontSize: 14, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                            Divider(
                              thickness: 0.5,
                              endIndent: 0,
                              indent: 0,
                              color: grayLight,
                            ),
                            Gap(12)
                          ],
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          startActivity(context, const ManagementScreen());
                        },
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Management" ,
                                style: TextStyle(fontSize: 14, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                            Divider(
                              thickness: 0.5,
                              endIndent: 0,
                              indent: 0,
                              color: grayLight,
                            ),
                            Gap(12)
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

}