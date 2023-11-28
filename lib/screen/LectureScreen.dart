import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shivalik_institute/common_widget/loading.dart';
import 'package:shivalik_institute/common_widget/no_data_new.dart';
import 'package:shivalik_institute/model/ModuleResponseModel.dart';
import 'package:shivalik_institute/model/UserListResponseModel.dart';
import 'package:shivalik_institute/viewmodels/LectureViewModel.dart';
import 'package:shivalik_institute/viewmodels/UserListViewModel.dart';
import '../common_widget/common_widget.dart';
import '../common_widget/loading_more.dart';
import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../model/LecturesResponseModel.dart';
import '../utils/base_class.dart';

class LectureScreen extends StatefulWidget {
  final ModuleList moduleGetSet;
  final String filter;
  const LectureScreen(this.moduleGetSet, this.filter, {super.key});

  @override
  BaseState<LectureScreen> createState() => _LectureScreenState();
}

class _LectureScreenState extends BaseState<LectureScreen> {

  List<LectureList> listLecture = [];
  List<UserList> listFaculty = [];
  int _pageIndex = 1;
  final int _pageResult = 10;
  bool _isSearchHideShow = false;
  String searchParam = "";
  TextEditingController searchController = TextEditingController();
  late ScrollController _scrollViewController;
  bool isScrollingDown = false;
  bool _isLastPage = false;
  bool _isLoadingMore = false;
  ModuleList moduleGetSet = ModuleList();
  String filterType = "";
  String fromDateApi = "";
  String toDateApi = "";
  String selectedDateFilter = "Today";
  String dateSelectionChanged = "";
  String fromDateDisplay = "";
  String toDateDisplay = "";
  String selectedFaculty = '';
  String selectedFacultyId = '';
  List<String> dateFilterList = ["All", "Today", "Yesterday", "Last 7 Days", "Last 30 Days", "This Month", "Last Month", "Custom range"];

