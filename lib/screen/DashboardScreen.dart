import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:countup/countup.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:provider/provider.dart';
import 'package:shivalik_institute/common_widget/common_widget.dart';
import 'package:shivalik_institute/common_widget/loading.dart';
import 'package:shivalik_institute/model/CommonResponseModel.dart';
import 'package:shivalik_institute/screen/CaseStudyScreen.dart';
import 'package:shivalik_institute/screen/EventsScreen.dart';
import 'package:shivalik_institute/screen/HolidayScreen.dart';
import 'package:shivalik_institute/screen/LectureDetailsScreen.dart';
import 'package:shivalik_institute/screen/LectureScreen.dart';
import 'package:shivalik_institute/screen/ManagmentScreen.dart';
import 'package:shivalik_institute/screen/ModuleListScreen.dart';
import 'package:shivalik_institute/screen/NotificationListScreen.dart';
import 'package:shivalik_institute/screen/ResourceCenterScreen.dart';
import 'package:shivalik_institute/screen/TestimonialsScreen.dart';
import 'package:shivalik_institute/utils/app_utils.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common_widget/VideoProjectWidget.dart';
import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../constant/global_context.dart';
import '../model/BlogListResponseModel.dart';
import '../model/CalendarEventModel.dart';
import '../model/CaseStudyResponseModel.dart';
import '../model/DashboardResponseModel.dart';
import '../model/EventResponseModel.dart';
import '../model/LecturesResponseModel.dart';
import '../model/ModuleResponseModel.dart';
import '../model/TestimonialResponseModel.dart';
import '../model/UpdateDeviceTokenModel.dart';
import '../utils/base_class.dart';
import '../utils/session_manager_methods.dart';
import '../viewmodels/CaseStudyViewModel.dart';
import '../viewmodels/DashboardViewModel.dart';
import '../viewmodels/ModuleViewModel.dart';
import '../viewmodels/TestimonialsViewModel.dart';
import '../viewmodels/UserViewModel.dart';
import 'BlogDetailsScreen.dart';
import 'BlogListScreen.dart';
import 'CaseStudyDetailScreen.dart';
import 'EventDetailsScreen.dart';
import 'LoginWithOtpScreen.dart';
import 'MyProfileScreen.dart';
import '../common_widget/no_data_new.dart';
import 'ResourceCenterClassScreen.dart';
import '../model/UserProfileResponseModel.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  BaseState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends BaseState<DashboardScreen> {
  int _pageIndex = 1;
  final int _pageResult = 10;
  bool _isLastPage = false;
  bool isSubmision = false;
  String selectedFaculty = '';
  String selectedFacultyId = '';
  bool _isLoadingMore = false;
  String fromDateApi = "";
  String toDateApi = "";
  String selectedDateFilter = "Today";
  ModuleList moduleGetSet = ModuleList();
  List<ModuleList> listModule = [];
  List<ModuleList> listSubmission = [];
  List<ModuleList> listMaterial = [];
  List<EventList> listEvent = [];
  List<CaseStudyList> listCaseStudy = [];
  List<LectureList> listLecture = [];
  List<TestimonialsList> listTestimonials = [];
  List<MediaList> mediaList = [];

  Details getSet = Details();
  List<HolidaysList> listUpcomingHolidays = [];
  List<UpcomingClasses> listUpcomingLectures = [];
  List<DecorationItem> listCalenderEvents = [];
  List<CalendarEventModel> listCalenderData = [];
  final CalendarWeekController calendarController = CalendarWeekController();

  PageController? testimonialController = PageController(initialPage: 0,viewportFraction: 0.60);

  ValueNotifier<double> valueNotifier = ValueNotifier(0.0);

  List<BlogList> listBlog = [];

  @override
 void initState() {
    getTestimonialsList(true);
    getUserData();
    getModuleData();
    getCaseStudyList(true);
    getDashboardData();
    getDeviceToken();
    getBlogList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PageController? controller = PageController(initialPage: 0);

    return WillPopScope(
        child: Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: appBg,
              statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
              statusBarBrightness: Brightness.light,
            ) ,
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: appBg,
            centerTitle: false,
            leading: InkWell(
              onTap: () async {
                var value = await Navigator.push(context, MaterialPageRoute(builder: (context) => const MyProfileScreen()));
                getUserData();
              },
              customBorder: const CircleBorder(),
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: grayNew,width: 1)
                ),
                clipBehavior: Clip.antiAlias,
                margin: const EdgeInsets.only(left: 8),
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: getSet.profilePic?.isEmpty ?? true
                      ? Image.asset(
                        'assets/images/ic_user_placeholder.png',
                        height: 42,
                        width: 42,
                        fit: BoxFit.cover,
                      )
                      : Image.network(
                        getSet.profilePic ?? '',
                        height: 42,
                        width: 42,
                        fit: BoxFit.cover,
                      ),
                ),
              ),
            ),
            title: Image.asset('assets/images/ic_logo_name.png',height: 60,width: 150,fit: BoxFit.contain),
            actions: [
              InkWell(
                onTap: (){
                  startActivity(context, const NotificationListScreen());
                },
                customBorder: const CircleBorder(),
                child: Container(
                  padding: const EdgeInsets.all(4),
                    height: 34,
                    width: 34,
                    child: Image.asset('assets/images/ic_notification.png',color: black,width: 26,height: 26)
                ),
              ),
              const Gap(12)
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Visibility(
                            visible: false,
                            child: Container(
                              height: 50,
                              margin: const EdgeInsets.only(left: 12),
                              child: ListView.builder(
                                shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: listCalenderData.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: const EdgeInsets.only(right: 12),
                                      decoration: BoxDecoration(
                                        color: redbg,
                                        borderRadius: BorderRadius.circular(4)
                                      ),
                                      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                      child: Text(listCalenderData[index].title ?? '',style: const TextStyle(color: white,fontSize: 14,fontWeight: FontWeight.w500),)
                                    );
                                  },
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 110 ,
                            child: CalendarWeek(
                              controller: calendarController,
                              height: 110,
                              showMonth: true,
                              minDate: DateTime.now(),
                              maxDate: DateTime.now().add(
                                const Duration(days: 365),
                              ),
                              onDatePressed: (DateTime datetime) {
                                // Do something

                                DateTime selectedDate = DateTime.now();

                                for(int i=0;i<listCalenderEvents.length;i++)
                                  {
                                    if(DateFormat('yyyy-MM-dd').format(listCalenderEvents[i].date ?? DateTime.now()) == DateFormat('yyyy-MM-dd').format(datetime))
                                      {
                                        selectedDate = listCalenderEvents[i].date ?? DateTime.now();
                                      }
                                  }

                                for (var i=0; i < listUpcomingLectures.length; i++)
                                  {
                                    if (DateFormat('dd-MM-yyyy').format(datetime) == listUpcomingLectures[i].date.toString())
                                      {
                                        _eventDialog(listUpcomingLectures[i].date ?? '', listUpcomingLectures[i].moduleDetails?.name ?? '',"Upcoming Lecture");
                                      }
                                  }

                                for (var i=0; i < listUpcomingHolidays.length; i++)
                                  {
                                    if (DateFormat('dd-MM-yyyy').format(datetime) == listUpcomingHolidays[i].holidayDate.toString())
                                      {
                                        _eventDialog(listUpcomingHolidays[i].holidayDate ?? '', listUpcomingHolidays[i].title?? '',"Holiday");
                                      }
                                  }

                              },
                              onDateLongPressed: (DateTime datetime) {},
                              onWeekChanged: () {},
                              todayBackgroundColor: Colors.transparent,
                              todayDateStyle: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400),
                              pressedDateStyle: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400),
                              dateStyle: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400),
                              dayOfWeekStyle: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400),
                              weekendsStyle: const TextStyle(color: Colors.red,fontSize: 14,fontWeight: FontWeight.w400),
                              marginMonth: const EdgeInsets.symmetric(vertical: 12,horizontal: 18),
                              monthViewBuilder: (DateTime time) => Align(
                                alignment: FractionalOffset.centerLeft,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 4,horizontal: 12),
                                  child: Text(
                                    DateFormat.yMMMM().format(time),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: black, fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ),
                              ),
                              decorations: listCalenderEvents,

                            ),
                          ),
                          Visibility(
                            visible: value.response.upcomingClasses?.isNotEmpty ?? false,
                            child: Container(
                              margin: const EdgeInsets.only(top: 26),
                              padding: const EdgeInsets.only(top: 12,bottom: 12),
                              color: lightPink,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(left: 18, right: 18),
                                        alignment: Alignment.centerLeft,
                                        child: const Text("Upcoming Lecture",
                                          style: TextStyle(fontSize: 16, color: black,fontWeight: FontWeight.w800),),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(left: 18, right: 18),
                                        child: GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => LectureScreen(ModuleList(id: ""), "all")));
                                          },
                                          child: const Text("View All",
                                            style: TextStyle(fontSize: 14, color: black,fontWeight: FontWeight.w400),),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(height: 16,),
                                  SizedBox(
                                    height: 170,
                                    child: PageView.builder(
                                      itemCount: value.response.upcomingClasses?.length,
                                      scrollDirection: Axis.horizontal,
                                      controller: controller,
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: ( context, index) {
                                        var getSet =  value.response.upcomingClasses?[index];
                                        return GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () {
                                            startActivity(context, LectureDetailsScreen(getSet?.id ?? ''));
                                          },
                                          child: Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(left: 12,right: 22),
                                                padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                                decoration: BoxDecoration(
                                                  color: white,
                                                  border: Border.all(
                                                      color: lightPinkBorder,
                                                      width: 1
                                                  ),
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(getSet?.moduleDetails?.name ?? '',style: const TextStyle(color: black,fontSize: 16,fontWeight: FontWeight.w600),),
                                                    const Gap(8),
                                                    Text(getSet?.classNoFormat ?? "",style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w500),),
                                                    const Gap(8),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        const Text("By ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                                        const Text(" : ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                                        Text(getSet?.session2FacultyName?.isNotEmpty ?? false ? "${getSet?.session1FacultyName} and ${getSet?.session2FacultyName}" : getSet?.session1FacultyName ?? "",
                                                          style: const TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),
                                                        ),
                                                      ],
                                                    ),
                                                    const Gap(12),
                                                    Text(getSet?.session2Topic?.isNotEmpty ?? false ? "${getSet?.session1Topic} , ${getSet?.session2Topic}" : getSet?.session1Topic ?? "",
                                                      style: const TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400,overflow: TextOverflow.ellipsis),
                                                      maxLines: 1,
                                                    ),
                                                    const Gap(12),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              Image.asset('assets/images/ic_calender.png', width: 22,height: 22,),
                                                              Container(width: 10,),
                                                              Text(universalDateConverter("dd-MM-yyyy", "dd MMM, yyyy", getSet?.date ?? ''),style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400),),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              Image.asset('assets/images/ic_clock.png', width: 22,height: 22,),
                                                              Container(width: 10,),
                                                              Text("${getSet?.startTime} onwards",style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400),),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Visibility(
                                                visible: false,
                                                child: Container(
                                                  margin: const EdgeInsets.only(right: 8,top: 8),
                                                  child: Stack(
                                                    alignment: Alignment.topCenter,
                                                    children: [
                                                      Image.asset('assets/images/ic_class_tag.png',width: 130,height: 50,),
                                                      Container(
                                                        margin: const EdgeInsets.only(top: 10),
                                                          child: Text(getSet?.classNoFormat ?? "",style: const TextStyle(color: lightPinkText,fontSize: 14,fontWeight: FontWeight.w400),)
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Visibility(
                                    visible: value.response.upcomingClasses!.length > 1,
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      margin: const EdgeInsets.only(top: 18),
                                      child: SmoothPageIndicator(
                                        controller: controller,
                                        count: value.response.upcomingClasses?.length ?? 0,
                                        effect:  const ExpandingDotsEffect(
                                          dotHeight: 7,
                                          dotWidth: 7,
                                          activeDotColor: black,
                                          dotColor: grayLight,
                                          // strokeWidth: 5,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Bounceable(
                            duration: const Duration(milliseconds: 200),
                            onTap: () {
                              startActivity(context, const  ModuleListScreen("all"));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 22,bottom: 22),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Gap(22),
                                  Center(
                                    child: SimpleCircularProgressBar(
                                      size: 170,
                                      onGetText: (p0) {
                                        return Text(
                                          "${p0.toStringAsFixed(0)} / ${value.response.totalModules ?? "0"}\n Modules",
                                          style: const TextStyle(fontSize: 18,color: black,fontWeight: FontWeight.w500),
                                          textAlign: TextAlign.center,
                                        );
                                      },
                                      backStrokeWidth: 22,
                                      valueNotifier: valueNotifier,
                                      progressColors: [brandColor,brandColor.withOpacity(0.6)],
                                      backColor: grayNew,
                                      mergeMode: true,
                                      maxValue: double.parse(value.response.totalModules ?? "0"),
                                    ),
                                  ),
                                  const Gap(22),
                                ],
                              ),
                            ),
                          ),
                         /* Container(
                            padding: const EdgeInsets.only(left: 18, right: 18, top: 18),
                            alignment: Alignment.centerLeft,
                            child: const Text("Course Progress",
                              style: TextStyle(fontSize: 16, color: black,fontWeight: FontWeight.w800),),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () async {
                              startActivity(context, const ModuleListScreen("all"));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(22),
                              margin: const EdgeInsets.all(18),
                              decoration:  BoxDecoration(
                                border: Border.all(color: white, width: 0.5),
                                borderRadius:const BorderRadius.all(Radius.circular(8),) ,
                                color: white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 0.7,
                                    blurRadius: 0.5,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SizedBox(
                                        height: 90,width: 90,
                                        child: CircularProgressIndicator(
                                          value: double.parse(value.response.completedModule ?? "0") / double.parse(value.response.totalModules ?? "0"),
                                          color: Colors.green,
                                          strokeWidth: 10,
                                          backgroundColor: progress,
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Countup(
                                            begin: 0,
                                            end: double.parse(value.response.completedModule ?? "0"),
                                            duration: const Duration(seconds: 2),
                                            separator: ',',
                                            style: const TextStyle(
                                              fontSize: 18, color: black
                                              ,fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const Text(' of ',
                                              style: TextStyle(fontSize: 18, color:black,fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.center
                                          ),
                                          Countup(
                                            begin: 0,
                                            end: double.parse(value.response.totalModules ?? "0"),
                                            duration: const Duration(seconds: 2),
                                            separator: ',',
                                            style: const TextStyle(
                                                fontSize: 18, color: black,fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(width: 28,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${value.response.completedModule ?? "0"} modules completed", style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w500)),
                                      Container(height: 4,),
                                      Text("Modules ${int.parse(value.response.completedModule ?? "0") + 1} ongoing", style: const TextStyle(color: grayDark,fontSize: 14,fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),*/



                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Visibility(
                                visible: listMaterial.isNotEmpty,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    startActivity(context, const ResourceCenterScreen(false));
                                  },
                                  child: Card(
                                    margin: const EdgeInsets.only(left: 18, right: 18),
                                    elevation: 2,
                                    color: white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                                      child: Row(
                                        children: [
                                          Image.asset("assets/images/ic_resource.png",width: 22,height: 22,),
                                          const Gap(12),
                                          const Text("Resource Center",
                                            style: TextStyle(fontSize: 16, color: black,fontWeight: FontWeight.w500),),
                                          const Spacer(),
                                          Image.asset("assets/images/ic_arrow_right.png",width: 22,height: 22,),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Gap(22),
                              Visibility(
                                visible: listSubmission.isNotEmpty,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    startActivity(context, const ResourceCenterScreen(true));
                                  },
                                  child: Card(
                                    margin: const EdgeInsets.only(left: 18, right: 18),
                                    elevation: 2,
                                    color: white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                                      child: Row(
                                        children: [
                                          Image.asset("assets/images/ic_submission.png",width: 22,height: 22,),
                                          const Gap(12),
                                          const Text("Submission",
                                            style: TextStyle(fontSize: 16, color: black,fontWeight: FontWeight.w500),),
                                          const Spacer(),
                                          Image.asset("assets/images/ic_arrow_right.png",width: 22,height: 22,),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: false,
                                child: Container(
                                  margin: const EdgeInsets.only(top: 12,bottom: 12),
                                  height: 120,
                                  child: ListView.builder(
                                    itemCount: listMaterial.length,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: ( context, index) {
                                      var getSet = listMaterial[index];
                                      return Container(
                                        margin: const EdgeInsets.only(),
                                        child: GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () {
                                            startActivity(context, ResourceCenterClassScreen(getSet,false));
                                          },
                                          child: Container(
                                            width: 200,
                                            margin: const EdgeInsets.only(bottom: 12,left: 18),
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              color: white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.5),
                                                  spreadRadius: 0.7,
                                                  blurRadius: 0.5,
                                                  offset: const Offset(0, 3), // changes position of shadow
                                                ),
                                              ],
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Icon(Icons.folder_copy_outlined,size: 26,),
                                                const Gap(12),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text((index + 1).toString(),style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w600)),
                                                    Container(width: 4,),
                                                    Flexible(child: Text(getSet.moduleName.toString(),style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400,overflow: TextOverflow.clip),)),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: false,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(left: 18, right: 18),
                                  alignment: Alignment.centerLeft,
                                  child: const Text("Submission",
                                    style: TextStyle(fontSize: 16, color: black,fontWeight: FontWeight.w600),),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 12),
                                  height: 140,
                                  child: ListView.builder(
                                    itemCount: listSubmission.length,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: ( context, index) {
                                      var getSet = listSubmission[index];
                                      return GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () {
                                          startActivity(context, ResourceCenterClassScreen(getSet, true));
                                        },
                                        child: Container(
                                          width: 200,
                                          height: 120,
                                          margin: const EdgeInsets.only(bottom: 12,top: 12,left: 18),
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: white,
                                            borderRadius: BorderRadius.circular(8),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.5),
                                                spreadRadius: 0.7,
                                                blurRadius: 0.5,
                                                offset: const Offset(0, 3), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Icon(Icons.folder_copy_outlined,size: 26,),
                                              const Gap(12),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text((index + 1).toString(),style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w600)),
                                                  Container(width: 4,),
                                                  Flexible(child: Text(getSet.moduleName.toString(),style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400,overflow: TextOverflow.clip),)),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: value.response.upcomingEvents?.isNotEmpty ?? false,
                            child: Column(
                              children: [
                                Container(height: 22,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(left: 18, right: 18),
                                      alignment: Alignment.centerLeft,
                                      child: const Text("Upcoming Events",
                                        style: TextStyle(fontSize: 16, color: black,fontWeight: FontWeight.w600),),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 18, right: 18),
                                      child: GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => const EventsScreen()));
                                        },
                                        child: const Text("View All",
                                          style: TextStyle(fontSize: 14, color: black,fontWeight: FontWeight.w400),),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: value.response.upcomingEvents?.isNotEmpty ?? false,
                            child: Container(
                              margin: const EdgeInsets.only(top: 12,),
                              padding: const EdgeInsets.only(left: 18),
                              height: 300,
                              child: AnimationLimiter(
                                child: PageView.builder(
                                  itemCount: value.response.upcomingEvents?.length,
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: ( context, index) {
                                    return AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration: const Duration(milliseconds: 600),
                                      child: SlideAnimation(
                                        verticalOffset: 100.0,
                                        child: FadeInAnimation(
                                          child: GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap: () {
                                              var storeData = value.response.upcomingEvents?[index] ?? UpcomingEvents();
                                              var getSet = EventList(id: storeData.id, title: storeData.title, description: storeData.description,
                                                  date: storeData.date, bannerImage: storeData.bannerImage, createdAt: storeData.createdAt,
                                                  day: "",  isActive: "", monthyear: "");

                                              startActivity(context, EventsDetailsScreen(getSet));
                                            },
                                            child: Container(
                                              height: 300,
                                              width : MediaQuery.of(context).size.width,
                                              margin: EdgeInsets.only(left: index == 0 ? 0 : 12,right: 12),
                                              decoration:  BoxDecoration(
                                                border: Border.all(color: white, width: 0.5),
                                                borderRadius:const BorderRadius.all(Radius.circular(8),) ,
                                                color: grayNew,
                                              ),
                                              child: Stack(
                                                alignment: Alignment.bottomLeft,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(8),
                                                    child: CachedNetworkImage(
                                                        imageUrl: "${value.response.upcomingEvents?[index].bannerImage}&h=500&zc=2",
                                                        fit: BoxFit.cover,
                                                        width : MediaQuery.of(context).size.width,
                                                        height: 300,
                                                        errorWidget: (context, url, error) => Container(
                                                          color: grayNew,
                                                          width : MediaQuery.of(context).size.width,
                                                          height: 300,
                                                        ),
                                                        placeholder: (context, url) => Container(
                                                          color: grayNew,
                                                          width : MediaQuery.of(context).size.width,
                                                          height: 300,
                                                        )
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 300,
                                                    decoration: BoxDecoration(
                                                        color: Colors.black,
                                                        gradient: LinearGradient(
                                                            begin: FractionalOffset.topCenter,
                                                            end: FractionalOffset.bottomCenter,
                                                            colors: [
                                                              blackConst.withOpacity(0.0),
                                                              blackConst.withOpacity(1),
                                                            ],
                                                            stops: const [
                                                              0.7,
                                                              1.0
                                                            ]),
                                                        borderRadius: BorderRadius.circular(8)
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(height: 6,),
                                                        Text(value.response.upcomingEvents?[index].title ?? "",
                                                          style: const TextStyle(fontSize: 16, color: white,fontWeight: FontWeight.w500),),
                                                        Container(height: 6,),
                                                        Text(universalDateConverter("dd-MM-yyyy hh:mm a", "dd MMM, yyyy hh:mm a", value.response.upcomingEvents?[index].date ?? ""),
                                                          style: const TextStyle(fontSize: 14, color: white,fontWeight: FontWeight.w400),),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 18, right: 18,top: 12),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text("Case Study",
                                  style: TextStyle(fontSize: 16, color: black,fontWeight: FontWeight.w600),),
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const CaseStudyScreen()));
                                  },
                                  child: const Text("View All",
                                    style: TextStyle(fontSize: 14, color: black,fontWeight: FontWeight.w400),),
                                ),
                              ],
                            ),
                          ),
                          Container(height: 12,),
                          SizedBox(
                            height: 275,
                            child: AnimationLimiter(
                              child: PageView.builder(
                                itemCount:  listCaseStudy.length,
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: ( context, index) {
                                  var getSet = listCaseStudy[index];
                                  return Container(
                                    margin: const EdgeInsets.only(left: 18, right: 18),
                                    child: AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration: const Duration(milliseconds: 600),
                                      child: SlideAnimation(
                                        verticalOffset: 100.0,
                                        child: FadeInAnimation(
                                          child: GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap: () {
                                              startActivity(context, CaseStudyDetailScreen(listCaseStudy[index]));
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(0.0),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:  BorderRadius.circular(8),
                                                    child: CachedNetworkImage(
                                                        imageUrl: "${getSet.coverImage}&h=500&zc=2",
                                                        fit: BoxFit.cover,
                                                        width : MediaQuery.of(context).size.width,
                                                        height: 200,
                                                        errorWidget: (context, url, error) => Container(
                                                          color: grayNew,
                                                          width : MediaQuery.of(context).size.width,
                                                          height: 200,
                                                        ),
                                                        placeholder: (context, url) => Container(
                                                          color: grayNew,
                                                          width : MediaQuery.of(context).size.width,
                                                          height: 200,
                                                        )
                                                    ),
                                                  ),
                                                  Container(height: 12,),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 10.0),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(getSet.title ?? "",
                                                          style: const TextStyle(fontSize: 16, color: black,fontWeight: FontWeight.w500),),
                                                        Container(height: 8,),
                                                        Text(getSet.tagLine ?? "",
                                                          style: const TextStyle(fontSize: 14, color: black,fontWeight: FontWeight.w400),),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Container(height: 12,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 18,right: 18),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Articles",
                                      style: TextStyle(fontSize: 16, color: black,fontWeight: FontWeight.w600),
                                    ),
                                    GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        startActivity(context, BlogListScreen());
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "View all",
                                          style: TextStyle(color: black,fontWeight: FontWeight.w400,fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 290,
                                child: setBlogs(),
                              ),
                            ],
                          ),
                        const Gap(50)

                        /*  Container(
                            padding: const EdgeInsets.only(left: 18, right: 18),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text("Testimonials",
                                  style: TextStyle(fontSize: 16, color: black,fontWeight: FontWeight.w600),),
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const TestimonialsScreen()));
                                  },
                                  child: const Text(" View All",
                                    style: TextStyle(fontSize: 14, color: black,fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(height: 12,),*/
                         /* Container(
                            height: 400,
                            alignment: Alignment.centerLeft,
                            child: PageView.builder(
                              itemCount:  listTestimonials.length,
                              scrollDirection: Axis.horizontal,
                              padEnds: false,
                              controller: testimonialController,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: ( context, index) {
                                var getSet = listTestimonials[index];
                                return Visibility(
                                  visible: getSet.isActive == "1",
                                  child: Container(
                                    width: 140,
                                    margin: const EdgeInsets.only(left: 18),
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        var videoUrl = '';
                                        for (var i=0; i < (getSet.mediaList?.length ?? 0); i++)
                                          {
                                            videoUrl = getSet.mediaList?[i].path ?? '';
                                          }
                                        print("videoUrl === $videoUrl");
                                         startActivity(context, VideoProjectWidget(url: videoUrl, play: true));
                                      },
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Stack(
                                              alignment: Alignment.bottomRight,
                                              children: [
                                                CachedNetworkImage(
                                                  imageUrl: getSet.thumbImg ?? '',
                                                  fit: BoxFit.cover,
                                                  width : 250,
                                                  height: 300,
                                                  errorWidget: (context, url, error) => Container(
                                                    color: grayNew,
                                                    width : 250,
                                                    height: 300,
                                                  ),
                                                  placeholder: (context, url) => Container(
                                                    color: grayNew,
                                                    width : 250,
                                                    height: 300,
                                                  )
                                                ),
                                                Container(
                                                  height: 32,
                                                  margin: const EdgeInsets.only(right: 12,bottom: 12),
                                                  padding: const EdgeInsets.all(8),
                                                  decoration: ShapeDecoration(
                                                    color: const Color(0xFFEC5554),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(40),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      SizedBox(
                                                        width: 16,
                                                        height: 16,
                                                        child: Image.asset('assets/images/ic_play.png'),
                                                      ),
                                                      const SizedBox(width: 4),
                                                      const Text(
                                                        'Watch Now',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 10,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(height: 12),
                                          Text(
                                            getSet.title ?? "",
                                            style: const TextStyle(fontSize: 16, color: black,fontWeight: FontWeight.w500,overflow: TextOverflow.clip),
                                            overflow: TextOverflow.clip,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(height: 12),*/
                          /*Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () async {
                                        startActivity(context, const HolidayScreen());
                                      },
                                      child: Container(
                                        decoration:  BoxDecoration(
                                          border: Border.all(color: white, width: 0.5),
                                          borderRadius:const BorderRadius.all(Radius.circular(8),) ,
                                          color: white,
                                        ),
                                        height: 180,
                                        margin: const EdgeInsets.only(right: 4,),
                                        child: Stack(
                                          children:  [
                                            // Text(getSet.unibharGiven.toString(),
                                            //   style: const TextStyle(fontSize: 24, color: blue,fontWeight: FontWeight.w500),),
                                            //   ClipRRect(
                                            //     borderRadius: BorderRadius.circular(8.0),
                                            //   child: Image.asset("assets/images/ic_holiday.jpg",
                                            //     fit: BoxFit.cover,
                                            //     height: 180,
                                            //     width: MediaQuery.of(context).size.width,
                                            //   ),
                                            // ),
                                            Container(
                                              height: 180,
                                              decoration: BoxDecoration(
                                                  color: grayLight,
                                                  border: Border.all(
                                                    color: grayLight,
                                                  ),
                                                  borderRadius: const BorderRadius.all(Radius.circular(8))
                                              ),
                                            ),
                                            const Positioned(
                                              bottom: 12,
                                              left: 12,
                                              child: Text('Holiday',
                                                style: TextStyle(fontSize: 16, color:black,fontWeight: FontWeight.w500),),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          Container(height: 18,),*/
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

  setBlogs() {
    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const AlwaysScrollableScrollPhysics(),
        primary: false,
        shrinkWrap: true,
        itemCount: listBlog.length,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width / 1.2,
            padding: EdgeInsets.only(left: index == 0 ? 18 : 8, right: index == listBlog.length - 1 ? 18 : 0),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                startActivityAnimation(context, BlogDetailsScreen(listBlog, index));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    alignment: Alignment.center,
                    decoration:  BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(kBorderRadius),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1), //color of shadow
                          spreadRadius: 5, //spread radius
                          blurRadius: 9, // blur radius
                          offset: const Offset(0, 2), // changes position of shadow
                        )
                      ],
                    ),
                    height: 160,
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(kButtonCornerRadius),
                        ),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 160,
                              decoration: BoxDecoration(
                                  color: lightgrey,
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider("${listBlog[index].imageFull}&h=500&q=100"),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(kButtonCornerRadius),
                                  )),
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 12,top: 12),
                              decoration: BoxDecoration(
                                color: white.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(kBorderRadius),
                              ),
                              padding: const EdgeInsets.fromLTRB(6, 3, 6, 3),
                              child: Text(toDisplayCase(listBlog[index].publishedDate ?? ''),style: const TextStyle(color: black,fontWeight: FontWeight.w400,fontSize: 12)),
                            )
                          ],
                        )),
                  ),
                  Text(
                    toDisplayCase(listBlog[index].title.toString().trim()),
                    overflow: TextOverflow.clip,
                    maxLines: 2,
                    style: TextStyle(color: black, fontWeight: FontWeight.w500, fontSize: textFiledSize),
                  ),
                  const Gap(6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          checkValidString(listBlog[index].description.toString().replaceAll(htmlExp, "").replaceAll("&nbsp;", "").replaceAll("&quot;", "").replaceAll("&#39;", "'").replaceAll("<br />", "").trim()).toString(),
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          style: const TextStyle(fontWeight: FontWeight.w400, color: black, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  const Gap(6),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void castStatefulWidget() {
    widget is DashboardScreen;
  }

  void _eventDialog(String date, String title, String titleForEvent) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(left: 0,right: 0),
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(18.0),
              ),
            ),
            actionsPadding: const EdgeInsets.all(18),
            actions: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        flex: 1,
                        child: Text("Date",style: TextStyle(color: grayDarkNew,fontSize: 12,fontWeight: FontWeight.w400),),
                      ),
                      const Text(" : ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                      Expanded(
                        flex: 3,
                        child: Text(date,style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w500),),
                      ),
                    ],
                  ),
                  const Gap(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(titleForEvent,style: const TextStyle(color: grayDarkNew,fontSize: 12,fontWeight: FontWeight.w400),),
                      ),
                      const Text(" : ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                      Expanded(
                        flex: 3,
                        child: Text(title ?? "",style:  const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w500),),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void openEventBottomSheet(String date, String title) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: white,
      isScrollControlled: true,
      // barrierColor: Colors.white,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Wrap(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 12,left: 12,right: 12,bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Text("Date & Time ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                          ),
                          const Text(" : ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                          Expanded(
                            flex: 2,
                            child: Text(date,style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400),),
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
                            child: Text("event",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                          ),
                          const Text(" : ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                          Expanded(
                            flex: 2,
                            child: Text(title ?? "",style:  const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400),),
                          ),
                        ],
                      ),
                    ],
                  ),
                )

              ],
            );
          },
        );
      },
    );
  }

  Future<void> getModuleData() async {
    Map<String, String> jsonBody = {
      'batch_id': "",
      'limit': _pageResult.toString(),
      'page': _pageIndex.toString(),
      'search': "",
      'status': "1",
      'total': "0",
      'student_id': sessionManager.getUserId() ?? '',
      'from_app' : FROM_APP
    };
    var moduleViewModel = Provider.of<ModuleViewModel>(context,listen: false);
    await moduleViewModel.getModuleList(jsonBody);

    if (moduleViewModel.response.success == '1')
      {
        listModule = moduleViewModel.response.list ?? [];

        for (var i=0; i < listModule.length; i++)
          {
            if (listModule[i].allowMaterialAccess == "1")
              {
                listMaterial.add(listModule[i]);
              }

            if (listModule[i].hasSubmission == "1")
              {
                listSubmission.add(listModule[i]);
              }
          }

      }

  }

  Future<void> getCaseStudyList(bool isFirstTime) async {
    if (isFirstTime) {
      setState(() {
        _isLoadingMore = false;
        _pageIndex = 1;
        _isLastPage = false;
      });
    }

    /*page: 1, limit: 10, search: "", total: 0, status: 1, filter: "upcoming", filter_by: "upcoming",…}*/
    Map<String, String> jsonBody = {
      'limit': _pageResult.toString(),
      'page': _pageIndex.toString(),
      'search': "",
      'from_app' : FROM_APP
    };

    var caseStudyViewModel = Provider.of<CaseStudyViewModel>(context,listen: false);
    await caseStudyViewModel.getCaseStudyList(jsonBody);

    if (caseStudyViewModel.response.success == "1")
    {
      List<CaseStudyList>? _tempList = [];
      _tempList = caseStudyViewModel.response.list;
      listCaseStudy.addAll(_tempList!);

      print(listCaseStudy.length);


      if (_tempList.isNotEmpty) {
        _pageIndex += 1;
        if (_tempList.isEmpty || _tempList.length % _pageResult != 0 ) {
          _isLastPage = true;
        }
      }
    }
    setState(() {
      _isLoadingMore = false;
    });
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
      setState(() {
        getSet = userViewModel.response.details ?? Details();
      });
      if (NavigationService.isForPendingFees)
      {
        if (await canLaunchUrl(Uri.parse(getSet.paymentLink ?? '')))
        {
          NavigationService.isForPendingFees = false;
          launchUrl(Uri.parse(getSet.paymentLink ?? ''),mode: LaunchMode.externalApplication);
        }
      }
    }
    else
    {

    }
  }

  Future<void> getTestimonialsList(bool isFirstTime) async {
    if (isFirstTime) {
      setState(() {
        _isLoadingMore = false;
        _pageIndex = 1;
        _isLastPage = false;
      });
    }

    Map<String, String> jsonBody = {
      'limit': _pageResult.toString(),
      'page': _pageIndex.toString(),
      'search': "",
      'from_app' : FROM_APP,
      'total' : '0',
      'type' : '',
      'user_type' : '3'
    };

    var testimonialsViewModel = Provider.of<TestimonialsViewModel>(context,listen: false);
    await testimonialsViewModel.getTestimonialsList(jsonBody);

    if (testimonialsViewModel.response.success == "1")
    {
      List<TestimonialsList>? _tempList = [];
      _tempList = testimonialsViewModel.response.list;

      listTestimonials.addAll((_tempList ?? []).where((element) => element.isActive == "1"));

      if (_tempList?.isNotEmpty ?? false) {
        _pageIndex += 1;
        if (_tempList?.isEmpty ?? false || (_tempList?.length ?? 0) % _pageResult != 0 ) {
          _isLastPage = true;
        }
      }

    }
    setState(() {
      _isLoadingMore = false;
    });
  }

  Future<void> getDashboardData() async {
    Map<String, String> jsonBody = {
      'student_id': sessionManager.getUserId().toString(),
      'filter': 'upcoming_class',
      'from_app' : FROM_APP
    };
    DashboardViewModel userViewModel = Provider.of<DashboardViewModel>(context,listen: false);
    await userViewModel.dashboardData(jsonBody);

    if (userViewModel.response.success == '1')
    {
      setState(() {
        listUpcomingHolidays = userViewModel.response.holidaysList ?? [];
        listUpcomingLectures = userViewModel.response.upcomingClasses ?? [];

        valueNotifier.value = double.parse(userViewModel.response.completedModule ?? '0');

        for(int i=0;i<listUpcomingLectures.length;i++)
          {
            var setDecoration = DecorationItem(
              date: DateFormat('dd-MM-yyyy').parse(listUpcomingLectures[i].date.toString()),
              decoration: const Icon(Icons.circle,color: Colors.red,),
            );
            listCalenderEvents.add(setDecoration);

            listCalenderData.add(CalendarEventModel(date: listUpcomingLectures[i].date.toString(),title: listUpcomingLectures[i].session1Topic ?? '',eventType: "Lecture"));
          }

        for(int i=0;i<listUpcomingHolidays.length;i++)
          {
            var setDecoration = DecorationItem(
              date: DateFormat('dd-MM-yyyy').parse(listUpcomingHolidays[i].holidayDate.toString()),
              decoration: const Icon(Icons.circle,color: black,),
            );
            listCalenderEvents.add(setDecoration);

            listCalenderData.add(CalendarEventModel(date: listUpcomingHolidays[i].holidayDate.toString(),title: listUpcomingHolidays[i].title ?? '',eventType: "Holiday"));
          }


        listCalenderData.sort((a, b) {
          return DateFormat("yyyy-MM-dd hh:mm:ss").parse(b.date ?? '').compareTo(DateTime.parse(a.date ?? ''));
        });

      });
    }
    else  if (userViewModel.response.success == '0')
    {

    }

  }

  Future<void> getDeviceToken() async {
    var fcmToken = await FirebaseMessaging.instance.getToken();
    sessionManager.setDeviceToken(fcmToken.toString());
    print("*************** $fcmToken");
    if (sessionManager.getDeviceToken().toString().trim().isNotEmpty)
      {
        updateDeviceTokenData();
      }
  }

  updateDeviceTokenData() async {
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
      'user_id': sessionManager.getUserId() ?? '',
      'device_token': sessionManager.getDeviceToken().toString(),
      'device_type': deviceType,
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> apiResponse = jsonDecode(body);
    var dataResponse = UpdateDeviceTokenModel.fromJson(apiResponse);
    if (statusCode == 200 && dataResponse.success == 1) {

      if (dataResponse.isForceLogout == "1")
        {
          forceLogout();
        }

    } else {

    }
  }

  forceLogout() async {
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
      'user_id': sessionManager.getUserId() ?? '',
      'device_token': sessionManager.getDeviceToken().toString(),
      'device_type': deviceType,
      'is_logout': '1',
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
    } else {

    }
  }

  getBlogList() async {

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(articleListUrl);

    Map<String, String> jsonBody = {
      'is_active':'1',
      'joint_page_id':'12',
      'logged_in_master_user_id':'1',
      'master_user_id':'1'
    };

    final response = await http.post(url, body: jsonBody, headers: {
      "Authorization": AuthHeader,
    });

    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = BlogListResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1)
    {
      setState(() {
        listBlog = [];
        listBlog.addAll(dataResponse.data ?? []);
      });

    }
    else
    {

      showSnackBar(dataResponse.message, context);
    }
  }

}