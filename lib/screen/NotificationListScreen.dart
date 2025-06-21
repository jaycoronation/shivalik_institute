import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shivalik_institute/common_widget/loading.dart';
import 'package:shivalik_institute/common_widget/placeholder.dart';
import 'package:shivalik_institute/constant/api_end_point.dart';
import 'package:shivalik_institute/constant/colors.dart';
import 'package:shivalik_institute/constant/global_context.dart';
import 'package:shivalik_institute/model/EventResponseModel.dart';
import 'package:shivalik_institute/model/LecturesResponseModel.dart';
import 'package:shivalik_institute/model/ModuleResponseModel.dart';
import 'package:shivalik_institute/screen/EventDetailsScreen.dart';
import 'package:shivalik_institute/screen/FacultyProfileScreen.dart';
import 'package:shivalik_institute/screen/LectureDetailsScreen.dart';
import 'package:shivalik_institute/screen/ResourceMaterialScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common_widget/common_widget.dart';
import '../common_widget/loading_more.dart';
import '../model/NotificationListResponseModel.dart';
import '../utils/app_utils.dart';
import '../utils/base_class.dart';
import '../viewmodels/UserViewModel.dart';
import 'MaterialDetailScreen.dart';
import 'package:to_do_package_shivalik/screens/todo_list_screen.dart';
import 'package:to_do_package_shivalik/screens/todo_detail_screen.dart';
import 'package:to_do_package_shivalik/model/todo_list_data_response_model.dart';

class NotificationListScreen extends StatefulWidget {
  const NotificationListScreen({super.key});

