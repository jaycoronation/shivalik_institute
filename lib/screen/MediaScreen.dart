import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';
import 'package:shivalik_institute/common_widget/no_data_new.dart';
import 'package:shivalik_institute/utils/full_screen_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common_widget/common_widget.dart';
import '../constant/colors.dart';
import '../utils/base_class.dart';

class MediaScreen extends StatefulWidget {

  const MediaScreen({super.key});

  @override
  BaseState<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends BaseState<MediaScreen> {

  List<String> listMedia = [];
  List<Reference> listDocument = [];
  List<String> imageUrls = [];


  int totalMediaCount = 0;
  int totalDocumentCount = 0;

  @override
  void initState(){
    super.initState();
    getMediaFolder();
    getDocumentFolder();
  }

  Future<void> getDocumentFolder() async {
    final Reference storageRef = FirebaseStorage.instance.ref().child('SIRE').child(sessionManager.getBatchId() ?? '').child('Document');
    storageRef.listAll().then((result) {

      setState(() {
        final List<Reference> allFiles = result.items;
        totalMediaCount += allFiles.length;
        listDocument = allFiles;
        print("result is ${allFiles.length}");
      });
    });
  }

  Future<void> getMediaFolder() async {
    try {
      final Reference storageRef = FirebaseStorage.instance.ref().child('SIRE').child(sessionManager.getBatchId() ?? '').child('Media');
      final ListResult result = await storageRef.listAll();
      final List<Reference> allImages = result.items;
      final List<String> urls = await Future.wait(allImages.map((ref) => ref.getDownloadURL()));
      setState(() {
        listMedia = urls;
      });
    } catch (e) {
      print("Error fetching images: $e");
      // Handle error appropriately, e.g., show error message to user
    }
  }

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
            backgroundColor: white,
            leading: InkWell(
              borderRadius: BorderRadius.circular(52),
              onTap: () {
                Navigator.pop(context);
              },
              child: getBackArrow(),
            ),
            centerTitle: false,
            title: Container(
              height: 38,
              decoration: BoxDecoration(
                  color: grayLight,
                  borderRadius: BorderRadius.circular(8)
              ),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: PreferredSize(
                preferredSize: Size(100, 50),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Colors.transparent,
                  labelColor: black,
                  indicatorPadding: const EdgeInsets.only(top: 6, bottom: 6),
                  indicatorWeight: 4.0,
                  labelStyle: const TextStyle(color: brandColor, fontSize: 14, fontWeight: FontWeight.w500),
                  labelPadding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 4),
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
                child: listMedia.isEmpty ? MyNoDataNewWidget(msg: "No Media uploaded yet", img: ''): SingleChildScrollView(
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          crossAxisCount: 4,
                          mainAxisExtent: 100
                      ),
                      itemCount: listMedia.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 600),
                          child: SlideAnimation(
                            verticalOffset: 100.0,
                            child: FadeInAnimation(
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: (){

                                  startActivityAnimation(context, FullScreenImage(listMedia[index], [], 0));
                                },
                                child: Container(
                                  height: 50,
                                  color: grayLight,
                                  child: Image.network(listMedia[index],fit: BoxFit.cover,),
                                )
                              ),
                            ),
                          ),
                        );
                      }
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child:  listDocument.isEmpty
                    ? MyNoDataNewWidget(msg: "No Document uploaded yet", img: '')
                    : SingleChildScrollView(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: listDocument.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () async {
                          var link = await listDocument[index].getDownloadURL();
                          if (await canLaunchUrl(Uri.parse(link)))
                            {
                              launchUrl(Uri.parse(link),mode: LaunchMode.externalApplication);
                            }
                        },
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset('assets/images/ic_file_inside.png', width: 55, height: 55,),
                                  Gap(12),
                                  Text(listDocument[index].name,style: const TextStyle(color: black,fontWeight: FontWeight.w400,fontSize: 14),),
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