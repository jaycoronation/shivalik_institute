import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shivalik_institute/constant/colors.dart';
import 'package:shivalik_institute/screen/LectureScreen.dart';

import '../common_widget/common_widget.dart';
import '../common_widget/loading.dart';
import '../model/LecturesResponseModel.dart';
import '../model/ModuleResponseModel.dart';
import '../utils/base_class.dart';
import '../viewmodels/LectureViewModel.dart';

class ModuleDetailsScreen extends StatefulWidget {
  final ModuleList getSet;
  const ModuleDetailsScreen(this.getSet, {super.key});

  @override
  BaseState<ModuleDetailsScreen> createState() => _ModuleListScreenState();
}

class _ModuleListScreenState extends BaseState<ModuleDetailsScreen> {
  List<LectureList> listLecture = [];
  late ScrollController _scrollViewController;
  ModuleList getSet = ModuleList();
  String selectedFaculty = '';
  String selectedFacultyId = '';
  int _pageIndex = 1;
  final int _pageResult = 10;
  String fromDateApi = "";
  String toDateApi = "";
  String selectedDateFilter = "Today";
  String dateSelectionChanged = "";
  String fromDateDisplay = "";
  String toDateDisplay = "";
  bool _isLastPage = false;
  bool _isLoadingMore = false;
  ModuleList moduleGetSet = ModuleList();
  ExpandedTileController _controller = ExpandedTileController(isExpanded: false);
  ExpandedTileController _controllerNew = ExpandedTileController(isExpanded: false);

