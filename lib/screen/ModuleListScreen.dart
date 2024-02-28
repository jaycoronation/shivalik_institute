import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shivalik_institute/common_widget/loading.dart';
import 'package:shivalik_institute/common_widget/no_data_new.dart';
import 'package:shivalik_institute/screen/ModuleDetailsScreen.dart';
import 'package:shivalik_institute/viewmodels/ModuleViewModel.dart';

import '../common_widget/common_widget.dart';
import '../common_widget/loading_more.dart';
import '../common_widget/placeholder.dart';
import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../model/ModuleResponseModel.dart';
import '../utils/base_class.dart';

class ModuleListScreen extends StatefulWidget {
  final String type;
  const ModuleListScreen(this.type, {super.key});

  @override
  BaseState<ModuleListScreen> createState() => _ModuleListScreenState();
}

class _ModuleListScreenState extends BaseState<ModuleListScreen> {
  
  TextEditingController searchController = TextEditingController();
  String moduleType = "";
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

  @override
  void initState(){
    super.initState();
    moduleType = (widget as ModuleListScreen).type;
    getModuleData(true);

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
          print("is loading == ${((!_isLoadingMore))}");
          _isLoadingMore = true;
          getModuleData(false);
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
           title: getTitle("Modules",),
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
             if ((value.isLoading) && (_isLoadingMore == false))
               {
                 return Shimmer.fromColors(
                   baseColor: Colors.grey.shade100 ,
                   highlightColor: Colors.grey.shade400,
                   child: Padding(
                     padding: const EdgeInsets.only(left: 18.0, right: 18,top: 18),
                     child: Column(
                       children: [
                         SmallListContainerPlaceholder(width: MediaQuery.of(context).size.width,),
                         Container(height: 14,),
                         SmallListContainerPlaceholder(width: MediaQuery.of(context).size.width,),
                         Container(height: 14,),
                         SmallListContainerPlaceholder(width: MediaQuery.of(context).size.width,),
                         Container(height: 14,),
                         SmallListContainerPlaceholder(width: MediaQuery.of(context).size.width,),
                         Container(height: 14,),
                         SmallListContainerPlaceholder(width: MediaQuery.of(context).size.width,),
                         Container(height: 14,),
                         SmallListContainerPlaceholder(width: MediaQuery.of(context).size.width,),
                         Container(height: 14,),
                         SmallListContainerPlaceholder(width: MediaQuery.of(context).size.width,),

                       ],
                     ),
                   ),

                 );
               }
             else
               {
                 if (value.response.success == "1")
                   {
                     return Padding(
                       padding: const EdgeInsets.only(left: 18.0, right: 18),
                       child: Column(
                         children: [
                           Expanded(
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
                                               getModuleData(true);
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
                                             getModuleData(true);
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
                                 const Gap(18),

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
                                           //startActivity(context, ModuleDetailsScreen(getSet));
                                         },
                                         child: Container(
                                           margin: const EdgeInsets.only(bottom: 22),
                                           // padding: const EdgeInsets.all(12),
                                           decoration: BoxDecoration(
                                             color: white,
                                             borderRadius: BorderRadius.circular(8),
                                           ),
                                           child: Column(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               Row(
                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                 children: [
                                                   Container(
                                                     padding: const EdgeInsets.all(6),
                                                     decoration: const BoxDecoration(
                                                       color: black,
                                                       borderRadius: BorderRadius.only(
                                                           topRight: Radius.circular(0.0),
                                                           bottomRight: Radius.circular(8.0),
                                                           topLeft: Radius.circular(8.0),
                                                           bottomLeft: Radius.circular(0.0)
                                                       ),
                                                     ),
                                                       child:Text(" Modules ${index + 1} ", style: const TextStyle(color: white,fontSize: 14,fontWeight: FontWeight.w400)),
                                                   ),
                                                   Container(
                                                     padding: const EdgeInsets.all(6),
                                                     decoration:  BoxDecoration(
                                                       color: getSet.status == "Completed" ? greenBg : redBg,
                                                       borderRadius: const BorderRadius.only(
                                                           topRight: Radius.circular(8.0),
                                                           bottomRight: Radius.circular(0.0),
                                                           topLeft: Radius.circular(0.0),
                                                           bottomLeft: Radius.circular(8.0)
                                                       ),
                                                     ),
                                                     child: Text(getSet.status ?? "",
                                                       style: TextStyle(color: getSet.status == "Completed" ? Colors.green : Colors.red,fontSize: 14,fontWeight: FontWeight.w400),
                                                     ),
                                                   ),
                                                 ],
                                               ),
                                               const Gap(12),
                                               Padding(
                                                 padding: const EdgeInsets.only(left: 12,right: 12),
                                                 child: Row(
                                                   mainAxisAlignment: MainAxisAlignment.start,
                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                                   children: [
                                                     const Expanded(
                                                       flex: 1,
                                                       child: Text("Name ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                                     ),
                                                     Expanded(
                                                       flex: 2,
                                                       child: Text(getSet.moduleName ?? "",style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400),),
                                                     ),
                                                   ],
                                                 ),
                                               ),
                                               const Gap(12),
                                               Padding(
                                                 padding: const EdgeInsets.only(left: 12,right: 12),
                                                 child: Row(
                                                   mainAxisAlignment: MainAxisAlignment.start,
                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                                   children: [
                                                     const Expanded(
                                                       flex: 1,
                                                       child: Text("Duration ",style: TextStyle(color: grayDarkNew,fontSize: 14,fontWeight: FontWeight.w400),),
                                                     ),
                                                     Expanded(
                                                       flex: 2,
                                                       child: Text("${getSet.duration}hr",style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400),),
                                                     ),
                                                   ],
                                                 ),
                                               ),

                                               const Gap(12),
                                             ],
                                           ),
                                         ),
                                       );
                                     },
                                   ),
                                 ),
                               ],
                             ),
                           ),
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
    widget is ModuleListScreen;
  }

  Future<void> getModuleData(bool isFirstTime) async {
    if (isFirstTime) {
      setState(() {
        _isLoadingMore = false;
        _pageIndex = 1;
        _isLastPage = false;
      });
    }

    Map<String, String> jsonBody = {
      'batch_id': "",
      'limit': _pageResult.toString(),
      'page': _pageIndex.toString(),
      'search': searchParam,
      'status': "1",
      'total': "0",
      'student_id': sessionManager.getUserId().toString(),
      'from_app' : FROM_APP
    };
    var moduleViewModel = Provider.of<ModuleViewModel>(context,listen: false);
    await moduleViewModel.getModuleList(jsonBody);

    if (isFirstTime) {
      if (listModule.isNotEmpty) {
        listModule = [];
      }
    }
    if (moduleViewModel.response.success == '1')
      {
        if (moduleType == 'all')
          {
            List<ModuleList>? _tempList = [];
            _tempList = moduleViewModel.response.list;
            listModule.addAll(_tempList!);

            print(listModule.length);


            if (_tempList.isNotEmpty) {
              _pageIndex += 1;
              if (_tempList.isEmpty || _tempList.length % _pageResult != 0 ) {
                _isLastPage = true;
              }
            }
          }
        else if (moduleType == "pending")
          {
            List<ModuleList>? _tempList = [];
            _tempList = moduleViewModel.response.list;
            moduleViewModel.response.list?.forEach((element) {
              if (element.status == "Pending")
              {
                listModule.add(element);
              }
            });
            print(listModule.length);


            if (_tempList?.isNotEmpty ?? false) {
              _pageIndex += 1;
              if (_tempList?.isEmpty ?? false || _tempList!.length % _pageResult != 0 ) {
                _isLastPage = true;
              }
            }
          }
        else if (moduleType == "completed")
          {
            List<ModuleList>? _tempList = [];
            _tempList = moduleViewModel.response.list;
            moduleViewModel.response.list?.forEach((element) {
              if (element.status == "Completed")
              {
                listModule.add(element);
              }
            });
            print(listModule.length);


            if (_tempList?.isNotEmpty ?? false) {
              _pageIndex += 1;
              if (_tempList?.isEmpty ?? false || _tempList!.length % _pageResult != 0 ) {
                _isLastPage = true;
              }
            }

          }

        print("IS LAST PAGE === ${_isLastPage}");

      }


    setState(() {
      _isLoadingMore = false;
    });
  }

}