import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shivalik_institute/common_widget/loading.dart';
import 'package:shivalik_institute/common_widget/no_data_new.dart';
import 'package:shivalik_institute/common_widget/placeholder.dart';
import 'package:shivalik_institute/viewmodels/EventViewModel.dart';

import '../common_widget/common_widget.dart';
import '../common_widget/loading_more.dart';
import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../model/EventResponseModel.dart';
import '../utils/app_utils.dart';
import '../utils/base_class.dart';
import 'EventDetailsScreen.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen( {super.key});

  @override
  BaseState<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends BaseState<EventsScreen> {

  int _pageIndex = 1;
  final int _pageResult = 10;
  bool _isSearchHideShow = false;
  String searchParam = "";
  TextEditingController searchController = TextEditingController();
  late ScrollController _scrollViewController;
  bool isScrollingDown = false;
  bool _isLastPage = false;
  bool _isLoadingMore = false;

  List<EventList> listEvent = [];

  @override
  void initState(){
    super.initState();
    getEventsList(true);

    _scrollViewController = ScrollController();
    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection == ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          //setState(() {});
        }
      }
      if (_scrollViewController.position.userScrollDirection == ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          //setState(() {});
        }
      }
      pagination();
    });

  }

  void pagination() {
    var maxScroll = _scrollViewController.position.maxScrollExtent - 200;

    if (!_isLastPage && !_isLoadingMore)
    {
      if ((_scrollViewController.position.pixels >= maxScroll))
      {
        setState(() {
          _isLoadingMore = true;
          getEventsList(false);
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
            title: getTitle("Events",),
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
          body: Consumer<EventViewModel>(
            builder: (context, value, child) {
              if ((value.isLoading) && (_isLoadingMore == false))
                {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade100 ,
                    highlightColor: Colors.grey.shade400,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              MediumContainerPlaceholder(width: MediaQuery.of(context).size.width),
                              const Gap(8),
                              TitlePlaceholder(width: MediaQuery.of(context).size.width),
                              const Gap(12),
                              MediumContainerPlaceholder(width: MediaQuery.of(context).size.width),
                              const Gap(8),
                              TitlePlaceholder(width: MediaQuery.of(context).size.width),
                              const Gap(12),
                              MediumContainerPlaceholder(width: MediaQuery.of(context).size.width),
                              const Gap(8),
                              TitlePlaceholder(width: MediaQuery.of(context).size.width),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              else
                {
                  if (value.response.success == "1")
                    {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
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
                                          getEventsList(true);
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
                                          listEvent = [];
                                        });
                                        getEventsList(true);
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
                            Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                controller: _scrollViewController,
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: listEvent.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      logFirebase("event_details", {'event_title' : listEvent[index].title, 'event_id' : listEvent[index].id});
                                      startActivity(context, EventsDetailsScreen(listEvent[index]));
                                    },
                                    child: Container(
                                      height: 300,
                                      margin: const EdgeInsets.only(top: 12),
                                      width : MediaQuery.of(context).size.width,
                                      decoration:  BoxDecoration(
                                        border: Border.all(color: white, width: 0.5),
                                        borderRadius:const BorderRadius.all(Radius.circular(8),) ,
                                        color: grayNew,
                                      ),
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: CachedNetworkImage(
                                                imageUrl: "${listEvent[index].bannerImage}&h=500&zc=2",
                                                fit: BoxFit.cover,
                                                width : MediaQuery.of(context).size.width,
                                                height: 300,
                                                errorWidget: (context, url, error) => Container(
                                                  color: grayNew,
                                                  width : MediaQuery.of(context).size.width,
                                                  height: 300,
                                                ),
                                                placeholder: (context, url) => Container(
                                                  color: grayNew,
                                                  width : MediaQuery.of(context).size.width,
                                                  height: 300,
                                                )
                                            ),
                                          ),
                                          Container(
                                            height: 300,
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
                                                      0.7,
                                                      1.0
                                                    ]),
                                                borderRadius: BorderRadius.circular(8)
                                            ),
                                          ),
                                          Positioned(
                                            top: 12,
                                            right: 12,
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(4),
                                                      color: brandColor
                                                  ),
                                                  padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
                                                  child: Text(listEvent[index].eventType ?? '',style: const TextStyle(color: white,fontSize: 14,fontWeight: FontWeight.w500)),
                                                ),
                                                Visibility(
                                                  visible: listEvent[index].type == "upcoming",
                                                  child: Container(
                                                    margin: const EdgeInsets.only(left: 12),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(4),
                                                        color: brandColor
                                                    ),
                                                    padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
                                                    child: Text('Upcoming',style: const TextStyle(color: white,fontSize: 14,fontWeight: FontWeight.w500)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(height: 6,),
                                                Text(listEvent[index].title ?? "",
                                                  style: const TextStyle(fontSize: 16, color: white,fontWeight: FontWeight.w500),),
                                                Container(height: 6,),
                                                Text(universalDateConverter("dd-MM-yyyy hh:mm a", "dd MMM, yyyy hh:mm a", listEvent[index].date ?? ""),
                                                  style: const TextStyle(fontSize: 14, color: white,fontWeight: FontWeight.w400),),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const Gap(22),
                            Visibility(
                                visible: _isLoadingMore,
                                child: const LoadingMoreWidget()
                            )
                          ],
                        ),
                      );
                    }
                  else
                    {
                      return const MyNoDataNewWidget(msg: "No Events Found", img: "");
                    }
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

  Future<void> getEventsList(bool isFirstTime) async {
    if (isFirstTime) {
      setState(() {
        _isLoadingMore = false;
        _pageIndex = 1;
        _isLastPage = false;
      });
    }

    Map<String, String> jsonBody = {
      'filter': "",
      'filter_by': "",
      'limit': _pageResult.toString(),
      'page': _pageIndex.toString(),
      'search': searchParam,
      'status': "1",
      'from_app' : FROM_APP
    };
    var eventViewModel = Provider.of<EventViewModel>(context,listen: false);
    await eventViewModel.getEventsList(jsonBody);

    if (eventViewModel.response.success == "1")
    {
      if (isFirstTime)
        {
          listEvent = [];
        }
      List<EventList>? _tempList = [];
      _tempList = eventViewModel.response.eventList;
      listEvent.addAll(_tempList!);

      print(listEvent.length);

      if (_tempList.isNotEmpty) {
        _pageIndex += 1;
        if (_tempList.isEmpty || _tempList.length % _pageResult != 0 ) {
          _isLastPage = true;
        }
      }

    }

    print("Is Last Page === $_isLastPage");

    setState(() {
      _isLoadingMore = false;
    });
  }

  @override
  void castStatefulWidget() {
    widget is EventsScreen;
  }
}