  @override
  void initState(){
    super.initState();
    getSet = (widget as ModuleDetailsScreen).getSet;
    getLectureList(true);
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
                Navigator.pop(context);
              },
              child: getBackArrow(),
            ),
            titleSpacing: 0,
            centerTitle: false,
            title: getTitle("Modules Details",),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(getSet.moduleName ?? '',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: black),),
                      Text("${getSet.duration}hr",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: black),),
                    ],
                  ),
                  const Gap(12),
                  Text(getSet.description ?? '',style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: black),),
                  const Gap(12),
                  ExpandedTile(
                    theme: ExpandedTileThemeData(
                      headerColor: grayNew,
                      headerRadius: 6.0,
                      headerPadding: const EdgeInsets.all(8.0),
                      headerSplashColor: Colors.black.withOpacity(0.4),
                      contentBackgroundColor: white,
                      contentPadding: const EdgeInsets.all(12.0),
                      contentRadius: 6.0,
                    ),
                    controller: _controller,
                    title: const Text("Topic", style: TextStyle(color: black,fontSize: 16,fontWeight: FontWeight.w500),),
                    content: MediaQuery.removePadding(
                      context: context,
                      removeBottom: true,
                      removeTop: true,
                      child: ListView.builder(
                        itemCount: getSet.topics?.length ?? 0,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(getSet.topics?[index].title ?? "",style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400),),
                            );
                          },
                      ),
                    ),
                    onTap: () {
                      debugPrint("tapped!!");
                    },
                    onLongTap: () {
                      debugPrint("long tapped!!");
                    },
                  ),
                  const Gap(12),
                  ExpandedTile(
                    theme: ExpandedTileThemeData(
                      headerColor: grayNew,
                      headerRadius: 6.0,
                      headerPadding: const EdgeInsets.all(8.0),
                      headerSplashColor: Colors.black.withOpacity(0.4),
                      contentBackgroundColor: white,
                      contentPadding: const EdgeInsets.all(12.0),
                      contentRadius: 6.0,
                    ),
                    controller: _controllerNew,
                    title: const Text("Activities",style: TextStyle(color: black,fontSize: 16,fontWeight: FontWeight.w500),),
                    content: MediaQuery.removePadding(
                      context: context,
                      removeBottom: true,
                      removeTop: true,
                      child: ListView.builder(
                        itemCount: getSet.activities?.length ?? 0,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(getSet.activities?[index].title ?? "",style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400),),
                          );
                        },
                      ),
                    ),
                    onTap: () {
                      debugPrint("tapped!!");
                    },
                    onLongTap: () {
                      debugPrint("long tapped!!");
                    },
                  ),
                  const Gap(12),
                  const Text('Lectures',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: black),),
                  const Gap(12),
                 /* Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
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
                            startActivity(context, LectureScreen(getSet,"upcoming_class"));
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(top: 10,bottom: 10),
                            child: Text(
                              "Upcoming",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16, color: white, fontWeight: FontWeight.w400),
                            ),
                          )
                        )
                      ),
                      const Gap(12),
                      Expanded(
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
                                startActivity(context, LectureScreen(getSet,"completed_class"));
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(top: 10,bottom: 10),
                                child: Text(
                                  "Completed",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16, color: white, fontWeight: FontWeight.w400),
                                ),
                              )
                          )
                      ),
                      const Gap(12),
                      Expanded(
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
                                startActivity(context, LectureScreen(getSet,"today"));
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(top: 10,bottom: 10),
                                child: Text(
                                  "Today",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16, color: white, fontWeight: FontWeight.w400),
                                ),
                              )
                          )
                      ),
                    ],
                  ),*/

                  Consumer<LectureViewModel>(
                    builder: (context, value, child) {
                      if ((value.isLoading) && (_isLoadingMore == false))
                      {
                        return const LoadingWidget();
                      }
                      else
                      {
                        return ListView.builder(
                          // controller: _scrollViewController,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: listLecture.length ?? 0,
                          itemBuilder: (context, index) {
                            var getSet = listLecture[index];
                            return Container(
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
                                        child: Text(getSet?.classNoFormat ?? "",style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                        child: Text("${getSet?.date} ${getSet.startTime} - ${getSet.endTime}",
                                          style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                        child: Text(getSet.moduleDetails?.name ?? "",style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                        child: Text("${getSet.session1FacultyName} ${getSet.session2FacultyName}",style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                        child: Text(getSet.isActive == "1" ? "Active" : "InActive",style: TextStyle(color: getSet.isActive == "1" ? Colors.green : Colors.red,fontSize: 14,fontWeight: FontWeight.w600),),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        onWillPop: () {
          Navigator.pop(context);
          return Future.value(true);
        },
    );
  }

  @override
  void castStatefulWidget() {
    widget is ModuleDetailsScreen;
  }

  Future<void> getLectureList(bool isFirstTime) async {
    if (isFirstTime) {
      setState(() {
        _isLoadingMore = false;
        _pageIndex = 1;
        _isLastPage = false;
      });
    }

    Map<String, String> jsonBody = {
      'batch_id': "",
      'faculty_id': selectedFacultyId,
      'filter': '',
      'filter_by_class_status': "",
      'filter_name': "Filter",
      'from_date_filter': fromDateApi,
      'to_date_filter': toDateApi,
      'module_id': moduleGetSet.id ?? '',
      'limit': _pageResult.toString(),
      'page': _pageIndex.toString(),
      'search': "",
      'status': "1",
      'total': "0",
      'student_id': sessionManager.getUserId().toString(),
    };
    var moduleViewModel = Provider.of<LectureViewModel>(context,listen: false);
    await moduleViewModel.getModuleList(jsonBody);

    if (moduleViewModel.response.success == "1")
    {
      List<LectureList>? _tempList = [];
      _tempList = moduleViewModel.response.lectureList;
      listLecture?.addAll(_tempList!);

      print(listLecture?.length);

      if (_tempList?.isNotEmpty ?? false) {
        _pageIndex += 1;
        if (_tempList?.isEmpty ?? false || _tempList!.length % _pageResult != 0 ) {
          _isLastPage = true;
        }
      }

      // listLecture = moduleViewModel.response.lectureList ?? [];
    }

  }

}