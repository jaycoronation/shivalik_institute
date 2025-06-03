import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gap/gap.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shivalik_institute/common_widget/no_data_new.dart';
import 'package:shivalik_institute/constant/global_context.dart';
import 'package:shivalik_institute/screen/DashboardScreen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common_widget/common_widget.dart';
import '../common_widget/placeholder.dart';
import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../model/CommonResponseModel.dart';
import '../model/LecturesResponseModel.dart';
import '../model/MaterialDResponseModel.dart';
import '../model/MaterialDetailResponseModel.dart';
import '../model/MediaListResponseModel.dart';
import '../model/ModuleResponseModel.dart';
import '../utils/app_utils.dart';
import '../utils/base_class.dart';
import '../utils/pdf_viewer.dart';
import '../utils/pptx_viewer.dart';
import '../viewmodels/CommonViewModel.dart';
import 'package:http/http.dart' as http;
import '../viewmodels/MultipartApiViewModel.dart';
import 'WebViewContainer.dart';

class MaterialDetailScreen extends StatefulWidget {
  final ModuleList getSet;
  final LectureList classGetSet;
  const MaterialDetailScreen(this.getSet, this.classGetSet, {super.key});

  @override
  BaseState<MaterialDetailScreen> createState() => _MaterialDetailScreenState();
}

class _MaterialDetailScreenState extends BaseState<MaterialDetailScreen> {

  ModuleList getSetData = ModuleList();
  String isForCoverPic = "coverPic";
  TextEditingController searchController = TextEditingController();
  String searchParam = "";
  bool searchVisibility = false;
  bool isLoading = false;
  int _pageIndex = 1;
  bool _isSearchHideShow = false;
  final int _pageResult = 10;
  List<Files> listDocument = [];
  List<MaterialDataList> listDocumentMain = [];

  late ScrollController _scrollViewController;
  bool isScrollingDown = false;
  bool _isLastPage = false;
  bool _isLoadingMore = false;
  bool _isLoading = false;

