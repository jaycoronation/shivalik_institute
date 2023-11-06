import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shivalik_institute/common_widget/loading.dart';
import 'package:shivalik_institute/common_widget/no_data_new.dart';
import 'package:shivalik_institute/viewmodels/EventViewModel.dart';

import '../common_widget/common_widget.dart';
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
    getEventsList();

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

    if (!_isLastPage && !_isLoadingMore) {
      if ((_scrollViewController.position.pixels >= maxScroll)) {
        setState(() {
          _isLoadingMore = true;
          getEventsList();
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
              if (value.isLoading)
                {
                  return const LoadingWidget();
                }
              else
                {
                  if (value.response.success == "1")
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
                                          getEventsList();
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
                                        getEventsList();
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
                                      startActivity(context, EventsDetailsScreen(listEvent[index]));
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
                                                    listEvent[index].bannerImage.toString().isNotEmpty
                                                        ? FadeInImage.assetNetwork(
                                                      image: "${listEvent[index].bannerImage}&h=500&zc=2",
                                                      fit: BoxFit.cover,
                                                      width: MediaQuery.of(context).size.width,
                                                      height: 210,
                                                      placeholder: 'assets/images/bg_gray.jpeg',
                                                    )
                                                        : Image.asset(
                                                        'assets/images/bg_gray.jpeg',
                                                        width: 50, height: 50
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Gap(12),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(checkValidString(listEvent[index].title.toString()),
                                                  textAlign: TextAlign.start,
                                                  maxLines: 2,
                                                  style: const TextStyle(fontSize: 20, color: black, fontWeight: FontWeight.w500),
                                                ),
                                                const Gap(10),
                                                Text(checkValidString(listEvent[index].description).toString(),
                                                  textAlign: TextAlign.start,
                                                  maxLines: 5,
                                                  style: const TextStyle(fontSize: 16, color: grayDark, fontWeight: FontWeight.w400),
                                                ),
                                                const Gap(8),
                                                Text(universalDateConverter("yyyy-MM-dd", "dd MMM,yyyy", listEvent[index].date ?? ''),
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
                                },
                              ),
                            ),

                          ],
                        ),
                      );
                    }
                  else
                    {
                      return MyNoDataNewWidget(msg: "No Events Found", img: "");
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

  Future<void> getEventsList() async {
    /*page: 1, limit: 10, search: "", total: 0, status: 1, filter: "upcoming", filter_by: "upcoming",…}*/
    Map<String, String> jsonBody = {
      'filter': "upcoming",
      'filter_by': "past",
      'limit': _pageResult.toString(),
      'page': _pageIndex.toString(),
      'search': "",
      'status': "1",
      'from_app' : FROM_APP
    };
    var eventViewModel = Provider.of<EventViewModel>(context,listen: false);
    await eventViewModel.getEventsList(jsonBody);

    if (eventViewModel.response.success == "1")
    {
      listEvent = [];
      listEvent.addAll(eventViewModel.response.eventList ?? []);
    }
  }

  @override
  void castStatefulWidget() {
    widget is EventsScreen;
  }
}