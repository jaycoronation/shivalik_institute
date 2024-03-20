import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shivalik_institute/common_widget/common_widget.dart';
import 'package:shivalik_institute/screen/CaseStudyScreen.dart';
import 'package:shivalik_institute/screen/ChatScreen.dart';
import 'package:shivalik_institute/screen/ConversationScreen.dart';
import 'package:shivalik_institute/screen/EventsScreen.dart';
import 'package:shivalik_institute/screen/FacultyProfileScreen.dart';
import 'package:shivalik_institute/screen/FeedbackFormScreenNew.dart';
import 'package:shivalik_institute/screen/LectureDetailsScreen.dart';
import 'package:shivalik_institute/screen/LectureScreen.dart';
import 'package:shivalik_institute/screen/ModuleListScreen.dart';
import 'package:shivalik_institute/screen/NotificationListScreen.dart';
import 'package:shivalik_institute/screen/ResourceCenterScreen.dart';
import 'package:shivalik_institute/utils/app_utils.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common_widget/PlaceholderTile.dart';
import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../constant/firebase_constant.dart';
import '../constant/global_context.dart';
import '../model/BatchResponseModel.dart';
import '../model/BlogListResponseModel.dart';
import '../model/CalendarEventModel.dart';
import '../model/CaseStudyResponseModel.dart';
import '../model/DashboardResponseModel.dart';
import '../model/EventResponseModel.dart';
import '../model/LecturesResponseModel.dart';
import '../model/ModuleResponseModel.dart';
import '../model/PendingFeedbackResponseModel.dart';
import '../model/TestimonialResponseModel.dart';
import '../model/UpdateDeviceTokenModel.dart';
import '../utils/base_class.dart';
import '../utils/session_manager_methods.dart';
import '../viewmodels/BatchViewModel.dart';
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
  String fromDateApi = "";
  String toDateApi = "";
  String selectedDateFilter = "Today";
  String selectedDateFaculty = "";
  String selectedFacultyId1 = "";
  String selectedFacultyId2 = "";
  String deviceName = '';
  ModuleList moduleGetSet = ModuleList();
  List<ModuleList> listModule = [];
  List<ModuleList> listSubmission = [];
  List<ModuleList> listMaterial = [];
  List<EventList> listEvent = [];
  List<CaseStudyList> listCaseStudy = [];
  List<LectureList> listLecture = [];
  List<TestimonialsList> listTestimonials = [];
  List<MediaList> mediaList = [];
  List<BatchList> listBatches = [];

  Details getSet = Details();
  List<HolidaysList> listUpcomingHolidays = [];
  List<UpcomingClasses> listUpcomingLectures = [];
  List<DecorationItem> listCalenderEvents = [];
  List<CalendarEventModel> listCalenderData = [];
  final CalendarWeekController calendarController = CalendarWeekController();

  PageController? testimonialController = PageController(initialPage: 0,viewportFraction: 0.60);

  ValueNotifier<double> valueNotifier = ValueNotifier(0.0);

  List<BlogList> listBlog = [];

  final ScrollController scrollController = ScrollController();

  bool hasAttendLecture = false;

  @override
  void initState() {
    _deviceDetails();
    getDashboardData();
    getUserData();
    getModuleData();
    getCaseStudyList(true);
    getDeviceToken();
    getBlogList();
    getPendingFeedbacks();
    getBatchData();

    FirebaseMessaging.onMessage.listen((message) {
      var id = "";
      var contentType = "";
      var image = "";
      var title = "";
      var messageData = "";

      message.data.forEach((key, value) {
        if (key == "content_id") {
          id = value;
        }

        if (key == "operation") {
          contentType = value;
        }

        if (key == "image") {
          image = value;
        }

        if (key == "title") {
          title = value;
        }

        if (key == "message") {
          messageData = value;
        }
      });

     /* print('<><>Dashboard onMessage id--->$id');
      print('<><>Dashboard onMessage contentType--->$contentType');
      print('<><>Dashboard onMessage title--->$title');
      print('<><>Dashboard onMessage messageData--->$messageData');
      print("<><>Dashboard onMessage Image URL : $image <><>");*/

      NavigationService.notif_id = id;

      if (contentType == "lecture_complete")
      {
        sessionManager.setClassId(id);
        getPendingFeedbacks();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    PageController? controller = PageController(initialPage: 0);

    return WillPopScope(
        child: Scaffold(
          backgroundColor: grayButton,
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: appBg,
              statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
              statusBarBrightness: Brightness.light,
            ) ,
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: white,
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
                  child: sessionManager.getProfilePic()?.isEmpty ?? true
                      ? Image.asset(
                        'assets/images/ic_user_placeholder.png',
                        height: 42,
                        width: 42,
                        fit: BoxFit.cover,
                      )
                      : Image.network(
                        sessionManager.getProfilePic() ?? '',
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
                  logFirebase('notification_enter',{});
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
              const Gap(12),
              /*InkWell(
                onTap: (){
                  //logFirebase('chat',{});
                  if (sessionManager.getMainBatchId()?.contains(",") ?? false)
                    {
                      startActivity(context, const ConversationScreen());
                    }
                  else
                    {
                      startActivity(context, const ChatScreen(false));
                    }
                },
                customBorder: const CircleBorder(),
                child: Container(
                    padding: const EdgeInsets.all(4),
                    height: 34,
                    width: 34,
                    child: Image.asset('assets/images/ic_chat.png',color: black,width: 26,height: 26)
                ),
              ),
              const Gap(12),*/
            ],
          ),
          body: Consumer<DashboardViewModel>(
            builder: (context, value, child) {
              if (value.isLoading)
                {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    enabled: true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
                          margin: const EdgeInsets.only(top: 22),
                          child: ListView.builder(
                            shrinkWrap: true,
                            controller: scrollController,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {},
                                child: LimitedBox(
                                  maxWidth: 220,
                                  child: Container(
                                      margin: const EdgeInsets.only(left: 12),
                                      decoration: BoxDecoration(
                                          color: white,
                                          borderRadius: BorderRadius.circular(4)
                                      ),
                                      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 120.0,
                          margin: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                          ),
                        ),
                        const BannerPlaceholder(),
                        Container(
                          width: double.infinity,
                          height: 50.0,
                          margin: const EdgeInsets.only(top: 16,right: 16,left: 16),
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 50.0,
                          margin: const EdgeInsets.only(top: 16,right: 16,left: 16),
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 50.0,
                          margin: const EdgeInsets.only(top: 16,right: 16,left: 16),
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.white,
                          ),
                        ),
                        const BannerPlaceholder(),
                      ],
                    ),
                  );
                }
              else
                {
                  if (value.response.success == "1")
                  {
                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 50,
                            margin: const EdgeInsets.only(top: 22),
                            child: ListView.builder(
                              shrinkWrap: true,
                                controller: scrollController,
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: listCalenderData.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      print(listCalenderData[index].name ?? '');

                                      setState(() {
                                        selectedDateFaculty = listCalenderData[index].name ?? '';
                                        selectedFacultyId1 = listCalenderData[index].facultyId1 ?? '';
                                        selectedFacultyId2 = listCalenderData[index].facultyId2 ?? '';
                                      });

                                      print("selectedFacultyId1 ==== $selectedFacultyId1");
                                      print("selectedFacultyId2 ==== $selectedFacultyId2");
                                      logFirebase("swiper_dashboard",{"clicked_on" : listCalenderData[index].eventType ?? ''});

                                      _eventDialog(listCalenderData[index].date ?? '', listCalenderData[index].title ?? '', listCalenderData[index].eventType ?? '');
                                    },
                                    child: LimitedBox(
                                      maxWidth: 220,
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 12),
                                        decoration: BoxDecoration(
                                          color: white,
                                          borderRadius: BorderRadius.circular(4)
                                        ),
                                        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: grayButton,
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.circular(4)
                                              ),
                                              padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                              child: Text(
                                                  universalDateConverter("dd-MM-yyyy", "dd\nMMM", listCalenderData[index].date ?? ''),
                                                  style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w500),
                                                  textAlign: TextAlign.center
                                              ),
                                            ),
                                            const Gap(8),
                                            Flexible(
                                              child: Text(
                                                listCalenderData[index].title ?? '',
                                                style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w500),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            ),

                                          ],
                                        )
                                      ),
                                    ),
                                  );
                                },
                            ),
                          ),
                          Visibility(
                            visible: false,
                            child: Container(
                              margin: const EdgeInsets.only(top: 12),
                              height: 110 ,
                              child: CalendarWeek(
                                controller: calendarController,
                                height: 110,
                                showMonth: true,
                                backgroundColor: grayButton,
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
                                      selectedDateFaculty = listUpcomingLectures[i].session2FacultyName?.isNotEmpty ?? false ? "${listUpcomingLectures[i].session1FacultyName ?? ''} and ${listUpcomingLectures[i].session2FacultyName ?? ''}" : listUpcomingLectures[i].session1FacultyName ?? '';
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
                                pressedDateBackgroundColor: brandColor,
                                todayBackgroundColor: Colors.transparent,
                                todayDateStyle: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w500,fontFamily: "Poppins"),
                                pressedDateStyle: const TextStyle(color: white,fontSize: 14,fontWeight: FontWeight.w500,fontFamily: "Poppins"),
                                dateStyle: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w500,fontFamily: "Poppins"),
                                dayOfWeekStyle: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w500,fontFamily: "Poppins"),
                                weekendsStyle: const TextStyle(color: Colors.red,fontSize: 14,fontWeight: FontWeight.w500,fontFamily: "Poppins"),
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
                                          color: black, fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis,fontFamily: "Poppins"
                                        ),
                                      )
                                  ),
                                ),
                                decorations: listCalenderEvents,

                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 22),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(topRight: Radius.circular(12),topLeft: Radius.circular(12)),
                              color: white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0.7,
                                  blurRadius: 0.8,
                                  offset: const Offset(3, 0), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Visibility(
                                  visible: value.response.upcomingClasses?.isNotEmpty ?? false,
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 26),
                                    padding: const EdgeInsets.only(top: 12,bottom: 12),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.only(left: 18, right: 18),
                                              alignment: Alignment.centerLeft,
                                              child: const Text("Upcoming Lectures",
                                                style: TextStyle(fontSize: 16, color: black,fontWeight: FontWeight.w800),),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(left: 18, right: 18),
                                              child: GestureDetector(
                                                behavior: HitTestBehavior.opaque,
                                                onTap: (){
                                                  logFirebase('lecture_view_all', {});

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
                                          height: 190,
                                          child: PageView.builder(
                                            itemCount: (value.response.upcomingClasses?.length ?? 0)> 10 ? 10 : value.response.upcomingClasses?.length,
                                            scrollDirection: Axis.horizontal,
                                            controller: controller,
                                            physics: const BouncingScrollPhysics(),
                                            itemBuilder: ( context, index) {
                                              var getSet =  value.response.upcomingClasses?[index] ?? UpcomingClasses();
                                              return GestureDetector(
                                                behavior: HitTestBehavior.opaque,
                                                onTap: () {
                                                  startActivity(context, LectureDetailsScreen(getSet.id ?? ''));
                                                  logFirebase('lecture_details', {'lecture_id': getSet.id,'lecture_title' : getSet.title});
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets.only(left: 12,right: 12),
                                                  padding: const EdgeInsets.all(12),
                                                  decoration: BoxDecoration(
                                                    color: grayButton,
                                                    border: Border.all(color: grayButton),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Image.asset('assets/images/ic_class.png', width: 22, height: 22, color: black,),
                                                          const Gap(8),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Text(getSet.classNoFormat ?? "",style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w500),),
                                                          ),
                                                        ],
                                                      ),
                                                      const Gap(12),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Image.asset('assets/images/ic_class_date.png', width: 22, height: 22, color: black,),
                                                          const Gap(8),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Text("${universalDateConverter("dd-MM-yyyy", "dd MMM yyyy", getSet.date ?? '')} (${universalDateConverter("dd-MM-yyyy", "EEEE", getSet.date ?? '')})",style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w500),),
                                                          ),
                                                        ],
                                                      ),
                                                      const Gap(12),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Image.asset('assets/images/ic_class_time.png', width: 22, height: 22, color: black,),
                                                          const Gap(8),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Text(getSet.session1Endtime?.isEmpty ?? false
                                                                ? getSet.session1Starttime?.isEmpty ?? false
                                                                ? "${getSet.startTime} To ${getSet.endTime}"
                                                                : getSet.session1Starttime ?? ''
                                                                : "${getSet.session1Starttime} To ${getSet.session1Endtime}",
                                                              style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w500),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const Gap(12),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Image.asset('assets/images/ic_module.png', width: 22, height: 22, color: black,),
                                                          const Gap(8),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Text(getSet.moduleDetails?.name ?? "",style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w500),),
                                                          ),
                                                        ],
                                                      ),
                                                      const Gap(12),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Image.asset('assets/images/ic_faculty.png', width: 22, height: 22, color: black,),
                                                          const Gap(8),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Text(getSet.session2FacultyName?.isNotEmpty ?? false ? "${getSet.session1FacultyName},${getSet.session2FacultyName}" : getSet.session1FacultyName ?? '',style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w500),),
                                                          ),
                                                        ],
                                                      ),
                                                      Visibility(
                                                        visible: false,
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            const Expanded(
                                                              flex: 1,
                                                              child: Text("Status ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                                            ),
                                                            const Text(" : ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                                            Expanded(
                                                              flex: 2,
                                                              child: Text(getSet.isActive == "1" ? "Active" : "InActive",style: TextStyle(color: getSet.isActive == "1" ? Colors.green : Colors.red,fontSize: 14,fontWeight: FontWeight.w600),),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                              /*return GestureDetector(
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
                                                            color: black,
                                                            width: 0.2
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
                                                              Row(
                                                                children: [
                                                                  Image.asset('assets/images/ic_calender.png', width: 22,height: 22,),
                                                                  Container(width: 10,),
                                                                  Text(universalDateConverter("dd-MM-yyyy", "dd MMM, yyyy", getSet?.date ?? ''),style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400),),
                                                                ],
                                                              ),
                                                              const Gap(12),
                                                              Row(
                                                                children: [
                                                                  Image.asset('assets/images/ic_clock.png', width: 22,height: 22,),
                                                                  Container(width: 10,),
                                                                  Text(getSet?.endTime?.isNotEmpty ?? false ? "${getSet?.startTime} - ${getSet?.endTime}" : "${getSet?.startTime} onwards",style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400),),
                                                                ],
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
                                              );*/
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
                                              count: (value.response.upcomingClasses?.length ?? 0)> 10 ? 10 : value.response.upcomingClasses?.length ?? 0,
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
                                    logFirebase("module_list", {});
                                    startActivity(context, const  ModuleListScreen("all"));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 22,bottom: 22),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  LinearPercentIndicator(
                                                    width: MediaQuery.of(context).size.width - 80,
                                                    lineHeight: 14.0,
                                                    percent: getPercentData(value.response),
                                                    barRadius: const Radius.circular(4),
                                                    backgroundColor: grayNew,
                                                    progressColor: brandColor,
                                                  ),
                                                  const Gap(8),
                                                  Image.asset("assets/images/ic_medal.png",width: 38,height: 38,)
                                                ],
                                              ),
                                              const Gap(12),
                                              Text(
                                                "${value.response.completedModule} / ${value.response.totalModules ?? "0"} Modules Completed",
                                                style: const TextStyle(fontSize: 16,color: black,fontWeight: FontWeight.w500),
                                                textAlign: TextAlign.center,
                                              )
                                            ],
                                          ),
                                        ),
                                        Visibility(
                                          visible: false,
                                          child: Center(
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
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: listMaterial.isNotEmpty,
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      logFirebase("resource_center", {});
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
                                      logFirebase("submission", {});
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
                                              style: TextStyle(fontSize: 16, color: black,fontWeight: FontWeight.w800),),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(left: 18, right: 18),
                                            child: GestureDetector(
                                              behavior: HitTestBehavior.opaque,
                                              onTap: (){
                                                logFirebase("event_view_all", {});
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

                                                    logFirebase("event_details", {'event_title' : storeData.title, 'event_id' : storeData.id});

                                                    var getSet = EventList(id: storeData.id, title: storeData.title, description: storeData.description,
                                                        date: universalDateConverter("dd-MM-yyyy hh:mm a", "yyyy-MM-dd", storeData.date.toString()), bannerImage: storeData.bannerImage, createdAt: storeData.createdAt,
                                                        day: "",  isActive: "", monthyear: "",eventGallery: storeData.eventGallery ?? []);

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
                                                        Positioned(
                                                          top: 12,
                                                          right: 12,
                                                          child: Container(
                                                            height: 30,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(4),
                                                                color: brandColor
                                                            ),
                                                            padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
                                                            child: Text(value.response.upcomingEvents?[index].eventType ?? '',style: const TextStyle(color: white,fontSize: 14,fontWeight: FontWeight.w500)),
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
                                  padding: const EdgeInsets.only(left: 18, right: 18,top: 22),
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const Text("Case Study",
                                        style: TextStyle(fontSize: 16, color: black,fontWeight: FontWeight.w800),),
                                      GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: (){
                                          logFirebase("case_study_view_all", {});
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
                                  height: 300,
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
                                                    logFirebase("case_study_details", {});
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
                                                              height: 240,
                                                              errorWidget: (context, url, error) => Container(
                                                                color: grayNew,
                                                                width : MediaQuery.of(context).size.width,
                                                                height: 240,
                                                              ),
                                                              placeholder: (context, url) => Container(
                                                                color: grayNew,
                                                                width : MediaQuery.of(context).size.width,
                                                                height: 240,
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
                                          const Text(
                                            "Articles",
                                            style: TextStyle(fontSize: 16, color: black,fontWeight: FontWeight.w800),
                                          ),
                                          GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap: () {
                                              logFirebase("articles_view_all", {});
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
                                      height: 300,
                                      child: setBlogs(),
                                    ),
                                  ],
                                ),
                                const Gap(50)
                              ],
                            ),
                          ),

                        ],
                      ),
                    );
                  }
                  else
                  {
                    return const MyNoDataNewWidget(msg: "No Data Found", img: '',);
                  }
                }
            },
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                logFirebase("sire_connect", {"batch_name" : sessionManager.getBatchName()});
                if (sessionManager.getIsBatchAdmin() == "1")
                {
                  startActivity(context, ConversationScreen(listBatches));
                }
                else
                {
                  startActivity(context, const ChatScreen(false));
                }
              },
            child: Container(
                padding: const EdgeInsets.all(4),
                height: 34,
                width: 34,
                child: Image.asset('assets/images/ic_chat.png',color: white,width: 26,height: 26)
            ),
            backgroundColor: black,

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
                logFirebase("articles_details", {});
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
                    height: 190,
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(kButtonCornerRadius),
                        ),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 190,
                              decoration: BoxDecoration(
                                  color: lightGrey,
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
              borderRadius: BorderRadius.all(
                Radius.circular(18.0),
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
                        child: Text(universalDateConverter("dd-MM-yyyy", "dd MMM yyyy", date),style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                  const Gap(8),
                  Visibility(
                    visible: selectedDateFaculty.isNotEmpty,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        logFirebase('faculty_profile', {'faculty_name': selectedDateFaculty,'faculty_id' : selectedFacultyId1});
                        startActivity(context, FacultyProfileScreen(selectedFacultyId1));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Text("Faculty",style: TextStyle(color: grayDarkNew,fontSize: 12,fontWeight: FontWeight.w400),),
                          ),
                          const Text(" : ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                          Expanded(
                            flex: 3,
                            child: Text(selectedDateFaculty ?? "",style:  const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w500),),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ).then((value) => selectedDateFaculty = "");
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
                          Expanded    (
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
        _pageIndex = 1;
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
      setState(() {
        getSet = userViewModel.response.details ?? Details();
      });
      sessionManager.setProfilePic(getSet.profilePic ?? '');
      sessionManager.setBatchName(getSet.batchName ?? '');
      sessionManager.setBatchId(getSet.batchId ?? '');
      sessionManager.setMainBatchId(getSet.batchId ?? '');
      sessionManager.setIsBatchAdmin(getSet.isBatchAdmin ?? '');
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
        _pageIndex = 1;
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

    }
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

          List<CalendarEventModel> listCalenderDataTemp = [];

          for(int i=0; i < listUpcomingLectures.length; i++)
            {
              var setDecoration = DecorationItem(
                date: DateFormat('dd-MM-yyyy').parse(listUpcomingLectures[i].date.toString()),
                decoration: const Icon(Icons.circle,color: Colors.red,),
              );
              listCalenderEvents.add(setDecoration);

              listCalenderDataTemp.add(
                  CalendarEventModel(
                      date: universalDateConverter("dd-MM-yyyy", "dd-MM-yyyy", listUpcomingLectures[i].date.toString()),
                      title: listUpcomingLectures[i].session1Topic ?? '',
                      eventType: "Lecture",
                      name: listUpcomingLectures[i].session2FacultyName?.isNotEmpty ?? false ? "${listUpcomingLectures[i].session1FacultyName} and ${listUpcomingLectures[i].session2FacultyName}" : listUpcomingLectures[i].session1FacultyName,
                    facultyId1: listUpcomingLectures[i].session1Faculty,
                    facultyId2: listUpcomingLectures[i].session2Faculty
                  )
              );
            }

          for(int i=0; i < listUpcomingHolidays.length; i++)
            {
              var setDecoration = DecorationItem(
                date: DateFormat('dd-MM-yyyy').parse(listUpcomingHolidays[i].holidayDate.toString()),
                decoration: const Icon(Icons.circle,color: black,),
              );
              listCalenderEvents.add(setDecoration);

              listCalenderDataTemp.add(CalendarEventModel(date: universalDateConverter("dd-MM-yyyy", "dd-MM-yyyy", listUpcomingHolidays[i].holidayDate.toString()),title: listUpcomingHolidays[i].title ?? '',eventType: "Holiday",name: ''));
            }

          List<UpcomingEvents> listEventsTemp = [];

          listEventsTemp = userViewModel.response.upcomingEvents ?? [] ;

          for(int i=0; i < (listEventsTemp.length); i++)
            {
              listCalenderDataTemp.add(CalendarEventModel(date: universalDateConverter("dd-MM-yyyy hh:mm a", "dd-MM-yyyy", listEventsTemp[i].date.toString()),title: listEventsTemp[i].title ?? '',eventType: listEventsTemp[i].eventType,name: ""));
            }

          listCalenderDataTemp.sort((a, b) => DateFormat("dd-MM-yyyy").parse(a.date.toString()).compareTo(DateFormat("dd-MM-yyyy").parse(b.date.toString())),);

          listCalenderData = listCalenderDataTemp.where((date) => !DateFormat("dd-MM-yyyy").parse(date.date.toString()).isBefore(DateTime.now().subtract(const Duration(days: 1)))).toList();
          //listCalenderData = listCalenderDataTemp;

          /*int selectedIndex = 0;
          for (var i=0; i < listCalenderData.length; i++)
            {
              if (DateFormat("dd-MM-yyyy").parse(listCalenderData[i].date ?? '').isBefore(DateTime.now()))
                {

                  selectedIndex = i - 1;
                  break;
                }
            }

          Timer(const Duration(milliseconds: 500), () {
            _animateToIndex(selectedIndex);
          });*/

        });
      }
    else  if (userViewModel.response.success == '0')
      {
      }
  }

  void _animateToIndex(int index) {
    scrollController.animateTo(
      index * 220,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
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

  Future<void>_deviceDetails() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        setState(() {
          deviceName = "${build.model} (${build.version.release})";
        });
        print(deviceName);
        //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        setState(() {
          deviceName = "${data.name} (${data.systemVersion})";
        }); //UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
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
      'device_name' : deviceName,
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

    final url = Uri.parse(removeDeviceToken);

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
    }
    else
    {

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

  getPendingFeedbacks() async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(pendingFeedback);

    Map<String, String> jsonBody = {
      'student_id': sessionManager.getUserId() ?? '',
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> apiResponse = jsonDecode(body);
    var dataResponse = PendingFeedbackResponseModel.fromJson(apiResponse);
    if (statusCode == 200 && dataResponse.success == '1')
      {
        if (dataResponse.records?.isNotEmpty ?? false)
          {
            startActivity(context, FeedbackFormScreenNew(dataResponse.records ?? []));
          }
      }
    else
      {}
  }

  Future<void> getBatchData() async {
    Map<String, String> jsonBody = {
      'batch_status': "",
      'from_app':"true",
      'limit':'',
      'page':'1',
      'total':'0',
      'user_type':"1"
    };
    BatchViewModel batchViewModel = Provider.of<BatchViewModel>(context,listen: false);
    await batchViewModel.batchData(jsonBody);

    if (batchViewModel.response.success == '1')
    {
      listBatches = batchViewModel.response.batchList ?? [];

      print("listBatches === ${listBatches.length}");

      for (var i=0; i < listBatches.length; i++)
        {
          var getSetBatch = listBatches[i];
          print("getSetBatch === ${jsonEncode(getSetBatch)}");
          addBatchesOnDatabase(getSetBatch);
        }

    }
  }

  addBatchesOnDatabase(BatchList getSet) {
    final usersRef = firestoreInstance.collection(batch);
    final userDocRef = usersRef.doc(getSet.id);

    var userDoc = getSet.toJson();

    userDocRef.get().then((doc) {
      if (doc.exists) {
        /*userDocRef.update(userDoc).then((_) {
          print("Added batch to collection");
        }).catchError((error) {
          print("ERROR == ${error}");
        });*/
      } else {

        userDoc.addAll(
            {
              'last_message': {
                'content': '',
                'senderId': '',
                'sender_name': '',
                'timestamp': FieldValue.serverTimestamp(),
                'type': ''
              },
              'message_count': 1,
            }
        );

        userDocRef.set(userDoc).then((_) {
          print("Added batch to collection");
        }).catchError((error) {
          print("ERROR == ${error}");
        });
      }
    }).catchError((error) {
      print("ERROR == ${error}");
      // Handle any errors while checking for the user document
    });

  }

  getPercentData(DashboardResponseModel response) {
    double percent = double.parse(response.completedModule.toString()) / double.parse(response.totalModules.toString());

    print(percent);

    return percent;
  }

}