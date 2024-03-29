import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shivalik_institute/viewmodels/TestimonialsViewModel.dart';
import '../common_widget/VideoProjectWidget.dart';
import '../common_widget/common_widget.dart';
import '../common_widget/loading.dart';
import '../common_widget/loading_more.dart';
import '../common_widget/no_data_new.dart';
import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../model/TestimonialResponseModel.dart';
import '../utils/base_class.dart';

class TestimonialsScreen extends StatefulWidget {
  const TestimonialsScreen({super.key});

  @override
  BaseState<TestimonialsScreen> createState() => _TestimonialsScreenState();
}

class _TestimonialsScreenState extends BaseState<TestimonialsScreen> {

  int _pageIndex = 1;
  final int _pageResult = 10;
  bool _isSearchHideShow = false;
  String searchParam = "";
  TextEditingController searchController = TextEditingController();
  late ScrollController _scrollViewController;
  bool isScrollingDown = false;
  bool _isLastPage = false;
  bool _isLoadingMore = false;

  List<TestimonialsList> listTestimonials = [];
  List<MediaList> mediaList = [];

  @override
  void initState(){
    super.initState();
    getTestimonialsList(true);

    _scrollViewController = ScrollController();
    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection == ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
        }
      }
      if (_scrollViewController.position.userScrollDirection == ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
        }
      }
      pagination();
    });

  }

  void pagination() {
    var maxScroll = _scrollViewController.position.maxScrollExtent - 200;

    if (!_isLastPage && !_isLoadingMore) {
      if ((_scrollViewController.position.pixels >= maxScroll)) {
        setState(() {
          _isLoadingMore = true;
          getTestimonialsList(false);
        });
      }
    }
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
            title: getTitle("Testimonials",),
            actions: [
              InkWell(
                onTap: () {
                  setState(() {
                    _isSearchHideShow = !_isSearchHideShow;
                    searchController.text = "";
                    searchParam = "";
                  });
                },
                child: Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  child: Image.asset("assets/images/ic_search.png",
                    width: 22, height: 22,
                    color: black,
                  ),
                ),
              ),
              const Gap(12),
            ],
          ),
          body: Consumer<TestimonialsViewModel>(
            builder: (context, value, child) {
              if ((value.isLoading) && (_isLoadingMore == false))
              {
                return const LoadingWidget();
              }
              else
              {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: _isSearchHideShow,
                        child: Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 12,bottom: 12),
                              height: 50,
                              child: TextField(
                                cursorColor: black,
                                controller: searchController,
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                textInputAction: TextInputAction.search,
                                onSubmitted: (text) {
                                  if (text.isNotEmpty)
                                  {
                                    setState(() {
                                      searchParam = text;
                                    });
                                    getTestimonialsList(true);
                                  }
                                },
                                onChanged: (value) {
                                  setState(() {
                                    searchParam = value;
                                  });
                                },
                                cursorHeight: 20,
                                style: const TextStyle(fontWeight: FontWeight.w400, color: black, fontSize: 16, height: 1.3),
                                maxLines: 1,
                                decoration: InputDecoration(
                                  alignLabelWithHint: true,
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: lableHint,
                                  ),
                                  hintText: 'Search...',
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 0, color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(kBorderRadius),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 0, color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(kBorderRadius),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 0, color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(kBorderRadius),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 0, color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(kBorderRadius),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 0, color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(kBorderRadius),
                                  ),
                                  floatingLabelAlignment: FloatingLabelAlignment.center,
                                  filled: true,
                                  fillColor: searchColor,
                                  hintStyle: const TextStyle(fontWeight: FontWeight.w400, color: lableHint, fontSize: 16, height: 25 / 15),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: searchParam.isNotEmpty,
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  setState(() {
                                    searchController.clear();
                                    searchParam = "";
                                    listTestimonials = [];
                                  });
                                  getTestimonialsList(true);
                                },
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  margin: const EdgeInsets.only(right: 12),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: grayDark,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Icon(
                                      Icons.close,
                                      size: 12,
                                      color: white,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      listTestimonials.isNotEmpty
                      //     ? Expanded(
                      //   child: ListView.builder(
                      //     controller: _scrollViewController,
                      //     physics: const BouncingScrollPhysics(),
                      //     scrollDirection: Axis.vertical,
                      //     shrinkWrap: true,
                      //     itemCount: listTestimonials.length,
                      //     itemBuilder: (context, index) {
                      //       var getSet = listTestimonials[index];
                      //       return Container(
                      //         margin: const EdgeInsets.only(bottom: 12),
                      //         padding: const EdgeInsets.all(12),
                      //         decoration: BoxDecoration(
                      //           color: white,
                      //           borderRadius: BorderRadius.circular(8),
                      //
                      //         ),
                      //         child: Column(
                      //           mainAxisAlignment: MainAxisAlignment.start,
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Row(
                      //               mainAxisAlignment: MainAxisAlignment.start,
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: [
                      //                 const Expanded(
                      //                   flex: 1,
                      //                   child: Text("Name ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                      //                 ),
                      //                 const Text(" : ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                      //                 Expanded(
                      //                   flex: 2,
                      //                   child: Text("${getSet.name}",style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400),),
                      //                 ),
                      //               ],
                      //             ),
                      //             const Gap(12),
                      //             Row(
                      //               mainAxisAlignment: MainAxisAlignment.start,
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: [
                      //                 const Expanded(
                      //                   flex: 1,
                      //                   child: Text("Title ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                      //                 ),
                      //                 const Text(" : ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                      //                 Expanded(
                      //                   flex: 2,
                      //                   child: Text("${getSet.title}",style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400),),
                      //                 ),
                      //               ],
                      //             ),
                      //             const Gap(12),
                      //             Row(
                      //               mainAxisAlignment: MainAxisAlignment.start,
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: [
                      //                 const Expanded(
                      //                   flex: 1,
                      //                   child: Text("Description ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                      //                 ),
                      //                 const Text(" : ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                      //                 Expanded(
                      //                   flex: 2,
                      //                   child: Text(getSet.description ?? '',style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400),),
                      //                 ),
                      //               ],
                      //             ),
                      //             const Gap(12),
                      //             Row(
                      //               mainAxisAlignment: MainAxisAlignment.start,
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: [
                      //                 const Expanded(
                      //                   flex: 1,
                      //                   child: Text("Status ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                      //                 ),
                      //                 const Text(" : ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                      //                 Expanded(
                      //                   flex: 2,
                      //                   child: Text(getSet.isActive == "1" ?"Active" : "InActive",style: TextStyle(color: getSet.isActive == "1" ? Colors.green : Colors.red,fontSize: 14,fontWeight: FontWeight.w400),),
                      //                 ),
                      //               ],
                      //             )
                      //           ],
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // )
                          ? Expanded(
                            child: ListView.builder(
                              controller: _scrollViewController,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: listTestimonials.length,
                              itemBuilder: (context, index) {
                                var getSet = listTestimonials[index];
                                return  GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    var videoUrl = '';
                                    for (var i=0; i < (getSet.mediaList?.length ?? 0); i++)
                                    {
                                      videoUrl = getSet.mediaList?[i].path ?? '';
                                    }
                                    startActivity(context,  VideoProjectWidget(url: videoUrl, play: true));
                                  },
                                  child: Column(
                                    children: [
                                      Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(8.0),
                                            child: Image.network(
                                              getSet.thumbImg.toString(),
                                              width: MediaQuery.of(context).size.width,
                                              height: 400,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Container(
                                            height: 400,
                                            decoration: BoxDecoration(
                                                color: Colors.black,
                                                gradient: LinearGradient(
                                                    begin: FractionalOffset.topCenter,
                                                    end: FractionalOffset.bottomCenter,
                                                    colors: [
                                                      blackConst.withOpacity(0.0),
                                                      blackConst.withOpacity(1),
                                                    ],
                                                    stops: const [
                                                      0.5,
                                                      1.0
                                                    ]
                                                ),
                                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 18,
                                            left: 18,
                                            right: 18,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Container(
                                                  width: 95,
                                                  height: 32,
                                                  margin: const EdgeInsets.only(bottom: 12, top: 12),
                                                  padding: const EdgeInsets.all(8),
                                                  decoration: ShapeDecoration(
                                                    color: const Color(0xFFEC5554),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(40),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      SizedBox(
                                                        width: 16,
                                                        height: 16,
                                                        child: Image.asset('assets/images/ic_play.png'),
                                                      ),
                                                      const SizedBox(width: 4),
                                                      const Text(
                                                        'Watch Now',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 10,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Text("${getSet.name}",style: const TextStyle(color: white,fontSize: 16,fontWeight: FontWeight.w500),
                                                  overflow: TextOverflow.clip,
                                                ),
                                              ],
                                            )
                                          ),
                                        ],
                                      ),
                                      Container(height: 18,),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                          : const MyNoDataNewWidget(msg: "No Testimonials Founds", img: ""),
                      Visibility(
                        visible: _isLoadingMore,
                        child: const LoadingMoreWidget()
                      )
                    ],
                  ),
                );
              }
            },
          ),
        ),
        onWillPop: () {
          Navigator.pop(context);
          return Future.value(true);
        },
    );
  }

  Future<void> getTestimonialsList(bool isFirstTime) async {
    if (isFirstTime) {
      setState(() {
        _isLoadingMore = false;
        _pageIndex = 1;
        _isLastPage = false;
      });
    }
    Map<String, String> jsonBody = {
      'limit': _pageResult.toString(),
      'page': _pageIndex.toString(),
      'search': searchParam,
      'from_app' : FROM_APP,
      'total' : '0',
      'type' : '',
      'user_type' : '3'
    };

    var testimonialsViewModel = Provider.of<TestimonialsViewModel>(context,listen: false);
    await testimonialsViewModel.getTestimonialsList(jsonBody);

    if (testimonialsViewModel.response.success == "1")
    {
      List<TestimonialsList>? _tempList = [];
      _tempList = testimonialsViewModel.response.list;
      listTestimonials?.addAll(_tempList!);

      print(listTestimonials?.length);


      if (_tempList?.isNotEmpty ?? false) {
        _pageIndex += 1;
        if (_tempList?.isEmpty ?? false || _tempList!.length % _pageResult != 0 ) {
          _isLastPage = true;
        }
      }

    }
    setState(() {
      _isLoadingMore = false;
    });
  }

  @override
  void castStatefulWidget() {
    widget is TestimonialsScreen;
  }
}