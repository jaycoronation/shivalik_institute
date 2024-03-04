import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common_widget/common_widget.dart';
import '../constant/colors.dart';
import '../utils/base_class.dart';

class MediaScreen extends StatefulWidget {

  const MediaScreen({super.key});

  @override
  BaseState<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends BaseState<MediaScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
        child: Scaffold(
          backgroundColor: grayButton,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: grayButton,
            leading: InkWell(
              borderRadius: BorderRadius.circular(52),
              onTap: () {
                Navigator.pop(context);
              },
              child: getBackArrow(),
            ),
            centerTitle: true,
            title: Container(
              decoration: BoxDecoration(
                  color: grayLight,
                  borderRadius: BorderRadius.circular(8)
              ),
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: PreferredSize(
                preferredSize: Size(100, 60),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Colors.transparent,
                  labelColor: black,
                  // padding: EdgeInsets.all(14),
                  indicatorPadding: EdgeInsets.only(top: 6.0, bottom: 6, right: 0, left: 0),
                  indicatorWeight: 4.0,
                  labelStyle: TextStyle(color: brandColor, fontSize: 12, fontWeight: FontWeight.w600),
                  // labelPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                  isScrollable: true,
                  unselectedLabelColor: black,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  tabs: const [
                    Tab(text: 'Media', ),
                    Tab(text: 'Docs',),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                     Text("media")
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text("pdf")
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }

  @override
  void castStatefulWidget() {
   widget is MediaScreen;
  }

}