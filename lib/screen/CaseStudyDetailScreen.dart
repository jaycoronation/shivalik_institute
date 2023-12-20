import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common_widget/common_widget.dart';
import '../constant/colors.dart';
import '../model/CaseStudyResponseModel.dart';
import '../utils/app_utils.dart';
import '../utils/base_class.dart';

class CaseStudyDetailScreen extends StatefulWidget {
  final CaseStudyList getSet;
  const CaseStudyDetailScreen(this.getSet, {Key? key}) : super (key: key);

  @override
  BaseState<CaseStudyDetailScreen> createState() => _CaseStudyDetailScreen();
}

class _CaseStudyDetailScreen extends BaseState<CaseStudyDetailScreen> {

  CaseStudyList getSet = CaseStudyList();

  @override
  void initState(){
    super.initState();
    getSet = (widget as CaseStudyDetailScreen).getSet;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: appBg,
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
            title: getTitle("Case Study",),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 12,right: 12,left: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(checkValidString(getSet.title).toString(),style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: black),),
                      const Gap(12),
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                getSet.tagLine.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: black,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(12),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CachedNetworkImage(
                        imageUrl: "${getSet.coverImage}&h=500&zc=2",
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        errorWidget: (context, url, error) => Container(
                          color: grayNew,
                          width: MediaQuery.of(context).size.width,
                          height: 280,
                        ),
                        placeholder: (context, url) => Container(
                          color: grayNew,
                          width: MediaQuery.of(context).size.width,
                          height: 280 ,
                        )
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(22, 32, 22, 22),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        checkValidString(getSet.description).replaceAll("<p>&nbsp;</p>", "").toString().replaceAll("<br />", ""),
                        style: const TextStyle(color: black,fontWeight: FontWeight.w400,fontSize: 16),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12,left: 12),
                  child: Row(
                    children: [
                      const Text("Published By:",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: black),),
                       const Gap(22),
                      Image.network("${getSet.publishedBy}&w=124",),
                    ],
                  ),
                ),
                Container(height: 12,),
                Padding(
                  padding: const EdgeInsets.only(right: 12,left: 12),
                  child: Row(
                    children: [
                      const Text("Affiliated With",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: black),),
                      const Gap(22),
                      Image.network("${getSet.affiliatedWith}&w=124",),
                    ],
                  ),
                ),
                Container(height: 18,),
                Visibility(
                  visible: getSet.brochure!.isNotEmpty,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () async {
                      await launchUrl(Uri.parse(getSet?.brochure ?? ""),mode: LaunchMode.externalApplication);
                      // startActivity(context, PdfViewer(getSet.brochure ?? "", getSet.title ?? ""));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 18),
                      decoration: BoxDecoration(
                        color: black,
                        border: Border.all(
                          width: 8,
                          color: black,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text("Read More",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: white),),
                    ),
                  ),
                ),
                Container(height: 18,),
              ],
            ),
          ),
        ),
        onWillPop: (){
          Navigator.pop(context);
          return Future.value(true);
        }
    );
  }


  @override
  void castStatefulWidget() {
    widget is CaseStudyDetailScreen;
  }
}