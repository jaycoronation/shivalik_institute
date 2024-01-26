import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:share_plus/share_plus.dart';

import '../common_widget/common_widget.dart';
import '../constant/colors.dart';
import '../model/BlogListResponseModel.dart';
import '../utils/app_utils.dart';
import '../utils/base_class.dart';
import 'BlogListScreen.dart';

class BlogDetailsScreen extends StatefulWidget {
  final List<BlogList> getSet;
  final int index;
  const BlogDetailsScreen(this.getSet, this.index, {Key? key}) : super (key: key);

  @override
  BaseState<BlogDetailsScreen> createState() => _BlogDetailsScreen();
}

class _BlogDetailsScreen extends BaseState<BlogDetailsScreen> {

  BlogList getSet = BlogList();
  List<BlogList> blogListData = [];

  @override
  void initState(){
    super.initState();

    blogListData = (widget as BlogDetailsScreen).getSet;
    getSet = blogListData[(widget as BlogDetailsScreen).index];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: appBg,
          appBar: AppBar(
            toolbarHeight: kToolbarHeight,
            automaticallyImplyLeading: false,
            backgroundColor: appBg,
            elevation: 0,
            titleSpacing: 0,
            centerTitle: false,
            leading: InkWell(
              borderRadius: BorderRadius.circular(52),
              onTap: () {
                Navigator.pop(context);
              },
              child: getBackArrow(),
            ),
            actions: [
              InkWell(
                customBorder: const CircleBorder(),
                onTap: () {
                  var shareText = "Hello,\n\nSharing our latest article, '${getSet.title},' which is now available on our website. For the insightful read, click the link below \n\nhttps://www.shivalik.institute/articles/${getSet.slug.toString()}\n\nHope you find it engaging and valuable.";
                  Share.share(shareText);
                },
                child: SizedBox(
                  width: 42,
                  height: 42,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset('assets/images/ic_share.png', width: 16, height: 16,color: black),
                  ),
                ),
              ),
              const Gap(12)
            ],
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
                                getSet.publishedDate.toString(),
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
                        imageUrl: "${getSet.imageFull}&h=auto&w=511",
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
                  margin: const EdgeInsets.fromLTRB(22, 32, 22, 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HtmlWidget(
                        checkValidString(getSet.description).replaceAll("<p>&nbsp;</p>", "").toString().replaceAll("<br />", ""),
                        textStyle: const TextStyle(color: black,fontWeight: FontWeight.w400,fontSize: 16),
                      ),
                      const Gap(12),
                    /*  Wrap(
                        runSpacing: 6,
                        spacing: 6,
                        children: getSet.tagsArray?.map(
                              (e) {
                            return buildStageChip(e,);
                          },
                        ).toList(),
                      ),*/
                    ],
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(left: 22,top: 12,bottom: 12),
                    child: const Text("Related Articles",style: TextStyle(color: black,fontWeight: FontWeight.w500,fontSize: 18),)
                ),
                Container(
                  margin: const EdgeInsets.only(left: 12,right: 12,top: 12),
                  child: AnimationLimiter(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      primary: false,
                      shrinkWrap: true,
                      itemCount: blogListData.length,
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: Visibility(
                                  visible: index != (widget as BlogDetailsScreen).index,
                                  child: blogBlock(index, setState)
                              ),
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
        ),
        onWillPop: (){
          Navigator.pop(context);
          return Future.value(true);
        }
    );
  }

  Widget buildStageChip(String e) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        startActivity(context, BlogListScreen(tag: e,));
      },
      child: Container(
        decoration: BoxDecoration(
            color: black, borderRadius: BorderRadius.circular(8)
        ),
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        margin: const EdgeInsets.only(top: 6),
        child: Text(
          e,
          style:
          const TextStyle(fontWeight: FontWeight.w400, color: white, fontSize: 14),
        ),
      ),
    );
  }

  blogBlock(int index, void Function(VoidCallback fn) setState) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        startActivity(context, BlogDetailsScreen(blogListData,index));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            border:Border.all(color: grayLight, width: 0.6,)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 210,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      blogListData[index].imageFull.toString().isNotEmpty
                          ? FadeInImage.assetNetwork(
                        image: blogListData[index].imageFull.toString() + "&h=500&zc=2",
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: 210,
                        placeholder: 'assets/images/bg_gray.jpeg',
                      ) : Image.asset('assets/images/bg_gray.jpeg',
                          width: 50, height: 50),
                    ],
                  ),
                ),
              ),
              const Gap(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(checkValidString(blogListData[index].title.toString()),
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    style: const TextStyle(fontSize: 20, color: black, fontWeight: FontWeight.w500),
                  ),
                  const Gap(10),
                  Text(checkValidString(blogListData[index].description!.toString()).toString().replaceAll(htmlExp, "").replaceAll("&nbsp;", "").replaceAll("&quot;", "").replaceAll("&#39;", "'").replaceAll("<br />", "").trim().toString(),
                    textAlign: TextAlign.start,
                    maxLines: 5,
                    style: const TextStyle(fontSize: 16, color: grayDark, fontWeight: FontWeight.w400),
                  ),
                  const Gap(8),
                  Text(blogListData[index].publishedDate.toString(),
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: 14, color: graySemiDark, fontWeight: FontWeight.w400),
                  ),
                  const Gap(10),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void castStatefulWidget() {
    widget is BlogDetailsScreen;
  }
}