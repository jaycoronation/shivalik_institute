import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shivalik_institute/common_widget/placeholder.dart';
import 'package:shivalik_institute/model/HolidayResponseModel.dart';
import 'package:shivalik_institute/utils/app_utils.dart';
import 'package:shivalik_institute/viewmodels/HolidayViewModel.dart';

import '../common_widget/common_widget.dart';
import '../common_widget/loading.dart';
import '../common_widget/loading_more.dart';
import '../common_widget/no_data_new.dart';
import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../model/CommonResponseModel.dart';
import '../utils/base_class.dart';
import '../viewmodels/CommonViewModel.dart';
import 'AddHolidayScreen.dart';

class HolidayScreen extends StatefulWidget {
  const HolidayScreen({super.key});

  @override
  BaseState<HolidayScreen> createState() => _HolidayScreenState();
}

class _HolidayScreenState extends BaseState<HolidayScreen> {
  bool isLoading = false;
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

  Map<int, Map<int, List<HolidayList>>> separatedHolidays = {};

  @override
  void initState(){
    super.initState();
    getHolidayList(true);
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
          ),
          body: Consumer<HolidayViewModel>(
            builder: (context, value, child) {
              if ((value.isLoading) && (_isLoadingMore == false))
              {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade100 ,
                  highlightColor: Colors.grey.shade400,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(child: Divider(height: 0.5,color: graySemiDark,thickness: 0.5,endIndent: 12,)),
                              SingleTitlePlaceholder(width: 50),
                              Flexible(child: Divider(height: 0.5,color: graySemiDark,thickness: 0.5,indent: 12,)),
                            ],
                          ),
                          const Gap(12),
                          SizedBox(child: SingleTitlePlaceholder(width: MediaQuery.of(context).size.width)),
                          const Gap(12),
                          SingleContainerPlaceholder(width: MediaQuery.of(context).size.width,),
                          const Gap(20),
                          SizedBox(child: SingleTitlePlaceholder(width: MediaQuery.of(context).size.width)),
                          const Gap(12),
                          SingleContainerPlaceholder(width: MediaQuery.of(context).size.width,),
                          const Gap(20),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(child: Divider(height: 0.5,color: graySemiDark,thickness: 0.5,endIndent: 12,)),
                              SingleTitlePlaceholder(width: 50),
                              Flexible(child: Divider(height: 0.5,color: graySemiDark,thickness: 0.5,indent: 12,)),
                            ],
                          ),
                          const Gap(12),
                          SizedBox(child: SingleTitlePlaceholder(width: MediaQuery.of(context).size.width)),
                          const Gap(12),
                          SmallListContainerPlaceholder(width: MediaQuery.of(context).size.width,),
                          const Gap(20),
                          SizedBox(child: SingleTitlePlaceholder(width: MediaQuery.of(context).size.width)),
                          const Gap(12),
                          SmallListContainerPlaceholder(width: MediaQuery.of(context).size.width,),
                          const Gap(20),
                          SizedBox(child: SingleTitlePlaceholder(width: MediaQuery.of(context).size.width)),
                          const Gap(12),
                          SmallListContainerPlaceholder(width: MediaQuery.of(context).size.width,),
                          const Gap(20),
                          SizedBox(child: SingleTitlePlaceholder(width: MediaQuery.of(context).size.width)),
                          const Gap(12),
                          SmallListContainerPlaceholder(width: MediaQuery.of(context).size.width,),
                        ],
                      ),
                    ),
                  ),
                );
              }
              else
              {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
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
                                    getHolidayList(true);
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
                                  getHolidayList(true);
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
                            child: MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              removeBottom: true,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: separatedHolidays.length ?? 0,
                                itemBuilder: (context, index) {
                                  int year = separatedHolidays.keys.elementAt(index);
                                  return Container(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            const Flexible(child: Divider(height: 0.5,color: graySemiDark,thickness: 0.5,endIndent: 12,)),
                                            Text(year.toString(),style: const TextStyle(color: graySemiDark,fontWeight: FontWeight.w400,fontSize: 14),),
                                            const Flexible(child: Divider(height: 0.5,color: graySemiDark,thickness: 0.5,indent: 12,)),
                                          ],
                                        ),
                                        MediaQuery.removePadding(
                                          context: context,
                                          removeTop: true,
                                          removeBottom: true,
                                          child: ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: separatedHolidays[year]?.length,
                                            itemBuilder: (context, monthIndex) {
                                              int month = separatedHolidays[year]?.keys.elementAt(monthIndex) ?? 0;
                                              List<HolidayList> holidays = separatedHolidays[year]?[month] ?? [];
                                              return Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Gap(12),
                                                  Text(
                                                    universalDateConverter("MM", "MMMM", month.toString()),
                                                    style: const TextStyle(fontWeight: FontWeight.w600,color: black,fontSize: 16),
                                                  ),
                                                  const Gap(12),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: white,
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    child: MediaQuery.removePadding(
                                                      context: context,
                                                      removeTop: true,
                                                      removeBottom: true,
                                                      child: ListView.builder(
                                                        itemCount: holidays.length,
                                                        shrinkWrap: true,
                                                        physics: const NeverScrollableScrollPhysics(),
                                                        itemBuilder: (context, index) {
                                                          return Padding(
                                                            padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                                                            child: Column(
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets.only(top: 8,bottom: 8),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text(
                                                                        (holidays[index].toDate ?? '').isNotEmpty
                                                                            ? "${universalDateConverter("dd-MM-yyyy","dd MMMM",holidays[index].toDate ?? '')} - ${universalDateConverter("dd-MM-yyyy","dd MMMM",holidays[index].holidayDate ?? '')}"
                                                                            : universalDateConverter("dd-MM-yyyy","dd MMMM",holidays[index].holidayDate ?? ''),
                                                                        style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400,),
                                                                      ),
                                                                      Text(holidays[index].title ?? '',style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400,),)
                                                                    ],
                                                                  ),
                                                                ),
                                                                Visibility(
                                                                  visible: holidays.length > 1,
                                                                    child: const Divider(height: 0.5,thickness: 0.5,color: graySemiDark,)
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        )
                                        /*Stack(
                                          children: [
                                            Column(
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
                                                      child: Text(getSet.title ?? "",style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400),),
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
                                                      child: Text("${getSet?.description}",style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400),),
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
                                                      child: Text(universalDateConverter("dd-MM-yyyy", "dd MMM,yyyy", getSet.holidayDate ?? ""),style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400),),
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
                                                      child: Text(getSet.status == "1" ? "Active" : "InActive",style: TextStyle(color: getSet.status == "1" ? Colors.green : Colors.red,fontSize: 14,fontWeight: FontWeight.w400),),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            // Positioned(
                                            //   right: 5,
                                            //   child: GestureDetector(
                                            //     behavior: HitTestBehavior.opaque,
                                            //     onTap: (){
                                            //       showActionBottomsheet(listHoliday[index]);
                                            //     },
                                            //     child: Image.asset("assets/images/ic_dots.png",
                                            //       width: 26, height: 26,
                                            //       color: black,
                                            //     ),
                                            //   ),
                                            // ),
                                          ],
                                        ),*/
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                          : const MyNoDataNewWidget(msg: "No Holidays Found", img: ""),
                      Visibility(
                          visible: _isLoadingMore,
                          child: const LoadingMoreWidget()
                      ),

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

  void saparateHolidayDateWise() {
  // Create a HolidayManager instance
  HolidayManager holidayManager = HolidayManager();

  // Populate the holidays list
  holidayManager.holidays = listHoliday.map(
          (data) => HolidayList(
                id: data.id,
                title: data.title,
                description: data.description,
                holidayDate: data.holidayDate,
                status: data.status,
                createdAt: data.createdAt,
                updatedAt: data.updatedAt,
                deletedAt: data.deletedAt,
                )).toList();

  // Separate holidays by year and month
  separatedHolidays = holidayManager.separateHolidaysByYearAndMonth();

  }

  Future<void> getHolidayList(bool isFirstTime) async {
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
      'from_app' : FROM_APP
    };

    var holidayViewModel = Provider.of<HolidayViewModel>(context,listen: false);
    await holidayViewModel.getHolidayList(jsonBody);
    if (isFirstTime) {
      if (listHoliday.isNotEmpty) {
        listHoliday = [];
      }
    }

    if (holidayViewModel.response.success == "1")
    {
      List<HolidayList>? _tempList = [];
      _tempList = holidayViewModel.response.holidayList;

      for (var i=0; i < _tempList!.length; i++)
        {
          if (DateFormat("dd-MM-yyyy").parse(_tempList[i].holidayDate ?? '').isAfter(DateTime.now()))
            {
              listHoliday.add(_tempList[i]);
            }
        }
      saparateHolidayDateWise();


      if (_tempList?.isNotEmpty ?? false) {
        _pageIndex += 1;
        if (_tempList?.isEmpty ?? false || (_tempList?.length ?? 0) % _pageResult != 0 ) {
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
    widget is HolidayScreen;
  }

  void showDeleteBottomsheet(HolidayList getSet) {
    final commonViewModel = Provider.of<CommonViewModel>(context,listen: false);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)
          )
      ),
      elevation: 5,
      isDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, updateState) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                children: [
                  Container(height: 8,),
                  Center(
                    child: Container(
                        height: 2,
                        width: 40,
                        color: black,
                        margin: const EdgeInsets.only(bottom: 12)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Delete",
                          style: TextStyle(
                              fontSize: 18, color: black,fontWeight: FontWeight.w500),textAlign: TextAlign.left,
                        ),
                        Container(
                          height: 10,
                        ),
                        const Text("Are you sure you want to delete from app?",
                            style: TextStyle(
                                color: black,
                                fontWeight: FontWeight.normal,
                                fontSize: 14),
                            textAlign: TextAlign.center
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.only(
                                    left: 12, right: 12, bottom: 30, top: 18),
                                child: TextButton(
                                  onPressed: () {

                                    // Navigator.push(context, MaterialPageRoute(builder: (context) => const AddHolidayScreen()));
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: black,
                                            width: 1,
                                            style: BorderStyle.solid
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(black),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: Text(
                                      "No",
                                      style: TextStyle(
                                          color: white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.only(
                                    left: 12, right: 12, bottom: 30, top: 12),
                                child: TextButton(
                                  onPressed: () async {
                                    Map<String, String> jsonBody = {
                                      'id':getSet.id ?? "",
                                    };
                                    await commonViewModel.deleteHolidayData(jsonBody);
                                    CommonResponseModel value = commonViewModel.response;
                                    if (value.success == "1")
                                    {
                                      showToast(value.message, context);
                                      Navigator.pop(context);
                                      getHolidayList(true);
                                    }
                                    else
                                    {
                                      showToast(value.message, context);
                                    }
                                  },
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          side: const BorderSide(
                                              color: black,
                                              width: 1,
                                              style: BorderStyle.solid
                                          ),
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                      ),
                                      backgroundColor: MaterialStateProperty.all<Color>(black)
                                  ),
                                  child: isLoading
                                      ? const Padding(
                                    padding: EdgeInsets.only(top: 10,bottom: 10),
                                    child: SizedBox(width: 20,height: 20,child: CircularProgressIndicator(color: black,strokeWidth: 2)),
                                  )
                                      : const Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: Text(
                                      "Yes",
                                      style: TextStyle(
                                          color: white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void showActionBottomsheet(HolidayList getSet) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)
          )
      ),
      elevation: 5,
      isDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, updateState) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                children: [
                  Container(height: 8,),
                  Center(
                    child: Container(
                        height: 2,
                        width: 40,
                        color: black,
                        margin: const EdgeInsets.only(bottom: 12)
                    ),
                  ),
                  const Center(
                    child: Text("Select Action",
                      style: TextStyle(
                          fontSize: 18, color: black,fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(height: 12,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => AddHolidayScreen(getSet)));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Image.asset('assets/images/ic_edit.png', height: 20, width: 20,),
                                    Container(width: 12,),
                                    const Text("Edit",
                                        style: TextStyle(fontSize: 16, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                                  ],
                                ),
                              ),
                            ),
                            const Divider(
                              thickness: 0.5,
                              endIndent: 0,
                              indent: 0,
                              color: grayLight,
                            ),

                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: (){
                                Navigator.pop(context);
                                showDeleteBottomsheet(getSet);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Image.asset('assets/images/ic_delete.png', height: 20, width: 20,),
                                    Container(width: 12,),
                                    const Text("Delete",
                                        style: TextStyle(fontSize: 16, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider(
                              thickness: 0.5,
                              endIndent: 0,
                              indent: 0,
                              color: grayLight,
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class HolidayManager {
  List<HolidayList> _holidays = [];

  // Getter for all holidays
  List<HolidayList> get holidays => _holidays;

  // Setter for all holidays
  set holidays(List<HolidayList> holidays) {
    _holidays = holidays;
  }

  // Add a holiday
  void addHoliday(HolidayList holiday) {
    _holidays.add(holiday);
  }

  // Separate holidays by year and month
  Map<int, Map<int, List<HolidayList>>> separateHolidaysByYearAndMonth() {
    Map<int, Map<int, List<HolidayList>>> separatedHolidays = {};

    for (HolidayList holiday in _holidays) {
      int year = int.parse(universalDateConverter("dd-MM-yyyy", "yyyy",holiday.holidayDate ?? ''));
      int month = int.parse(universalDateConverter("dd-MM-yyyy", "MM",holiday.holidayDate ?? ''));

      // Create year map if not exists
      separatedHolidays[year] ??= {};

      // Create month list if not exists
      separatedHolidays[year]?[month] ??= [];

      // Add the holiday to the corresponding year and month
      separatedHolidays[year]?[month]?.add(holiday);
    }

    return separatedHolidays;
  }
}