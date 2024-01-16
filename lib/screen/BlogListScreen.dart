import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shivalik_institute/common_widget/loading.dart';
import 'package:shivalik_institute/common_widget/no_data_new.dart';
import 'package:shivalik_institute/constant/api_end_point.dart';
import '../../constant/colors.dart';
import '../../model/BlogListResponseModel.dart';
import '../../utils/app_utils.dart';
import '../../utils/base_class.dart';
import '../common_widget/common_widget.dart';
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
            ? const LoadingWidget()
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
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => BlogDetailsScreen(listBlog,index)),);
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
                                                  listBlog[index].imageFull.toString().isNotEmpty
                                                      ? FadeInImage.assetNetwork(
                                                    image: listBlog[index].imageFull.toString() + "&h=500&zc=2",
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
                                              Text(checkValidString(listBlog[index].title.toString()),
                                                textAlign: TextAlign.start,
                                                maxLines: 2,
                                                style: const TextStyle(fontSize: 18, color: black, fontWeight: FontWeight.w500),
                                              ),
                                              const Gap(10),
                                              Text(checkValidString(listBlog[index].description.toString().replaceAll(htmlExp, "").replaceAll("&nbsp;", "").replaceAll("&quot;", "").replaceAll("&#39;", "'").trim()).toString(),
                                                textAlign: TextAlign.start,
                                                maxLines: 5,
                                                style: const TextStyle(fontSize: 16, color: grayDark, fontWeight: FontWeight.w400),
                                              ),
                                              const Gap(8),
                                              Text(listBlog[index].publishedDate.toString(),
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