import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shivalik_institute/model/HolidayResponseModel.dart';
import 'package:shivalik_institute/utils/app_utils.dart';
import 'package:shivalik_institute/viewmodels/HolidayViewModel.dart';

import '../common_widget/common_widget.dart';
import '../common_widget/loading.dart';
import '../common_widget/no_data_new.dart';
import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../utils/base_class.dart';

class HolidayScreen extends StatefulWidget {
  const HolidayScreen({super.key});

  @override
  BaseState<HolidayScreen> createState() => _HolidayScreenState();
}

class _HolidayScreenState extends BaseState<HolidayScreen> {

  int _pageIndex = 1;
  final int _pageResult = 10;
  bool _isSearchHideShow = false;
  String searchParam = "";
  TextEditingController searchController = TextEditingController();
  late ScrollController _scrollViewController;
  bool isScrollingDown = false;
  bool _isLastPage = false;
  bool _isLoadingMore = false;

  List<HolidayList> listHoliday = [];

  @override
  void initState(){
    super.initState();
    getHolidayList();

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
          getHolidayList();
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
            title: getTitle("Holiday List",),
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
          body: Consumer<HolidayViewModel>(
            builder: (context, value, child) {
              if (value.isLoading)
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
                                    getHolidayList();
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
                                    listHoliday = [];
                                  });
                                  getHolidayList();
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
                      listHoliday.isNotEmpty
                          ? Expanded(
                        child: ListView.builder(
                          controller: _scrollViewController,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: listHoliday.length ?? 0,
                          itemBuilder: (context, index) {
                            var getSet = listHoliday[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(8),

                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Expanded(
                                        flex: 1,
                                        child: Text("Title ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                      ),
                                      const Text(" : ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                      Expanded(
                                        flex: 2,
                                        child: Text(getSet.title ?? "",style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w500),),
                                      ),
                                    ],
                                  ),
                                  const Gap(12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Expanded(
                                        flex: 1,
                                        child: Text("Description ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                      ),
                                      const Text(" : ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                      Expanded(
                                        flex: 2,
                                        child: Text("${getSet?.description}",style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w500),),
                                      ),
                                    ],
                                  ),
                                  const Gap(12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Expanded(
                                        flex: 1,
                                        child: Text("Date ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                      ),
                                      const Text(" : ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                      Expanded(
                                        flex: 2,
                                        child: Text(universalDateConverter("dd-MM-yyyy", "dd MMM,yyyy", getSet.holidayDate ?? ""),style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w500),),
                                      ),
                                    ],
                                  ),
                                  const Gap(12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Expanded(
                                        flex: 1,
                                        child: Text("Status ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                      ),
                                      const Text(" : ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                      Expanded(
                                        flex: 2,
                                        child: Text(getSet.status == "1" ? "Active" : "InActive",style: TextStyle(color: getSet.status == "1" ? Colors.green : Colors.red,fontSize: 14,fontWeight: FontWeight.w600),),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      )
                          : const MyNoDataNewWidget(msg: "No Holiday Founds", img: "")
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

  Future<void> getHolidayList() async {
    /*page: 1, limit: 10, search: "", total: 0, status: 1, filter: "upcoming", filter_by: "upcoming",…}*/
    Map<String, String> jsonBody = {
      'limit': _pageResult.toString(),
      'page': _pageIndex.toString(),
      'search': "",
      'from_app' : FROM_APP
    };

    var holidayViewModel = Provider.of<HolidayViewModel>(context,listen: false);
    await holidayViewModel.getHolidayList(jsonBody);

    if (holidayViewModel.response.success == "1")
    {
      listHoliday = [];
      listHoliday.addAll(holidayViewModel.response.holidayList ?? []);
    }
  }

  @override
  void castStatefulWidget() {
    widget is HolidayScreen;
  }
}