  @override
  void initState(){
    super.initState();
    moduleGetSet = (widget as LectureScreen).moduleGetSet;
    filterType = (widget as LectureScreen).filter;
    getLectureList(true);
    getFacultyList();

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
          getLectureList(false);
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
            title: getTitle("Lecture",),
            actions: [
              Visibility(
                visible: true,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () {
                    showDateFilterBottomSheet();
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    child: Padding(padding: const EdgeInsets.all(10.0), child: Image.asset('assets/images/ic_calendar_new.png', width: 24, height: 24)),
                  ),
                ),
              ),
              const Gap(8),
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
          body: Consumer<LectureViewModel>(
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
                        Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  showFacultyBottomSheet();
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(top: 10, bottom: 5, left: 15),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: black),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(selectedFaculty.isNotEmpty ? selectedFaculty : "Select Faculty", textAlign: TextAlign.start,
                                          style: const TextStyle(fontSize: 16, color: black, fontWeight: FontWeight.w600),
                                        ),
                                        const Gap(5),
                                        Image.asset('assets/images/ic_arrow_down.png', width: 18, height: 18, color: black,),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: fromDateApi.isNotEmpty,
                                child: Container(
                                  margin: const EdgeInsets.only(top: 10, bottom: 5, left: 15),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: black),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(toDateDisplay == fromDateDisplay ? fromDateDisplay :"$fromDateDisplay - $toDateDisplay", textAlign: TextAlign.start,
                                          style: const TextStyle(fontSize: 16, color: black, fontWeight: FontWeight.w600),
                                        ),
                                        const Gap(5),
                                        Image.asset('assets/images/ic_close.png', width: 18, height: 18, color: black,),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
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
                                      getLectureList(true);
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
                                      listLecture = [];
                                    });
                                    getLectureList(true);
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
                        listLecture.isNotEmpty
                            ? Expanded(
                          child: ListView.builder(
                            controller: _scrollViewController,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: listLecture.length ?? 0,
                            itemBuilder: (context, index) {
                              var getSet = listLecture[index];
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
                                          child: Text("No ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                        ),
                                        const Text(" : ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                        Expanded(
                                          flex: 2,
                                          child: Text(getSet?.classNoFormat ?? "",style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                          child: Text("Date & Time ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                        ),
                                        const Text(" : ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                        Expanded(
                                          flex: 2,
                                          child: Text("${getSet?.date} ${getSet.startTime} - ${getSet.endTime}",style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                          child: Text("Module ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                        ),
                                        const Text(" : ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                        Expanded(
                                          flex: 2,
                                          child: Text(getSet.moduleDetails?.name ?? "",style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                          child: Text("Faculty ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                        ),
                                        const Text(" : ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                        Expanded(
                                          flex: 2,
                                          child: Text("${getSet.session1FacultyName} ${getSet.session2FacultyName}",style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                          child: Text(getSet.isActive == "1" ? "Active" : "InActive",style: TextStyle(color: getSet.isActive == "1" ? Colors.green : Colors.red,fontSize: 14,fontWeight: FontWeight.w600),),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                            : const MyNoDataNewWidget(msg: "No Lecture Founds", img: ""),
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

  Future<void> getLectureList(bool isFirstTime) async {
    if (isFirstTime) {
      setState(() {
        _isLoadingMore = false;
        _pageIndex = 1;
        _isLastPage = false;
      });
    }

    Map<String, String> jsonBody = {
      'batch_id': "",
      'faculty_id': selectedFacultyId,
      'filter': '',
      'filter_by_class_status': "",
      'filter_name': "Filter",
      'from_date_filter': fromDateApi,
      'to_date_filter': toDateApi,
      'module_id': moduleGetSet.id ?? '',
      'limit': _pageResult.toString(),
      'page': _pageIndex.toString(),
      'search': searchParam,
      'status': "1",
      'total': "0",
      'student_id': sessionManager.getUserId().toString(),
      'from_app' : FROM_APP
    };
    var moduleViewModel = Provider.of<LectureViewModel>(context,listen: false);
    await moduleViewModel.getModuleList(jsonBody);

    if (moduleViewModel.response.success == "1")
      {
        List<LectureList>? _tempList = [];
        _tempList = moduleViewModel.response.lectureList;
        listLecture?.addAll(_tempList!);

        print(listLecture?.length);

        if (_tempList?.isNotEmpty ?? false) {
          _pageIndex += 1;
          if (_tempList?.isEmpty ?? false || _tempList!.length % _pageResult != 0 ) {
            _isLastPage = true;
          }
        }

        // listLecture = moduleViewModel.response.lectureList ?? [];
      }

  }

  Future<void> getFacultyList() async {

    Map<String, String> jsonBody = {
      'filter': "faculty",
      'limit': "",
      'page': "",
      'search': "",
      'from_app' : FROM_APP
    };

    var facultyViewModel = Provider.of<UserListViewModel>(context,listen: false);
    await facultyViewModel.getUserList(jsonBody);

    if (facultyViewModel.response.success == "1")
    {
      listFaculty = [];
      listFaculty.add(UserList(id: "",firstName: "All",lastName: ""));
      listFaculty.addAll(facultyViewModel.response.list ?? []);
      print("list faculty${listFaculty.length}");
    }
  }

  showDateFilterBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
      ),
      elevation: 5,
      isDismissible: true,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            Padding(
                padding: const EdgeInsets.all(14),
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(height: 2, width : 40, color: black, margin: const EdgeInsets.only(bottom:12)),
                    const Text("Select Date Rage",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: black, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Container(height: 12),
                    ListView.builder(
                      itemCount: dateFilterList.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        var getSet = dateFilterList[index];
                        return Visibility(
                          visible: getSet != "All",
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () async {
                              setState(() {
                                selectedDateFilter = getSet;
                              });

                              if (selectedDateFilter == "All") {
                                fromDateApi = "";
                                toDateApi = "";
                                getLectureList(true);
                                Navigator.pop(context);
                              } else if (selectedDateFilter == "Today") {
                                var now = DateTime.now();
                                var formatter = DateFormat('yyyy-MM-dd');
                                String formattedDate = formatter.format(now);
                                fromDateApi = formattedDate;
                                toDateApi = formattedDate;

                                String startDateFormatDisplay = DateFormat('dd MMM yyyy').format(now);
                                String endDateFormatDisplay = DateFormat('dd MMM yyyy').format(now);

                                fromDateDisplay = startDateFormatDisplay;
                                toDateDisplay = endDateFormatDisplay;

                                getLectureList(true);
                                Navigator.pop(context);
                              } else if (selectedDateFilter == "Tomorrow") {
                                var now = DateTime.now().add(const Duration(days: 1));
                                var formatter = DateFormat('yyyy-MM-dd');
                                String formattedDate = formatter.format(now);
                                fromDateApi = formattedDate;
                                toDateApi = formattedDate;

                                String startDateFormatDisplay = DateFormat('dd MMM yyyy').format(now);
                                String endDateFormatDisplay = DateFormat('dd MMM yyyy').format(now);

                                fromDateDisplay = startDateFormatDisplay;
                                toDateDisplay = endDateFormatDisplay;

                                getLectureList(true);
                                Navigator.pop(context);
                              } else if (selectedDateFilter == "Yesterday") {
                                var now = DateTime.now().subtract(const Duration(days: 1));
                                var formatter = DateFormat('yyyy-MM-dd');
                                String formattedDate = formatter.format(now);
                                fromDateApi = formattedDate;
                                toDateApi = formattedDate;

                                String startDateFormatDisplay = DateFormat('dd MMM yyyy').format(now);
                                String endDateFormatDisplay = DateFormat('dd MMM yyyy').format(now);

                                fromDateDisplay = startDateFormatDisplay;
                                toDateDisplay = endDateFormatDisplay;

                                getLectureList(true);
                                Navigator.pop(context);
                              } else if (selectedDateFilter == "Last 7 Days") {
                                var now = DateTime.now().subtract(const Duration(days: 6));
                                var formatter = DateFormat('yyyy-MM-dd');
                                String formattedDate = formatter.format(now);
                                var todayDate = DateTime.now();
                                var formatterToday = DateFormat('yyyy-MM-dd');
                                String formattedDateToday = formatterToday.format(todayDate);
                                fromDateApi = formattedDate;
                                toDateApi = formattedDateToday;

                                String startDateFormatDisplay = DateFormat('dd MMM yyyy').format(now);
                                String endDateFormatDisplay = DateFormat('dd MMM yyyy').format(todayDate);

                                fromDateDisplay = startDateFormatDisplay;
                                toDateDisplay = endDateFormatDisplay;

                                getLectureList(true);
                                Navigator.pop(context);
                              } else if (selectedDateFilter == "Last 30 Days") {
                                var now = DateTime.now().subtract(const Duration(days: 30));
                                var formatter = DateFormat('yyyy-MM-dd');
                                String formattedDate = formatter.format(now);
                                var todayDate = DateTime.now();
                                var formatterToday = DateFormat('yyyy-MM-dd');
                                String formattedDateToday = formatterToday.format(todayDate);
                                fromDateApi = formattedDate;
                                toDateApi = formattedDateToday;

                                String startDateFormatDisplay = DateFormat('dd MMM yyyy').format(now);
                                String endDateFormatDisplay = DateFormat('dd MMM yyyy').format(todayDate);

                                fromDateDisplay = startDateFormatDisplay;
                                toDateDisplay = endDateFormatDisplay;

                                getLectureList(true);
                                Navigator.pop(context);
                              } else if (selectedDateFilter == "This Month") {
                                var now = DateTime.now();
                                var formatter = DateFormat('yyyy-MM');
                                String formattedDate = "${formatter.format(now)}-01";
                                var todayDate = DateTime.now();
                                var formatterToday = DateFormat('yyyy-MM-dd');
                                String formattedDateToday = formatterToday.format(todayDate);
                                fromDateApi = formattedDate;
                                toDateApi = formattedDateToday;

                                String startDateFormatDisplay = DateFormat('dd MMM yyyy').format(now);
                                String endDateFormatDisplay = DateFormat('dd MMM yyyy').format(todayDate);

                                fromDateDisplay = startDateFormatDisplay;
                                toDateDisplay = endDateFormatDisplay;

                                getLectureList(true);
                                Navigator.pop(context);
                              } else if (selectedDateFilter == "Last Month") {
                                var formatterToday = DateFormat('yyyy-MM-dd');
                                final now = DateTime.now();
                                var firstDayOfMonth = DateTime(now.year, now.month, 1);
                                var lastDayOfMonth = DateTime(now.year, now.month, 0);
                                final nowFinalStart = DateTime.now();
                                String formattedDateStart =
                                formatterToday.format(DateTime(nowFinalStart.year, nowFinalStart.month - 1, firstDayOfMonth.day));
                                final nowFinalStartEnd = DateTime.now();
                                String formattedDateEnd = formatterToday
                                    .format(DateTime(nowFinalStartEnd.year, nowFinalStartEnd.month - 1, lastDayOfMonth.day));
                                fromDateApi = formattedDateStart;
                                toDateApi = formattedDateEnd;

                                String startDateFormatDisplay = DateFormat('dd MMM yyyy').format(now);
                                String endDateFormatDisplay = DateFormat('dd MMM yyyy').format(nowFinalStartEnd);

                                fromDateDisplay = startDateFormatDisplay;
                                toDateDisplay = endDateFormatDisplay;

                                getLectureList(true);
                                Navigator.pop(context);
                              } else if (selectedDateFilter == "Custom range") {
                                Navigator.pop(context);

                                DateTimeRange? result = await showDateRangePicker(
                                    context: context,
                                    firstDate: DateTime(2022, 1, 1),
                                    lastDate: DateTime.now().add(const Duration(hours: 1)),
                                    initialEntryMode: DatePickerEntryMode.calendar,
                                    currentDate: DateTime.now(),
                                    saveText: 'Done',
                                    builder: (context, Widget? child) => Theme(
                                      data: Theme.of(context).copyWith(
                                          appBarTheme: Theme.of(context).appBarTheme.copyWith(
                                              backgroundColor: black,
                                              iconTheme: Theme.of(context).appBarTheme.iconTheme?.copyWith(color: Colors.white)),
                                          scaffoldBackgroundColor: white,
                                          colorScheme: const ColorScheme.light(onPrimary: white, primary: black)),
                                      child: child!,
                                    ));

                                if (result != null) {
                                  DateTime? startDate = result.start;
                                  DateTime? endDate = result.end;
                                  String startDateFormat = DateFormat('dd MMM yyyy').format(startDate);
                                  String endDateFormat = DateFormat('dd MMM yyyy').format(endDate);
                                  dateSelectionChanged = "$startDateFormat to $endDateFormat";
                                  //textEditingController.text = dateSelectionChanged;

                                  String startDateFormatDisplay = DateFormat('dd MMM yyyy').format(startDate);
                                  String endDateFormatDisplay = DateFormat('dd MMM yyyy').format(endDate);

                                  fromDateDisplay = startDateFormatDisplay;
                                  toDateDisplay = endDateFormatDisplay;


                                  final splitted = dateSelectionChanged.split("to");
                                  var inputFormat = DateFormat('dd MMM yyyy');
                                  var outputFormat = DateFormat('yyyy-MM-dd');
                                  var startDateNew = inputFormat.parse(splitted[0].trim());
                                  var endDateNew = inputFormat.parse(splitted[1].trim()); // <-- dd/MM 24H format
                                  var startDateFinal = outputFormat.format(startDateNew);
                                  var endDateFinal = outputFormat.format(endDateNew);
                                  fromDateApi = startDateFinal;
                                  toDateApi = endDateFinal;
                                  getLectureList(true);
                                  Navigator.pop(context);
                                }
                              }

                              setState(() {});

                            },
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                  margin: const EdgeInsets.only(top: 6, right: 12),
                                  child: Text(
                                    getSet.toString(),
                                    style: TextStyle(
                                        fontWeight: getSet == selectedDateFilter ? FontWeight.w500 : FontWeight.w400,
                                        color: black,
                                        fontSize: 14),
                                  ),
                                ),
                                const Divider(color: Colors.transparent,height: 0.7,thickness: 0.7,)
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  ],
                )
            ),
          ],
        );
      },
    );
  }

  showFacultyBottomSheet() {
    print(listFaculty.length);

    showModalBottomSheet<void>(
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)
          )
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, updateState) {
            return ConstrainedBox(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.88),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(height: 10,),
                    Center(
                      child: Container(
                          height: 2,
                          width: 40,
                          color: black,
                          margin: const EdgeInsets.only(bottom: 12)
                      ),
                    ),
                    Container(height: 8,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text("Select Faculty" ,
                              style: TextStyle(fontSize: 16, color:black,fontWeight: FontWeight.w600),textAlign: TextAlign.center),
                        ),
                        Container(height: 12,),
                        ListView.builder(
                          itemCount: listFaculty.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            var getSet = listFaculty[index];
                            return Visibility(
                              visible: getSet != "All",
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () async {
                                  setState(() {
                                    selectedFacultyId = getSet.id ?? '';
                                    selectedFaculty = "${getSet.firstName} ${getSet.lastName}";
                                  });
                                  getLectureList(true);
                                  Navigator.pop(context);
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                      margin: const EdgeInsets.only(top: 6, right: 12),
                                      child: Text(
                                        "${getSet.firstName} ${getSet.lastName}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: black,
                                            fontSize: 14
                                        ),
                                      ),
                                    ),
                                    const Divider(
                                      color: Colors.transparent,
                                      height: 0.7,
                                      thickness: 0.7,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

  }

  @override
  void castStatefulWidget() {
    widget is LectureScreen;
  }

}