  @override
  BaseState<NotificationListScreen> createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends BaseState<NotificationListScreen> {

  bool isLoading = false;
  List<Notifications> listNotifications = [];
  late ScrollController _scrollViewController;
  bool isScrollingDown = false;
  bool _isLastPage = false;
  bool _isLoadingMore = false;
  int _pageIndex = 1;
  final int _pageResult = 10;

  @override
  void initState(){
    notificationListApi(true);

    _scrollViewController = ScrollController();
    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection == ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          //setState(() {});
        }
      }
      if (_scrollViewController.position.userScrollDirection == ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          //setState(() {});
        }
      }
      pagination();
    });

    super.initState();
  }

  void pagination() {
    var maxScroll = _scrollViewController.position.maxScrollExtent - 200;

    if (!_isLastPage && !_isLoadingMore)
    {
      if ((_scrollViewController.position.pixels >= maxScroll))
      {
        setState(() {
          print("is loading == ${((!_isLoadingMore))}");
          _isLoadingMore = true;
          notificationListApi(false);
        });
      }
    }
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
                Navigator.pop(context, true);
              },
              child: getBackArrow(),
            ),
            titleSpacing: 0,
            centerTitle: false,
            title: getTitle("Notification",),
          ),
          body: isLoading
              ? Shimmer.fromColors(
                  baseColor: Colors.grey.shade100 ,
                  highlightColor: Colors.grey.shade400,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 6, 12, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Container(
                                height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.grey.shade500,
                                          width: 0.8
                                      )
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(12.0),
                                  ),
                                ),
                                const Gap(12),
                                Expanded(
                                    child: Column(
                                      children: [
                                          SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                                          const Gap(8),
                                          SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                                          const Gap(8),
                                          SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                                          const Gap(8),
                                          SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                                          const Gap(8),
                                          SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                                          const Gap(8),
                                          SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                                      ],
                                  )
                                )
                            ],
                          ),
                          const Gap(12),
                          const Divider(color: grayDark,thickness: 0.5,height: 0.7,),
                          const Gap(12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Container(
                                height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.grey.shade500,
                                          width: 0.8
                                      )
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(12.0),
                                  ),
                                ),
                                const Gap(12),
                                Expanded(
                                    child: Column(
                                      children: [
                                          SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                                          const Gap(8),
                                          SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                                          const Gap(8),
                                          SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                                          const Gap(8),
                                          SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                                          const Gap(8),
                                          SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                                          const Gap(8),
                                          SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                                      ],
                                  )
                                )
                            ],
                          ),
                          const Gap(12),
                          const Divider(color: grayDark,thickness: 0.5,height: 0.7,),
                          const Gap(12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Container(
                                height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.grey.shade500,
                                          width: 0.8
                                      )
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(12.0),
                                    
                                  ),
                                ),
                                const Gap(12),
                                Expanded(
                                    child: Column(
                                      children: [
                                          SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                                          const Gap(8),
                                          SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                                          const Gap(8),
                                          SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                                          const Gap(8),
                                          SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                                          const Gap(8),
                                          SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                                          const Gap(8),
                                          SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                                      ],
                                  )
                                )
                            ],
                          ),
                          const Gap(12),
                          const Divider(color: grayDark,thickness: 0.5,height: 0.7,),
                          const Gap(12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.grey.shade500,
                                        width: 0.8
                                    )
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  
                                ),
                              ),
                              const Gap(12),
                              Expanded(
                                  child: Column(
                                    children: [
                                      SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                                      const Gap(8),
                                      SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                                      const Gap(8),
                                      SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                                      const Gap(8),
                                      SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                                      const Gap(8),
                                      SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                                      const Gap(8),
                                      SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                                    ],
                                  )
                              )
                            ],
                          ),
                          const Gap(12),
                          const Divider(color: grayDark,thickness: 0.5,height: 0.7,),
                          const Gap(12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.grey.shade500,
                                        width: 0.8
                                    )
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  
                                ),
                              ),
                              const Gap(12),
                              Expanded(
                                  child: Column(
                                    children: [
                                      SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                                      const Gap(8),
                                      SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                                      const Gap(8),
                                      SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                                      const Gap(8),
                                      SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                                      const Gap(8),
                                      SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                                      const Gap(8),
                                      SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                                    ],
                                  )
                              )
                            ],
                          ),
                          const Gap(12),
                          const Divider(color: grayDark,thickness: 0.5,height: 0.7,),
                          const Gap(12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.grey.shade500,
                                        width: 0.8
                                    )
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  
                                ),
                              ),
                              const Gap(12),
                              Expanded(
                                  child: Column(
                                    children: [
                                      SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                                      const Gap(8),
                                      SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                                      const Gap(8),
                                      SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                                      const Gap(8),
                                      SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                                      const Gap(8),
                                      SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                                      const Gap(8),
                                      SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                                    ],
                                  )
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              )
              : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: AnimationLimiter(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        controller: _scrollViewController,
                        itemCount: listNotifications.length,
                        physics: const ScrollPhysics(),
                        itemBuilder: (context, i) {
                        var getSet = listNotifications[i];
                          return AnimationConfiguration.staggeredList(
                            position: i,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    logFirebase('notification_clicked',{'content' : getSet.title});
                                    print(jsonEncode(getSet));
                                    if (getSet.operation == "event_scheduled")
                                      {
                                        NavigationService.notif_id = getSet.eventId ?? "";
                                        startActivity(context, EventsDetailsScreen(EventList()));
                                      }
                                    else if (getSet.operation == "lecture_complete")
                                      {
                                        //startActivity(context, LectureDetailsScreen(getSet.classId ?? ''));
                                      }
                                    else if (getSet.operation == "lecture_reminder")
                                      {
                                        startActivity(context, LectureDetailsScreen(getSet.classId ?? ''));
                                      }
                                    else if (getSet.operation == "lecture_scheduled")
                                      {
                                        startActivity(context, LectureDetailsScreen(getSet.classId ?? ''));
                                      }
                                    else if (getSet.operation == "material_uploaded")
                                      {
                                        print(jsonEncode(getSet));
                                        NavigationService.notif_id = getSet.classId ?? '';
                                        startActivity(context, MaterialDetailScreen(ModuleList(), LectureList()));
                                      }
                                    else if (getSet.operation == "pedning_fees_reminder")
                                      {
                                        getUserData();
                                      }
                                    else if (getSet.operation == "submission_reminder")
                                      {
                                        startActivity(context, ResourceMaterialScreen(ModuleList(), LectureList()));
                                      }
                                    else if (getSet.operation == "lecture_cancelled")
                                      {
                                        startActivity(context, LectureDetailsScreen(getSet.classId ?? ''));
                                      }
                                    else if (getSet.operation == "faculty_profile")
                                      {
                                        startActivity(context, FacultyProfileScreen(getSet.userId ?? ''));
                                      }
                                    else if(getSet.operation == "task_deleted" || getSet.operation == "removed_from_task_observation" || getSet.operation == "removed_from_task"){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  ToDoListScreen(
                                          AuthHeader,
                                          sessionManager.getUserId() ?? "",
                                          sessionManager.getUserId() ?? "",
                                          "${sessionManager.getName() ?? ""} ${sessionManager.getLastName() ?? ""}",
                                          sessionManager.getProfilePic() ?? ""
                                      )));
                                    }
                                    else if(getSet.operation == "new_task_assigned" || getSet.operation == "observer_assigned_to_task" || getSet.operation == "task_update" || getSet.operation == "daily_task_summary" || getSet.operation == "task_comment"){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ToDoDetailScreen(
                                            TodoList(), const [], true,false,getSet.task_id ?? "",userId:  sessionManager.getUserId() ?? "",AuthHeader,
                                            userProfile: sessionManager.getProfilePic() ?? "",
                                            name: "${sessionManager.getName() ?? ""} ${sessionManager.getLastName() ?? ""}", filterProjectList: [],
                                          )
                                      ));
                                    }
                                    },
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(12, 6, 12, 0),
                                    child: Column(
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 60,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.shade200,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: Colors.grey.shade500,
                                                      width: 0.8
                                                    )
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(12.0),
                                                    child: Image.asset("assets/images/ic_logo_only.png",width: 40,height: 40),
                                                  ),
                                                ),
                                                const Gap(12),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(getSet.message ?? "", style: const TextStyle(fontSize: 14,color: black,fontWeight: FontWeight.w500),),
                                                      const Gap(8),
                                                      Text(getSet.time.toString().contains("/")
                                                          ? universalDateConverter("dd/MM/yyyy", "dd MMM,yyyy", getSet.time.toString())
                                                          : getSet.time ?? "", style: const TextStyle(color: grayDarkNew,fontWeight: FontWeight.w400, fontSize: 12),),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),

                                          ],
                                        ),
                                        Container(height: 8),
                                        const Divider(color: grayDark,thickness: 0.5,height: 0.7,)
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
                  Visibility(
                      visible: _isLoadingMore,
                      child: const LoadingMoreWidget()
                  )
                ],
              ),
        ),
        onWillPop: () {
          Navigator.pop(context);
          return Future.value(true);
        },
    );
  }

  Future<void> getUserData() async {
    setState(() {
      isLoading = true;
    });
    Map<String, String> jsonBody = {
      'user_id':sessionManager.getUserId() ?? '',
      "user_type":'3'
    };

    UserViewModel userViewModel = Provider.of<UserViewModel>(context,listen: false);
    await userViewModel.getUserDetails(jsonBody);

    if (userViewModel.response.success == '1')
    {
      String paymentLink = userViewModel.response.details?.paymentLink ?? '';
      if (await canLaunchUrl(Uri.parse(paymentLink)))
        {
          launchUrl(Uri.parse(paymentLink),mode: LaunchMode.externalApplication);
        }
    }
    else
    {
    }

  }

  notificationListApi(bool isFirstTime) async {
    if (isFirstTime) {
      setState(() {
        isLoading = true;
        _pageIndex = 1;
        _isLastPage = false;
      });
    }

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(notificationList);

    Map<String, String> jsonBody = {
      'user_id': sessionManager.getUserId() ?? '',
      'page': _pageIndex.toString(),
      'limit': _pageResult.toString(),
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> apiResponse = jsonDecode(body);
    var dataResponse = NotificationListResponseModel.fromJson(apiResponse);
    if (statusCode == 200 && dataResponse.success == 1) {
      setState(() {
      List<Notifications> _tempList = [];
      _tempList = dataResponse.notifications ?? [];
      listNotifications.addAll(_tempList);

      print(listNotifications.length);

      if (_tempList.isNotEmpty) {
        _pageIndex += 1;
        if (_tempList.isEmpty || _tempList.length % _pageResult != 0 ) {
          _isLastPage = true;
        }
      }
      print("IS LAST PAGE === $_isLastPage");

      });
    } else {

    }
    setState(() {
      isLoading = false;
      _isLoadingMore = false;
    });
  }

  @override
  void castStatefulWidget() {
    widget is NotificationListScreen;
  }
}