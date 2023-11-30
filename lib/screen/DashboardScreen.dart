import 'package:cached_network_image/cached_network_image.dart';
import 'package:countup/countup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shivalik_institute/common_widget/common_widget.dart';
import 'package:shivalik_institute/common_widget/loading.dart';
import 'package:shivalik_institute/screen/CaseStudyScreen.dart';
import 'package:shivalik_institute/screen/EventsScreen.dart';
import 'package:shivalik_institute/screen/HolidayScreen.dart';
import 'package:shivalik_institute/screen/LectureScreen.dart';
import 'package:shivalik_institute/screen/ManagmentScreen.dart';
import 'package:shivalik_institute/screen/ModuleListScreen.dart';
import 'package:shivalik_institute/screen/ResourceCenterScreen.dart';
import 'package:shivalik_institute/screen/TestimonialsScreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../model/CaseStudyResponseModel.dart';
import '../model/DashboardResponseModel.dart';
import '../model/EventResponseModel.dart';
import '../model/LecturesResponseModel.dart';
import '../model/ModuleResponseModel.dart';
import '../model/TestimonialResponseModel.dart';
import '../utils/base_class.dart';
import '../viewmodels/CaseStudyViewModel.dart';
import '../viewmodels/DashboardViewModel.dart';
import '../viewmodels/ModuleViewModel.dart';
import '../viewmodels/TestimonialsViewModel.dart';
import '../viewmodels/UserViewModel.dart';
import 'CaseStudyDetailScreen.dart';
import 'EventDetailsScreen.dart';
import 'MyProfleScreen.dart';
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
  List<EventList> listEvent = [];
  List<CaseStudyList> listCaseStudy = [];
  List<LectureList> listLecture = [];
  List<TestimonialsList> listTestimonials = [];
  List<MediaList> mediaList = [];

  Details getSet = Details();
  List<HolidaysList> listUpcomingHolidays = [];
  List<UpcomingClasses> listUpcomingLectures = [];
  List<DecorationItem> listCalenderEvents = [];
  final CalendarWeekController calendarController = CalendarWeekController();

  PageController? testimonialController = PageController(initialPage: 0,viewportFraction: 0.60);

  @override
 void initState() {
    getTestimonialsList(true);
    getUserData();
    getModuleData();
    getCaseStudyList(true);
    getDashboardData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PageController? controller = PageController(initialPage: 0);

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
              /*InkWell(
                onTap: (){
                  openAllScreenBottomSheet();
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 9,right: 9.0, top: 12, bottom: 12),
                  child: Icon(Icons.add),
                ),
              ),*/
             /* InkWell(
                onTap: (){
                  // startActivity(context, ProfileScreen());
                  startActivity(context, MyProfileScreen());
                  //startActivity(context, CaseStudyScreen());
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 9,right: 9.0, top: 12, bottom: 12),
                  child: Image.asset('assets/images/ic_user_placeholder.png',),
                ),
              ),*/
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: InkWell(
                  onTap: () async {
                   var value = await Navigator.push(context, MaterialPageRoute(builder: (context) => const MyProfileScreen()));
                   // var value = await Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                   getUserData();
                  },
                  customBorder: const CircleBorder(),
                  child: Padding(
                      padding: const EdgeInsets.only(left: 6.0, top: 10,bottom: 10),
                      child :  Container(
                        // decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(150)), color: Colors.lightBlue),
                        width: 34,
                        height: 34,
                        child: ClipOval(
                          child:getSet.profilePic.toString().isEmpty
                              ? Image.asset('assets/images/ic_user_placeholder.png', fit: BoxFit.cover,)
                              : Image.network(getSet.profilePic.toString(), fit: BoxFit.cover)
                        ),
                      )
                  ),
                ),
              ),
              /*InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfileScreen()));
                },
                customBorder: const CircleBorder(),
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 16, top: 10,bottom: 10),
                  child :  Container(
                    // decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(150)), color: Colors.lightBlue),
                    width: 34,
                    height: 34,
                    child: ClipOval(
                        child: getSet.profilePic.toString().isNotEmpty
                            ? Image.asset('assets/images/ic_user_placeholder.png', fit: BoxFit.cover,)
                            : Image.network(getSet.profilePic.toString() ?? '', fit: BoxFit.cover)
                    ),
                  )
                ),
              ),*/
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
                         /* Visibility(
                            visible: value.response.upcomingClasses?.isNotEmpty ?? false,
                            child: Column(
                              children: [
                                Container(height: 18,),
                                Container(
                                  padding: const EdgeInsets.only(left: 18, right: 18),
                                  alignment: Alignment.centerLeft,
                                  child: const Text("Upcoming Lecture",
                                    style: TextStyle(fontSize: 16, color: black,fontWeight: FontWeight.w600),),
                                ),
                              ],
                            ),
                          ),
                          Container(height: 12,),
                          SizedBox(
                            height: 190,
                            child: PageView.builder(
                              itemCount: value.response.upcomingClasses?.length,
                              scrollDirection: Axis.horizontal,
                              controller: controller,
                              // shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: ( context, index) {
                                var getSet =  value.response.upcomingClasses?[index];
                                return Padding(
                                  padding: const EdgeInsets.only(left: 18.0),
                                  child: Container(
                                    height: 200,
                                    width: 350,
                                    margin: const EdgeInsets.only(bottom: 12),
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: Text("No ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                            ),
                                            const Text(" : ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                            Expanded(
                                              flex: 2,
                                              child: Text(getSet?.classNoFormat ?? "",style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400),),
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
                                              child: Text("Date & Time ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                            ),
                                            const Text(" : ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                            Expanded(
                                              flex: 2,
                                              child: Text("${getSet?.date}",style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400),),
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
                                              child: Text("Module ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                            ),
                                            const Text(" : ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                            Expanded(
                                              flex: 2,
                                              child: Text(getSet?.moduleDetails?.name ?? "",style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400),),
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
                                              child: Text("Faculty ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                            ),
                                            const Text(" : ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                            Expanded(
                                              flex: 2,
                                              child: Text("${getSet?.session1FacultyName} ${getSet?.session2FacultyName}",style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400),),
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
                                              child: Text("Status ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                            ),
                                            const Text(" : ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                            Expanded(
                                              flex: 2,
                                              child: Text(getSet?.isActive == "1" ? "Active" : "InActive",style: TextStyle(color: getSet?.isActive == "1" ? Colors.green : Colors.red,fontSize: 14,fontWeight: FontWeight.w400),),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
*/
                          SizedBox(
                            height: 130,
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
                                  if (DateFormat('dd-MM-yyyy').format(selectedDate) == listUpcomingLectures[i].date.toString())
                                  {
                                    openEventBottomSheet(listUpcomingLectures[i].date ?? '', listUpcomingLectures[i].moduleDetails?.name ?? '');
                                  }
                                }

                                for (var i=0; i < listUpcomingHolidays.length; i++)
                                {
                                  if (DateFormat('dd-MM-yyyy').format(selectedDate) == listUpcomingHolidays[i].holidayDate.toString())
                                  {
                                    openEventBottomSheet(listUpcomingHolidays[i].holidayDate ?? '', listUpcomingHolidays[i].title?? '');
                                  }
                                }

                              },
                              onDateLongPressed: (DateTime datetime) {
                                // Do something
                              },
                              onWeekChanged: () {
                                // Do something
                              },
                              dateStyle: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400),
                              dayOfWeekStyle: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400),
                              weekendsStyle: const TextStyle(color: Colors.red,fontSize: 14,fontWeight: FontWeight.w400),
                              marginMonth: const EdgeInsets.symmetric(vertical: 12,horizontal: 18),
                              monthViewBuilder: (DateTime time) => Align(
                                alignment: FractionalOffset.centerLeft,
                                child: Container(
                                    margin: const EdgeInsets.symmetric(vertical: 4,horizontal: 18),
                                    child: Text(
                                      DateFormat.yMMMM().format(time),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: black, fontWeight: FontWeight.w400, overflow: TextOverflow.ellipsis,
                                      ),
                                    )),
                              ),
                              decorations: listCalenderEvents,
                            ),
                          ),
                          Container(
                            color: lightPink,
                            child: Column(
                              children: [
                                Visibility(
                                  visible: value.response.upcomingClasses?.isNotEmpty ?? false,
                                  child: Column(
                                    children: [
                                      Container(height: 18,),
                                      Container(
                                        padding: const EdgeInsets.only(left: 18, right: 18),
                                        alignment: Alignment.centerLeft,
                                        child: const Text("Upcoming Lecture",
                                          style: TextStyle(fontSize: 16, color: black,fontWeight: FontWeight.w800),),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(height: 16,),
                                SizedBox(
                                  height: 135,
                                  child: PageView.builder(
                                    itemCount: value.response.upcomingClasses?.length,
                                    scrollDirection: Axis.horizontal,
                                    controller: controller,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: ( context, index) {
                                      var getSet =  value.response.upcomingClasses?[index];
                                      return Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(left: 12,right: 22),
                                            padding: const EdgeInsets.all(12),
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
                                                Text(getSet?.moduleDetails?.name ?? "",style: const TextStyle(color: black,fontSize: 16,fontWeight: FontWeight.w600),),
                                                const Gap(8),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Text("By ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                                    const Text(" : ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                                    Text("${getSet?.session1FacultyName} and ${getSet?.session2FacultyName}",
                                                      style: const TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                                const Gap(18),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          Image.asset('assets/images/ic_calender.png', width: 22,height: 22,),
                                                          Container(width: 10,),
                                                          Text("${getSet?.date}",style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400),),                                                    ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          Image.asset('assets/images/ic_clock.png', width: 22,height: 22,),
                                                          Container(width: 10,),
                                                          Text("${getSet?.startTime} onwards",style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400),),                                                    ],
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(right: 8,top: 8),
                                            child: Stack(
                                              alignment: Alignment.topCenter,
                                              children: [
                                                Image.asset('assets/images/ic_class_tag.png',width: 130,height: 50,),
                                                Container(
                                                  margin: const EdgeInsets.only(top: 10),
                                                    child: Text(getSet?.classNoFormat ?? "",style: const TextStyle(color: lightPinkText,fontSize: 14,fontWeight: FontWeight.w400),)),
                                              ],
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                value.response.upcomingClasses!.length > 1
                                    ? Container(
                                        alignment: Alignment.bottomCenter,
                                        margin: const EdgeInsets.all(18),
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
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                          Container(
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
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 18, right: 18),
                            alignment: Alignment.centerLeft,
                            child: const Text("Resource Center",
                              style: TextStyle(fontSize: 16, color: black,fontWeight: FontWeight.w600),),
                          ),
                          Container(height: 12,),
                          SizedBox(
                            height: 120,
                            child: ListView.builder(
                              itemCount: listModule.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: ( context, index) {
                                var getSet = listModule[index];
                                return Container(
                                  width: 260,
                                  margin: const EdgeInsets.only(left: 18),
                                  child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    startActivity(context, ResourceCenterClassScreen(getSet,false));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 12),
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Icon(Icons.folder_copy_outlined,size: 26,),
                                        const Gap(12),
                                        Text(getSet.moduleName.toString(),style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400),)
                                      ],
                                    ),
                                  ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(height: 12,),
                          Container(
                            padding: const EdgeInsets.only(left: 18, right: 18),
                            alignment: Alignment.centerLeft,
                            child: const Text("Submission",
                              style: TextStyle(fontSize: 16, color: black,fontWeight: FontWeight.w600),),
                          ),
                          Container(height: 12,),
                          SizedBox(
                            height: 120,
                            child: ListView.builder(
                              itemCount: listModule.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: ( context, index) {
                                var getSet = listModule[index];
                                return Container(
                                  width: 260,
                                  margin: const EdgeInsets.only(left: 18),
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      startActivity(context, ResourceCenterClassScreen(getSet, true));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 12),
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Icon(Icons.folder_copy_outlined,size: 26,),
                                          const Gap(12),
                                          Text(getSet.moduleName.toString(),style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400),)
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Visibility(
                            visible: value.response.upcomingEvents!.isNotEmpty,
                            child: Column(
                              children: [
                                Container(height: 12,),
                                Container(
                                  padding: const EdgeInsets.only(left: 18, right: 18),
                                  alignment: Alignment.centerLeft,
                                  child: const Text("Upcoming Events",
                                    style: TextStyle(fontSize: 16, color: black,fontWeight: FontWeight.w600),),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: value.response.upcomingEvents!.isNotEmpty,
                            child: Container(
                              margin: EdgeInsets.only(top: 12),
                              height: 290,
                              child: AnimationLimiter(
                                child: ListView.builder(
                                  itemCount: value.response.upcomingEvents?.length,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: ( context, index) {
                                    return Container(
                                      margin: const EdgeInsets.only(left: 18),
                                      child: AnimationConfiguration.staggeredList(
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
                                                padding: const EdgeInsets.only(bottom: 18.0,),
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
                                                      CachedNetworkImage(
                                                          imageUrl: "${value.response.upcomingEvents?[index].bannerImage}&h=500&zc=2",
                                                          fit: BoxFit.cover,
                                                          width : 290,
                                                          height: 200,
                                                          errorWidget: (context, url, error) => Container(
                                                            color: grayNew,
                                                            width : 290,
                                                            height: 200,
                                                          ),
                                                          placeholder: (context, url) => Container(
                                                            color: grayNew,
                                                            width : 290,
                                                            height: 200,
                                                          )
                                                      ),
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
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 18, right: 18),
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
                                            child: Container(
                                              decoration:  BoxDecoration(
                                                border: Border.all(color: white, width: 0.5),
                                                borderRadius:const BorderRadius.all(Radius.circular(8),) ,
                                                color: white,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(0.0),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: const BorderRadius.only(
                                                          topRight: Radius.circular(8.0),
                                                          topLeft: Radius.circular(8.0)),
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
                                                            style: const TextStyle(fontSize: 14, color: black,fontWeight: FontWeight.w500),),
                                                          Container(height: 8,),
                                                          Text(getSet.tagLine ?? "",
                                                            style: const TextStyle(fontSize: 12, color: black,fontWeight: FontWeight.w400),),
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
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Container(height: 18,),
                          Container(
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
                                    style: TextStyle(fontSize: 14, color: black,fontWeight: FontWeight.w400),),
                                ),
                              ],
                            ),
                          ),
                          Container(height: 12,),
                          Container(
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
                                return Container(
                                  width: 140,
                                  margin: EdgeInsets.only(left: 18),
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      var videoUrl = '';
                                      for (var i=0; i < (getSet.mediaList?.length ?? 0); i++)
                                        {
                                          videoUrl = getSet.mediaList?[i].path ?? '';
                                        }
                                       // startActivity(context, VideoProjectWidget(url: videoUrl, play: true));
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
                                                width: 95,
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
                                          style: const TextStyle(fontSize: 14, color: black,fontWeight: FontWeight.w500,overflow: TextOverflow.clip),
                                          overflow: TextOverflow.clip,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(height: 18,),
                          Padding(
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
                                        margin: const EdgeInsets.only(right: 4, top: 8),
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
                                  Container(width: 4,),
                                  Expanded(
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () async {
                                        startActivity(context, const TestimonialsScreen());
                                      },
                                      child: Container(
                                        decoration:  BoxDecoration(
                                          border: Border.all(color: white, width: 0.5),
                                          borderRadius:const BorderRadius.all(Radius.circular(8),) ,
                                          color: white,
                                        ),
                                        height: 180,
                                        margin: const EdgeInsets.only(right: 4, top: 8),
                                        child: Stack(
                                          children:  [
                                            // Text(getSet.unibharGiven.toString(),
                                            //   style: const TextStyle(fontSize: 24, color: blue,fontWeight: FontWeight.w500),),
                                            /*ClipRRect(
                                              borderRadius: BorderRadius.circular(8.0),
                                              child: Image.asset("assets/images/ic_holiday.jpg",
                                                fit: BoxFit.cover,
                                                height: 180,
                                                width: MediaQuery.of(context).size.width,
                                              ),
                                            ),*/
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
                                              child: Text('Testimonials',
                                                style: TextStyle(fontSize: 16, color:black,fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          Container(height: 18,),
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Text("Lectures" ,
                                  style: TextStyle(fontSize: 14, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
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
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          startActivity(context, const EventsScreen());
                        },
                        child:  Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Text("Events" ,
                                  style: TextStyle(fontSize: 14, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
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
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          startActivity(context, const ResourceCenterScreen());
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Text("Resource Center" ,
                                  style: TextStyle(fontSize: 14, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
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
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          startActivity(context, const HolidayScreen());
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Padding(
                               padding: EdgeInsets.all(6.0),
                              child: Text("Holiday" ,
                                  style: TextStyle(fontSize: 14, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
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
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          startActivity(context, const CaseStudyScreen());
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Text("Case Study" ,
                                  style: TextStyle(fontSize: 14, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
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
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          startActivity(context, const TestimonialsScreen());
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Text("Testimonials" ,
                                  style: TextStyle(fontSize: 14, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
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
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          startActivity(context, const ManagementScreen());
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Text("Management" ,
                                  style: TextStyle(fontSize: 14, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
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
                ],
              ),
            );
          },
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
      'student_id': "",
      'from_app' : FROM_APP
    };
    var moduleViewModel = Provider.of<ModuleViewModel>(context,listen: false);
    await moduleViewModel.getModuleList(jsonBody);

    if (moduleViewModel.response.success == '1')
    {
      listModule = moduleViewModel.response.list ?? [];
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
      listTestimonials.addAll(_tempList!);

      print(listTestimonials.length);

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

        for(int i=0;i<listUpcomingLectures.length;i++)
          {
            var setDecoration = DecorationItem(
              date: DateFormat('dd-MM-yyyy').parse(listUpcomingLectures[i].date.toString()),
              decoration: const Icon(Icons.circle,color: Colors.red,),
            );
            listCalenderEvents.add(setDecoration);
          }

        for(int i=0;i<listUpcomingHolidays.length;i++)
          {
            var setDecoration = DecorationItem(
              date: DateFormat('dd-MM-yyyy').parse(listUpcomingHolidays[i].holidayDate.toString()),
              decoration: const Icon(Icons.holiday_village,color: Colors.red,),
            );
            listCalenderEvents.add(setDecoration);
          }
      });
    }
    else  if (userViewModel.response.success == '0')
    {

    }

  }

}