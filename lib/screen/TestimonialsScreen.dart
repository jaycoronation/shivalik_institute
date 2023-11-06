import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shivalik_institute/model/CaseStudyResponseModel.dart';
import 'package:shivalik_institute/model/HolidayResponseModel.dart';
import 'package:shivalik_institute/model/ManagmentResponseModel.dart';
import 'package:shivalik_institute/model/TestimonialsResponseModel.dart';
import 'package:shivalik_institute/utils/app_utils.dart';
import 'package:shivalik_institute/viewmodels/CaseStudyViewModel.dart';
import 'package:shivalik_institute/viewmodels/HolidayViewModel.dart';
import 'package:shivalik_institute/viewmodels/ManagmentViewModel.dart';
import 'package:shivalik_institute/viewmodels/TestimonialsViewModel.dart';

import '../common_widget/common_widget.dart';
import '../common_widget/loading.dart';
import '../common_widget/no_data_new.dart';
import '../constant/api_end_point.dart';
import '../constant/colors.dart';
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

  @override
  void initState(){
    super.initState();
    getTestimonialsList();

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
          getTestimonialsList();
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
                                    getTestimonialsList();
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
                                  getTestimonialsList();
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
                          ? Expanded(
                        child: ListView.builder(
                          controller: _scrollViewController,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: listTestimonials.length,
                          itemBuilder: (context, index) {
                            var getSet = listTestimonials[index];
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
                                        child: Text("Name ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                      ),
                                      const Text(" : ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                      Expanded(
                                        flex: 2,
                                        child: Text("${getSet.name}",style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                        child: Text("Title ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                      ),
                                      const Text(" : ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                      Expanded(
                                        flex: 2,
                                        child: Text("${getSet.title}",style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                        child: Text(getSet.description ?? '',style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                        child: Text(getSet.isActive == "1" ?"Active" : "InActive",style: TextStyle(color: getSet.isActive == "1" ? Colors.green : Colors.red,fontSize: 14,fontWeight: FontWeight.w600),),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      )
                          : const MyNoDataNewWidget(msg: "No Testimonials Founds", img: "")
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

  Future<void> getTestimonialsList() async {
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
      listTestimonials = [];
      listTestimonials.addAll(testimonialsViewModel.response.list ?? []);
    }
  }

  @override
  void castStatefulWidget() {
    widget is TestimonialsScreen;
  }
}