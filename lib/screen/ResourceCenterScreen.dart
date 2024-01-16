import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shivalik_institute/common_widget/loading.dart';
import 'package:shivalik_institute/common_widget/no_data_new.dart';
import 'package:shivalik_institute/viewmodels/ModuleViewModel.dart';

import '../common_widget/common_widget.dart';
import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../model/ModuleResponseModel.dart';
import '../utils/base_class.dart';
import 'ResourceCenterClassScreen.dart';

class ResourceCenterScreen extends StatefulWidget {
  final bool isForSubmission;
  const ResourceCenterScreen(this.isForSubmission, {super.key});

  @override
  BaseState<ResourceCenterScreen> createState() => _ResourceCenterScreenState();
}

class _ResourceCenterScreenState extends BaseState<ResourceCenterScreen> {

  TextEditingController searchController = TextEditingController();
  String searchParam = "";
  bool searchVisibility = false;
  int _pageIndex = 1;
  bool _isSearchHideShow = false;
  final int _pageResult = 10;
  List<ModuleList> listModule = [];
  late ScrollController _scrollViewController;
  bool isScrollingDown = false;
  bool _isLastPage = false;
  bool _isLoadingMore = false;
  bool isForSubmission = false;

  @override
  void initState(){
    super.initState();
    getModuleData();

    isForSubmission = (widget as ResourceCenterScreen).isForSubmission;

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
          getModuleData();
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
            title: getTitle(isForSubmission ? "Submission" : "Resource Center",),
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
          body: Consumer<ModuleViewModel>(
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
                    padding: const EdgeInsets.only(left: 18.0, right: 18),
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
                                margin: const EdgeInsets.only(top: 12),
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
                                      getModuleData();
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
                                      listModule = [];
                                    });
                                    getModuleData();
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
                        const Gap(12),
                        Expanded(
                          child: ListView.builder(
                            controller: _scrollViewController,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: listModule.length ?? 0,
                            itemBuilder: (context, index) {
                              var getSet = listModule[index];
                              return GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  if (isForSubmission)
                                    {
                                      startActivity(context, ResourceCenterClassScreen(getSet,true));
                                    }
                                  else
                                    {
                                      startActivity(context, ResourceCenterClassScreen(getSet,false));
                                    }
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(isForSubmission ? "assets/images/ic_submission.png" : "assets/images/ic_resource.png" , height: 22,width: 22),
                                      const Gap(12),
                                      Text("${index + 1} ${getSet.moduleName}",style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400),)
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  );
                }
                else
                {
                  return const MyNoDataNewWidget(msg: "No Module Found", img: "");
                }
              }
            },
          )
      ),
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(true);
      },
    );
  }

  @override
  void castStatefulWidget() {
    widget is ResourceCenterScreen;
  }

  Future<void> getModuleData() async {
    Map<String, String> jsonBody = {
      'batch_id': "",
      'limit': _pageResult.toString(),
      'page': _pageIndex.toString(),
      'search': searchParam,
      'status': "1",
      'total': "0",
      'student_id': sessionManager.getUserId() ?? '',
      'from_app' : FROM_APP
    };
    var moduleViewModel = Provider.of<ModuleViewModel>(context,listen: false);
    await moduleViewModel.getModuleList(jsonBody);

    if (moduleViewModel.response.success == '1')
    {
       setState(() {
         var listModuleTemp = moduleViewModel.response.list ?? [];


         if (isForSubmission)
           {
             for (var i=0; i < listModuleTemp.length; i++)
             {
               if (listModuleTemp[i].hasSubmission == "1")
               {
                 listModule.add(listModuleTemp[i]);
               }
             }
           }
         else
           {
             for (var i=0; i < listModuleTemp.length; i++)
             {
               if (listModuleTemp[i].allowMaterialAccess == "1")
               {
                 listModule.add(listModuleTemp[i]);
               }
             }
           }

         print("listModule ==== ${listModule.length}");
       });

    }

  }

}