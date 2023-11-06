import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:gap/gap.dart';
import 'package:shivalik_institute/constant/colors.dart';
import 'package:shivalik_institute/screen/LectureScreen.dart';

import '../common_widget/common_widget.dart';
import '../model/ModuleResponseModel.dart';
import '../utils/base_class.dart';

class ModuleDetailsScreen extends StatefulWidget {
  final ModuleList getSet;
  const ModuleDetailsScreen(this.getSet, {super.key});

  @override
  BaseState<ModuleDetailsScreen> createState() => _ModuleListScreenState();
}

class _ModuleListScreenState extends BaseState<ModuleDetailsScreen> {

  ModuleList getSet = ModuleList();
  ExpandedTileController _controller = ExpandedTileController(isExpanded: false);
  ExpandedTileController _controllerNew = ExpandedTileController(isExpanded: false);

  @override
  void initState(){
    super.initState();
    getSet = (widget as ModuleDetailsScreen).getSet;
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
                    title: const Text("Topic",style: TextStyle(color: black,fontSize: 16,fontWeight: FontWeight.w500),),
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
                  Row(
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
                  )
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
}