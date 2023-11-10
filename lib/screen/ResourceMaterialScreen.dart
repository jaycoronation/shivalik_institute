import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:provider/provider.dart';
import 'package:shivalik_institute/common_widget/loading.dart';
import 'package:shivalik_institute/common_widget/no_data_new.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common_widget/common_widget.dart';
import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../model/CommonResponseModel.dart';
import '../model/LecturesResponseModel.dart';
import '../model/MaterialDetailResponseModel.dart';
import '../model/ModuleResponseModel.dart';
import '../utils/app_utils.dart';
import '../utils/base_class.dart';
import '../viewmodels/CommonViewModel.dart';
import 'package:http/http.dart' as http;
import '../viewmodels/LectureViewModel.dart';
import '../viewmodels/MultipartApiViewModel.dart';

class ResourceMaterialScreen extends StatefulWidget {
  final ModuleList getSet;
  final LectureList classGetSet;
  const ResourceMaterialScreen(this.getSet, this.classGetSet, {super.key});

  @override
  BaseState<ResourceMaterialScreen> createState() => _ResourceMaterialScreenState();
}

class _ResourceMaterialScreenState extends BaseState<ResourceMaterialScreen> {

  String isForCoverPic = "coverPic";
  TextEditingController searchController = TextEditingController();
  String searchParam = "";
  bool searchVisibility = false;
  bool _isLoading = false;
  bool isLoading = false;
  int _pageIndex = 1;
  bool _isSearchHideShow = false;
  final int _pageResult = 10;
  List<MaterialData> listDocument = [];
  late ScrollController _scrollViewController;
  bool isScrollingDown = false;
  bool _isLastPage = false;
  bool _isLoadingMore = false;

  @override
  void initState(){
    super.initState();
    getClassesDocumentData(true);

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
                Navigator.pop(context);
              },
              child: getBackArrow(),
            ),
            titleSpacing: 0,
            centerTitle: false,
            title: getTitle("Submisssions",),
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
          body: _isLoading
              ? const LoadingWidget()
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
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: listDocument.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 150, crossAxisSpacing: 10, mainAxisSpacing: 10),
                      controller: _scrollViewController,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: listDocument.length,
                      itemBuilder: (context, indexInner) {
                        var getSet = listDocument[index].documets?[indexInner] ?? Documets();
                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () async {
                            await launchUrl(Uri.parse(getSet.fullPath ?? ""),mode: LaunchMode.externalApplication);
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
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.file_copy_outlined,size: 28,),
                                    Gap(18),
                                    Text("${getSet.file}",style: TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400),)
                                  ],
                                ),
                                Container(height: 12,),
                                Positioned(
                                  bottom: 5,
                                  right: 5,
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: (){
                                      showDeleteBottomsheet(getSet);
                                    },
                                    child: Image.asset("assets/images/ic_delete.png",
                                      width: 22, height: 22,
                                      color: black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                )
              ],
            ),
          )
              : const MyNoDataNewWidget(msg: "Upload Submission",  img: ''),
          floatingActionButton:  FloatingActionButton(
            onPressed: () {
              pickImageFromGallery();
            },
            child: const Icon(Icons.add),
          ),
      ),
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(true);
      },
    );
  }

  @override
  void castStatefulWidget() {
    widget is ResourceMaterialScreen;
  }

  void showDeleteBottomsheet(Documets getSet) {
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
        request.fields['class_id'] = (widget as ResourceMaterialScreen).classGetSet.id ?? "";
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

    final url = Uri.parse(materialListUrl);
    Map<String, String> jsonBody = {
      'batch_id': "",
      'class_id': (widget as ResourceMaterialScreen).classGetSet.id ?? '',
      'flag': "",
      'limit': _pageResult.toString(),
      'page': _pageIndex.toString(),
      'search': searchParam,
      'module_id': (widget as ResourceMaterialScreen).getSet.id ?? '',
      'status': "1",
      'total': "0",
      'student_id': sessionManager.getUserId() ?? '',
      "type":"worksheet",
      'from_app' : FROM_APP
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> order = jsonDecode(body);
    var dataResponse = MaterialDetailResponseModel.fromJson(order);

    if (isFirstTime) {
      if (listDocument?.isNotEmpty ?? false) {
        listDocument = [];
      }
    }

    if (statusCode == 200) {

      if (dataResponse.data?.isNotEmpty ?? false) {
        List<MaterialData>? _tempList = [];
        _tempList = dataResponse.data;
        listDocument?.addAll(_tempList!);

        if (_tempList?.isNotEmpty ?? false) {
          _pageIndex += 1;
          if (_tempList?.isEmpty ?? false || _tempList!.length % _pageResult != 0 ) {
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