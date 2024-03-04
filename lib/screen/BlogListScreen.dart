import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shivalik_institute/common_widget/loading.dart';
import 'package:shivalik_institute/common_widget/no_data_new.dart';
import 'package:shivalik_institute/constant/api_end_point.dart';
import '../../constant/colors.dart';
import '../../model/BlogListResponseModel.dart';
import '../../utils/app_utils.dart';
import '../../utils/base_class.dart';
import '../common_widget/common_widget.dart';
import '../common_widget/placeholder.dart';
import 'BlogDetailsScreen.dart';

class BlogListScreen extends StatefulWidget {
  String tag = '';
  BlogListScreen({Key? key,this.tag = ''}) : super(key: key);

  @override
  _BlogListScreenState createState() => _BlogListScreenState();
}

class _BlogListScreenState extends BaseState<BlogListScreen> {
  List<BlogList> listBlog = [];

  bool _isLoading = false;
  ScrollController _scrollViewController = ScrollController();

  bool _isLoadingMore = false;
  final int _pageResult = 10;
  bool _isLastPage = false;
  bool isScrollingDown = false;
  String selectedCategory = "all";
  String selectedFilterText = "";

  List<String> listTaggedArray = [];

  @override
  void initState() {
    super.initState();
    getBlogList();
  }

  void pagination() {
    if (!_isLastPage && !_isLoadingMore) {
      if ((_scrollViewController.position.pixels == _scrollViewController.position.maxScrollExtent)) {
        setState(() {
          _isLoadingMore = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          toolbarHeight: 55,
          automaticallyImplyLeading: false,
          leading: InkWell(
            borderRadius: BorderRadius.circular(52),
              customBorder: const CircleBorder(),
              onTap: () {
                Navigator.pop(context);
              },
              child: getBackArrow()
          ),
          title: getTitle("Articles"),
          centerTitle: false,
          elevation: 0,
          titleSpacing: 0,
          backgroundColor: white,
        ),
        body: _isLoading
            ? Shimmer.fromColors(
              baseColor: Colors.grey.shade100 ,
                highlightColor: Colors.grey.shade400,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: LargeContainerPlaceholder(width: MediaQuery.of(context).size.width),
                              ),
                              const Gap(12),
                              SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                              const Gap(12),
                              SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                              const Gap(12),
                              SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                              const Gap(12),
                              SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: LargeContainerPlaceholder(width: MediaQuery.of(context).size.width),
                              ),
                              const Gap(12),
                              SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                              const Gap(12),
                              SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                              const Gap(12),
                              SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                              const Gap(12),
                              SingleTitlePlaceholder(width: MediaQuery.of(context).size.width),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              )
            : listBlog.isEmpty
            ? const Center(child: MyNoDataNewWidget(msg: 'No Articles Found!', img: '',))
            : _setData()
    );
  }

  SafeArea _setData() {
    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  child:SingleChildScrollView(
                    controller: _scrollViewController,
                    child: AnimationLimiter(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          primary: false,
                          padding: EdgeInsets.zero,
                          itemCount: listBlog.length,
                          itemBuilder: (ctx, index) => AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    logFirebase("articles_details", {});
                                    startActivityAnimation(context, BlogDetailsScreen(listBlog, index));
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                        alignment: Alignment.center,
                                        decoration:  BoxDecoration(
                                          color: white,
                                          borderRadius: BorderRadius.circular(kBorderRadius),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.1),
                                              spreadRadius: 5,
                                              blurRadius: 9,
                                              offset: const Offset(0, 2),
                                            )
                                          ],
                                        ),
                                        height: 190,
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(kButtonCornerRadius),
                                            ),
                                            child: Stack(
                                              alignment: Alignment.topRight,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context).size.width,
                                                  height: 190,
                                                  decoration: BoxDecoration(
                                                      color: lightGrey,
                                                      image: DecorationImage(
                                                        image: CachedNetworkImageProvider("${listBlog[index].imageFull}&h=500&q=100"),
                                                        fit: BoxFit.cover,
                                                      ),
                                                      shape: BoxShape.rectangle,
                                                      borderRadius: BorderRadius.all(
                                                        Radius.circular(kButtonCornerRadius),
                                                      )),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(right: 12,top: 12),
                                                  decoration: BoxDecoration(
                                                    color: white.withOpacity(0.6),
                                                    borderRadius: BorderRadius.circular(kBorderRadius),
                                                  ),
                                                  padding: const EdgeInsets.fromLTRB(6, 3, 6, 3),
                                                  child: Text(toDisplayCase(listBlog[index].publishedDate ?? ''),style: const TextStyle(color: black,fontWeight: FontWeight.w400,fontSize: 12)),
                                                )
                                              ],
                                            )),
                                      ),
                                      Text(
                                        toDisplayCase(listBlog[index].title.toString().trim()),
                                        overflow: TextOverflow.clip,
                                        maxLines: 2,
                                        style: TextStyle(color: black, fontWeight: FontWeight.w500, fontSize: textFiledSize),
                                      ),
                                      const Gap(6),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              checkValidString(listBlog[index].description.toString().replaceAll(htmlExp, "").replaceAll("&nbsp;", "").replaceAll("&quot;", "").replaceAll("&#39;", "'").replaceAll("<br />", "").trim()).toString(),
                                              overflow: TextOverflow.clip,
                                              textAlign: TextAlign.start,
                                              maxLines: 2,
                                              style: const TextStyle(fontWeight: FontWeight.w400, color: black, fontSize: 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Gap(6),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                      ),
                    ),
                  )),
              Visibility(
                visible: _isLoadingMore,
                child: Container(
                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 30, height: 30,
                          child: Lottie.asset('assets/images/loader_new.json',repeat: true, animate: true, frameRate: FrameRate.max)),
                      const Text(' Loading more...',
                          style: TextStyle(color: black, fontWeight: FontWeight.w400, fontSize: 16)
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }

  @override
  void castStatefulWidget() {
    widget is BlogListScreen;
  }

  getBlogList() async {

    setState(() {
      _isLoading = true;
    });

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(articleListUrl);

    Map<String, String> jsonBody = {
      'is_active':'1',
      'joint_page_id':'12',
      'logged_in_master_user_id':'1',
      'master_user_id':'1'
    };

    final response = await http.post(url, body: jsonBody, headers: {
      "Authorization": AuthHeader,
    });

    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = BlogListResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1)
    {
      try {
        if (dataResponse.data != null)
        {
          if (dataResponse.data!.isNotEmpty)
          {
            listBlog = [];
            List<BlogList>? _tempList = [];
            _tempList = dataResponse.data;
            listBlog.addAll(_tempList!);
            setState(() {
              _isLoading = false;
            });
          }
          else
          {

            setState(() {
              _isLoading = false;
            });
          }
        }
        else
        {
        }

      }
      catch (e) {}
      setState(() {
        _isLoading = false;
      });
    }
    else
    {
      setState(() {
        _isLoading = false;
        _isLoadingMore = false;
      });
      showSnackBar(dataResponse.message, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

}