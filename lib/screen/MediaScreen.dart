import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';

import '../common_widget/common_widget.dart';
import '../constant/colors.dart';
import '../utils/base_class.dart';

class MediaScreen extends StatefulWidget {

  const MediaScreen({super.key});

  @override
  BaseState<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends BaseState<MediaScreen> {
  final ScrollController scrollViewController = ScrollController();


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
              height: 38,
              decoration: BoxDecoration(
                  color: grayLight,
                  borderRadius: BorderRadius.circular(8)
              ),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: PreferredSize(
                preferredSize: Size(100, 60),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Colors.transparent,
                  labelColor: black,
                  indicatorPadding: EdgeInsets.only(top: 6.0, bottom: 6, right: 0, left: 0),
                  indicatorWeight: 4.0,
                  labelStyle: TextStyle(color: brandColor, fontSize: 14, fontWeight: FontWeight.w500),
                  labelPadding: EdgeInsets.only(left: 12.0, right: 12.0, top: 4, bottom: 4),
                  isScrollable: true,
                  unselectedLabelColor: black,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
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
                      GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              crossAxisCount: 4,
                              mainAxisExtent: 100
                          ),
                          itemCount: 4,
                          itemBuilder: (BuildContext ctx, index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 600),
                              child: SlideAnimation(
                                verticalOffset: 100.0,
                                child: FadeInAnimation(
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: (){},
                                    child: Container(
                                      height: 50,
                                      // width: 110,
                                      color: grayLight,
                                    )
                                  ),
                                ),
                              ),
                            );
                          }
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child:  ListView.builder(
                    controller: scrollViewController,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          //startActivity(context, ModuleDetailsScreen(getSet));
                        },
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset('assets/images/ic_file.png', width: 55, height: 55,),
                                  Gap(12),
                                  Text('File name',style: const TextStyle(color: black,fontWeight: FontWeight.w400,fontSize: 14),),
                                ],
                              ),
                              Gap(12),
                              Divider(
                                height: 1,
                                thickness: 1,
                                color: grayLight,
                              )
                            ],
                          ),
                        ),
                      );
                    },
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