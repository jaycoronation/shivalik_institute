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
import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../model/CaseStudyResponseModel.dart';
import '../model/DashboardResponseModel.dart';
import '../model/EventResponseModel.dart';
import '../model/LecturesResponseModel.dart';
import '../model/ModuleResponseModel.dart';
import '../utils/base_class.dart';
import '../viewmodels/CaseStudyViewModel.dart';
import '../viewmodels/DashboardViewModel.dart';
import '../viewmodels/ModuleViewModel.dart';
import '../viewmodels/UserViewModel.dart';
import 'CaseStudyDetailScreen.dart';
import 'EventDetailsScreen.dart';
import 'MyProfleScreen.dart';
import '../common_widget/no_data_new.dart';
import 'ResourceCenterClassScreen.dart';
import '../model/UserProfileResponseModel.dart';


class DashboardScreen extends StatefulWidget {

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

  Details getSet = Details();

  @override
 void initState() {
    getUserData();
    getModuleData();
    getCaseStudyList(true);
    getDashboardData();
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
                          SizedBox(
                            height: 150,
                            child: CalendarWeek(
                              controller: CalendarWeekController(),
                              height: 100,
                              showMonth: true,
                              minDate: DateTime.now(),
                              maxDate: DateTime.now().add(
                                const Duration(days: 365),
                              ),
                              onDatePressed: (DateTime datetime) {
                                // Do something
                              },
                              onDateLongPressed: (DateTime datetime) {
                                // Do something
                              },
                              onWeekChanged: () {
                                // Do something
                              },
                              monthViewBuilder: (DateTime time) => Align(
                                alignment: FractionalOffset.center,
                                child: Container(
                                    margin: const EdgeInsets.symmetric(vertical: 4),
                                    child: Text(
                                      DateFormat.yMMMM().format(time),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.blue, fontWeight: FontWeight.w600),
                                    )),
                              ),
                              decorations: [
                                DecorationItem(
                                    decorationAlignment: FractionalOffset.bottomRight,
                                    date: DateTime.now(),
                                    decoration: const Icon(
                                      Icons.today,
                                      color: Colors.blue,
                                    )
                                ),
                                DecorationItem(
                                    date: DateTime.now().add(const Duration(days: 3)),
                                    decoration: const Text(
                                      'Holiday',
                                      style: TextStyle(
                                        color: Colors.brown,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          Visibility(
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
                            child: ListView.builder(
                              itemCount: value.response.upcomingClasses?.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
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
                          Container(
                            margin: const EdgeInsets.only(left: 16, right: 10,),
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
                                                  fontSize: 24, color: Colors.green,fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const Text(' / ',
                                                  style: TextStyle(fontSize: 24, color:black,fontWeight: FontWeight.w500),
                                                  textAlign: TextAlign.center
                                              ),
                                              Countup(
                                                begin: 0,
                                                end: double.parse(value.response.totalModules ?? "0"),
                                                duration: const Duration(seconds: 2),
                                                separator: ',',
                                                style: const TextStyle(
                                                    fontSize: 24, color: black,fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(top: 8.0, left: 4, right: 4),
                                            child: Text('Total Modules',
                                                style: TextStyle(fontSize: 14, color:black,fontWeight: FontWeight.w500),textAlign: TextAlign.center),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                               /* Container(width: 4,),
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
                                ),*/
                              ],
                            ),
                          ),
                          Container(height: 20,),
                          Container(
                            padding: const EdgeInsets.only(left: 18, right: 18),
                            alignment: Alignment.centerLeft,
                            child: const Text(" Resource Center",
                              style: TextStyle(fontSize: 16, color: black,fontWeight: FontWeight.w600),),
                          ),
                          Container(height: 12,),
                          SizedBox(
                            height: 140,
                            child: ListView.builder(
                              itemCount: listModule.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: ( context, index) {
                                var getSet = listModule[index];
                                return Container(
                                  width: 150,
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
                                        const Icon(Icons.folder_copy_outlined,size: 28,),
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
                            height: 140,
                            child: ListView.builder(
                              itemCount: listModule.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: ( context, index) {
                                var getSet = listModule[index];
                                return Container(
                                  width: 150,
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
                                          const Icon(Icons.folder_copy_outlined,size: 28,),
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
                          Container(height: 12,),
                          Visibility(
                            visible: value.response.upcomingEvents!.isNotEmpty,
                            child: SizedBox(
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
                          Container(height: 18,),
                          Container(
                            padding: const EdgeInsets.only(left: 18, right: 18),
                            alignment: Alignment.centerLeft,
                            child: const Text(" Case Study",
                              style: TextStyle(fontSize: 16, color: black,fontWeight: FontWeight.w600),),
                          ),
                          Container(height: 12,),
                          SizedBox(
                            height: 286,
                            child: AnimationLimiter(
                              child: PageView.builder(
                                itemCount:  listCaseStudy.length,
                                scrollDirection: Axis.horizontal,
                                // shrinkWrap: true,
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
                                              // padding: const EdgeInsets.only(bottom: 12.0,),
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
                                                    Container(height: 12,),
                                                    Text(getSet.title ?? "",
                                                      style: const TextStyle(fontSize: 14, color: black,fontWeight: FontWeight.w500),),
                                                    Container(height: 8,),
                                                    Text(getSet.tagLine ?? "",
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
                        child: const Column(
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
                        child: const Column(
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
                        child: const Column(
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
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                        child: const Column(
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
                        child: const Column(
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
                        child: const Column(
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
      listCaseStudy?.addAll(_tempList!);

      print(listCaseStudy?.length);


      if (_tempList?.isNotEmpty ?? false) {
        _pageIndex += 1;
        if (_tempList?.isEmpty ?? false || _tempList!.length % _pageResult != 0 ) {
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
    else  if (userViewModel.response.success == '0')
    {

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

      });
    }
    else  if (userViewModel.response.success == '0')
    {

    }

  }

}