  @override
  void initState(){
    super.initState();

    getSetData = (widget as MaterialDetailScreen).getSet;

    if ((widget as MaterialDetailScreen).classGetSet.date?.isNotEmpty ?? false)
      {
        getClassesDocumentDataMain(true,);
      }
    else
      {
        getClassesDocumentData(true,);
      }

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
          getClassesDocumentData();
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
              if (Navigator.canPop(context))
                {
                  Navigator.pop(context);
                }
              else
                {
                  startActivityRemove(context, const DashboardScreen());
                }
            },
            child: getBackArrow(),
          ),
          titleSpacing: 0,
          centerTitle: false,
          title: getTitle("Material",),
          actions: const [
            /*InkWell(
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
            ),*/
            Gap(12),
          ],
        ),
        body: _isLoading
            ? Shimmer.fromColors(
                baseColor: Colors.grey.shade100 ,
                highlightColor: Colors.grey.shade400,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         LargeContainerPlaceholder(width: MediaQuery.of(context).size.width),
                         Container(height: 18,),
                         LargeContainerPlaceholder(width: MediaQuery.of(context).size.width),
                      ],
                    ),
                  ),
              ),
          )
            : listDocumentMain.isNotEmpty
            ? Padding(
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
                            getClassesDocumentDataMain();
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
                            listDocumentMain = [];
                          });
                          getClassesDocumentData();
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
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  removeBottom: true,
                  child: ListView.builder(
                    controller: _scrollViewController,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: listDocumentMain.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () async {

                          openFileView(context, listDocumentMain[index].fileType ?? '', listDocumentMain[index].fullPath ?? "", listDocumentMain[index].isPrivate ?? "", listDocumentMain[index].file ?? "",);

                          /*if (listDocument[index].fileType == "pdf")
                                  {
                                    startActivity(context, PdfViewer(listDocument[index].fullPath ?? "",listDocument[index].isPrivate ?? "",listDocument[index].file ?? "",));
                                  }
                                else if ((listDocument[index].fileType == "xls") || (listDocument[index].fileType == "xlsx"))
                                  {
                                    Uri fileUri = Uri.parse(listDocument[index]. fullPath?? "");

                                    if (await canLaunchUrl(fileUri))
                                      {
                                        launchUrl(fileUri,mode: LaunchMode.externalApplication);
                                      }
                                  }
                                else if (listDocument[index].fileType == "pptx")
                                  {
                                    startActivity(context, PPTXViewer(listDocument[index].fullPath ?? '', listDocument[index].isPrivate ?? '0',listDocument[index].file ?? ''));
                                  }
                                else
                                  {
                                    startActivity(context, WebViewContainer(listDocument[index].fullPath ?? "",'',listDocument[index].isPrivate ?? ''));
                                  }*/
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Stack(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset("assets/images/ic_resource.png" , height: 22,width: 22),
                                  const Gap(12),
                                  Expanded(
                                    child: Text(
                                      listDocumentMain[index].file ?? '',
                                      maxLines: 3,
                                      style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400,overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                  Image.asset("assets/images/ic_arrow_right.png",width: 22,height: 22,),
                                ],
                              ),
                              Container(height: 12,),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        )
            : listDocument.isNotEmpty
            ? Padding(
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
                                  getClassesDocumentData();
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
                                  listDocument = [];
                                });
                                getClassesDocumentData();
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
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        removeBottom: true,
                        child: ListView.builder(
                          controller: _scrollViewController,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: listDocument.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () async {

                                openFileView(context, listDocument[index].fileType ?? '', listDocument[index].media ?? "", listDocument[index].isPrivate ?? "", listDocument[index].fileName ?? "",);

                                /*if (listDocument[index].fileType == "pdf")
                                  {
                                    startActivity(context, PdfViewer(listDocument[index].fullPath ?? "",listDocument[index].isPrivate ?? "",listDocument[index].file ?? "",));
                                  }
                                else if ((listDocument[index].fileType == "xls") || (listDocument[index].fileType == "xlsx"))
                                  {
                                    Uri fileUri = Uri.parse(listDocument[index]. fullPath?? "");

                                    if (await canLaunchUrl(fileUri))
                                      {
                                        launchUrl(fileUri,mode: LaunchMode.externalApplication);
                                      }
                                  }
                                else if (listDocument[index].fileType == "pptx")
                                  {
                                    startActivity(context, PPTXViewer(listDocument[index].fullPath ?? '', listDocument[index].isPrivate ?? '0',listDocument[index].file ?? ''));
                                  }
                                else
                                  {
                                    startActivity(context, WebViewContainer(listDocument[index].fullPath ?? "",'',listDocument[index].isPrivate ?? ''));
                                  }*/
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Stack(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.asset("assets/images/ic_resource.png" , height: 22,width: 22),
                                        const Gap(12),
                                        Expanded(
                                          child: Text(
                                            listDocument[index].fileName ?? '',
                                            maxLines: 3,
                                            style: const TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400,overflow: TextOverflow.ellipsis),
                                          ),
                                        ),
                                        Image.asset("assets/images/ic_arrow_right.png",width: 22,height: 22,),
                                      ],
                                    ),
                                    Container(height: 12,),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : const MyNoDataNewWidget(msg: "No Material Found",  img: ''),
      ),
      onWillPop: () {
        if (Navigator.canPop(context))
        {
          Navigator.pop(context);
        }
        else
        {
          startActivityRemove(context, const DashboardScreen());
        }
        return Future.value(true);
      },
    );
  }


  @override
  void castStatefulWidget() {
    widget is MaterialDetailScreen;
  }

  void showDeleteBottomsheet(MaterialData getSet) {
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
                                    Navigator.pop(context);
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
                                      'doc_id':getSet.id ?? "",
                                    };
                                    await commonViewModel.deleteResourceData(jsonBody);
                                    CommonResponseModel value = commonViewModel.response;
                                    if (value.success == "1")
                                    {
                                      showToast(value.message, context);
                                      Navigator.pop(context);
                                      getClassesDocumentData();
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

  Future<void> pickImageFromGallery() async {
    final commonViewModel = Provider.of<MultipartApiViewModel>(context,listen: false);

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {

        File pickedFile = File(result.files.single.path!);
        var request = http.MultipartRequest('POST', Uri.parse(uploadResourceAddUrl));

        // Add file to the request
        var file = await http.MultipartFile.fromPath('files[0]', pickedFile.path);
        request.files.add(file);

        // Add other form data if needed
        request.fields['key'] = 'value';
        request.fields['class_id'] = (widget as MaterialDetailScreen).classGetSet.id ?? "";
        request.fields['student_id'] = sessionManager.getUserId() ?? "";
        request.fields['document_type'] = 'worksheet';

        await commonViewModel.uploadFile(request);
        CommonResponseModel value = commonViewModel.response;
        if (value.success == "1")
        {
          showToast(value.message, context);
          getClassesDocumentData();
        }
        else
        {
          showToast(value.message, context);
        }
      } else {
        // User canceled the picker
      }
    } on Exception catch (e) {
      print(e);
    }
  }

/*
  Future<void> getClassesDocumentData() async {
    Map<String, String> jsonBody = {
      'batch_id': "",
      'class_id': (widget as MaterialDetailScreen).classGetSet.id ?? '',
      'flag': "",
      'limit': _pageResult.toString(),
      'page': _pageIndex.toString(),
      'search': searchParam,
      'module_id': (widget as MaterialDetailScreen).getSet.id ?? '',
      'status': "1",
      'total': "0",
      'student_id': "",
      "type":"material",
      'from_app' : FROM_APP
    };
    var materialViewModel = Provider.of<MaterialDetailViewModel>(context,listen: false);
    await materialViewModel.getMaterialList(jsonBody);

    if (materialViewModel.response.success == '1')
    {
      listDocument = materialViewModel.response.data ?? [];
      print(jsonEncode(materialViewModel.response.data));
      print(jsonEncode(listDocument));
    }

  }
*/

  void getClassesDocumentData([bool isFirstTime = false, bool isFromClose = false]) async {

    if (isFirstTime) {
      setState(() {
        _isLoading = true;
        _isLoadingMore = false;
        _pageIndex = 1;
        _isLastPage = false;
      });
    }

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(materialDetailListUrl);
    /*Map<String, String> jsonBody = {
      'batch_id': "",
      'class_id': NavigationService.notif_id.isNotEmpty ? NavigationService.notif_id : (widget as MaterialDetailScreen).classGetSet.id ?? '',
      'flag': "",
      'limit': _pageResult.toString(),
      'page': _pageIndex.toString(),
      'search': searchParam,
      'module_id': (widget as MaterialDetailScreen).getSet.id ?? '',
      'status': "1",
      'total': "0",
      'student_id': sessionManager.getUserId() ?? '',
      "type": "material",
      'from_app' : FROM_APP
    };*/

    Map<String, String> jsonBody = {
      'from_app' : FROM_APP,
      'parent_id' : NavigationService.notif_id.isNotEmpty ? NavigationService.notif_id : (widget as MaterialDetailScreen).classGetSet.id ?? '',
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> order = jsonDecode(body);
    var dataResponse = MediaListResponseModel.fromJson(order);

    if (isFirstTime) {
      if (listDocument.isNotEmpty) {
        listDocument = [];
      }
    }

    if (statusCode == 200) {

      if (dataResponse.mediaList?.files?.isNotEmpty ?? false) {
        List<Files>? _tempList = [];
        _tempList = dataResponse?.mediaList?.files ?? [];
        listDocument.addAll(_tempList!);

        if (_tempList.isNotEmpty)
          {
            _pageIndex += 1;
            if (_tempList.isEmpty || _tempList.length % _pageResult != 0 )
              {
                _isLastPage = true;
              }
          }
      }
      else
      {
      }

      setState(() {
        _isLoading = false;
        _isLoadingMore = false;
      });

    }else {
      setState(() {
        _isLoading = false;
        _isLoadingMore = false;
      });
    }

  }

  void getClassesDocumentDataMain([bool isFirstTime = false, bool isFromClose = false]) async {

    if (isFirstTime) {
      setState(() {
        _isLoading = true;
        _isLoadingMore = false;
        _pageIndex = 1;
        _isLastPage = false;
      });
    }

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(materialDetailListUrlFocDocs);
    Map<String, String> jsonBody = {
      'batch_id': "",
      'class_id': NavigationService.notif_id.isNotEmpty ? NavigationService.notif_id : (widget as MaterialDetailScreen).classGetSet.id ?? '',
      'flag': "",
      'limit': _pageResult.toString(),
      'page': _pageIndex.toString(),
      'search': searchParam,
      'module_id': (widget as MaterialDetailScreen).getSet.id ?? '',
      'status': "1",
      'total': "0",
      'student_id': sessionManager.getUserId() ?? '',
      "type": "material",
      'from_app' : FROM_APP
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> order = jsonDecode(body);
    var dataResponse = MaterialDResponseModel.fromJson(order);

    if (isFirstTime) {
      if (listDocumentMain.isNotEmpty) {
        listDocumentMain = [];
      }
    }

    if (statusCode == 200) {

      if (dataResponse.list?.isNotEmpty ?? false) {
        List<MaterialDataList>? _tempList = [];
        _tempList = dataResponse.list;
        listDocumentMain.addAll(_tempList!);

        if (_tempList.isNotEmpty)
        {
          _pageIndex += 1;
          if (_tempList.isEmpty || _tempList.length % _pageResult != 0 )
          {
            _isLastPage = true;
          }
        }
      }
      else
      {
      }

      setState(() {
        _isLoading = false;
        _isLoadingMore = false;
      });

    }else {
      setState(() {
        _isLoading = false;
        _isLoadingMore = false;
      });
    }

  }


}