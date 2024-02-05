import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shivalik_institute/common_widget/loading.dart';
import 'package:shivalik_institute/common_widget/placeholder.dart';
import 'package:shivalik_institute/constant/api_end_point.dart';
import 'package:shivalik_institute/constant/colors.dart';
import 'package:shivalik_institute/screen/DashboardScreen.dart';
import 'package:shivalik_institute/screen/FacultyProfileScreen.dart';
import 'package:shivalik_institute/screen/WebViewContainer.dart';
import 'package:shivalik_institute/utils/pdf_viewer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../common_widget/common_widget.dart';
import '../model/CommonResponseModel.dart';
import '../model/LectureDetailsResponseModel.dart';
import '../utils/app_utils.dart';
import '../utils/base_class.dart';
import '../viewmodels/CommonViewModel.dart';
import '../viewmodels/MultipartApiViewModel.dart';

class LectureDetailsScreen extends StatefulWidget {
  final String classId;
  const LectureDetailsScreen(this.classId, {super.key});

  @override
  BaseState<LectureDetailsScreen> createState() => _LectureDetailsScreenState();
}

class _LectureDetailsScreenState extends BaseState<LectureDetailsScreen> {

  bool isLoading = false;
  String classId = '';
  Details lectureGetSet = Details();
  late CommonViewModel commonViewModel;
  List<ClassMaterial> listClassMaterial = [];

  @override
  void initState(){
    commonViewModel = Provider.of<CommonViewModel>(context,listen: false);

    classId = (widget as LectureDetailsScreen).classId;
    lectureDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: grayButton,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: appBg,
            leading:  InkWell(
              borderRadius: BorderRadius.circular(52),
              onTap: () {
                if (Navigator.canPop(context))
                  {
                    Navigator.pop(context, true);
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
            title: getTitle("Lecture Details",),
          ),
          body: isLoading
              ? Shimmer.fromColors(
                      baseColor: Colors.grey.shade100 ,
                      highlightColor: Colors.grey.shade400,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child:Container(
                          margin: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                          child: Column(
                            children: [
                              LargeContainerPlaceholder(width: MediaQuery.of(context).size.width),
                            ],
                          ),
                        )
                      ),
              )

              : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Card(
                  elevation: 1,
                  margin: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: lectureGetSet.isCancelled == "1",
                          child: Column(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(6, 3, 6, 3),
                                    decoration: BoxDecoration(color: brandColor,borderRadius: BorderRadius.circular(6)),
                                    child: const Text("Lecture is Cancelled",style: TextStyle(fontWeight: FontWeight.w500,color: white,fontSize: 16)),
                                  ),
                                  const Gap(12),
                                  Text(lectureGetSet.cancelReason ?? '', style: const TextStyle(color: black,fontWeight: FontWeight.w400,fontSize: 14),),
                                ],
                              ),
                              const Gap(12),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(
                              TextSpan(
                                style: const TextStyle(fontWeight: FontWeight.w400, color: black, fontSize: 16),
                                children: <TextSpan>[
                                  const TextSpan(text: "Lecture of ", style: TextStyle(fontWeight: FontWeight.w400, color: black, fontSize: 16)),
                                  TextSpan(text: lectureGetSet.moduleDetails?.name ?? '', style: const TextStyle(fontWeight: FontWeight.w500, color: brandColor, fontSize: 16)),
                                  const TextSpan(text: ' Class number ', style: TextStyle(fontWeight: FontWeight.w400, color: black, fontSize: 16)),
                                  TextSpan(text: lectureGetSet.classNo ?? '', style: const TextStyle(fontWeight: FontWeight.w500, color: brandColor, fontSize: 16)),
                                  const TextSpan(text: ' is schedule on ', style: TextStyle(fontWeight: FontWeight.w400, color: black, fontSize: 16)),
                                  TextSpan(text: universalDateConverter("yyy-MM-dd", "dd MMM, yyyy", lectureGetSet.date ?? ''), style: const TextStyle(fontWeight: FontWeight.w500, color: brandColor, fontSize: 16)),
                                  const TextSpan(text: ' from ', style: TextStyle(fontWeight: FontWeight.w400, color: black, fontSize: 16)),
                                  TextSpan(text: "${lectureGetSet.startTime} to ${lectureGetSet.endTime}", style: const TextStyle(fontWeight: FontWeight.w500, color: brandColor, fontSize: 16)),
                                ],
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                        const Gap(12),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Session 1", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 16),),
                            const Gap(8),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                startActivity(context, FacultyProfileScreen(lectureGetSet.session1Faculty ?? ''));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Expanded(flex: 1,child: Text("Faculty", style: TextStyle(color: black,fontWeight: FontWeight.w500,fontSize: 16),)),
                                  Expanded(flex: 3,child: Text("${lectureGetSet.session1FacultyName}", style: const TextStyle(color: brandColor,fontWeight: FontWeight.w500,fontSize: 14,overflow: TextOverflow.clip),)),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Expanded(flex: 1,child: Text("Topic", style: TextStyle(color: black,fontWeight: FontWeight.w500,fontSize: 16),)),
                                Expanded(flex: 3,child: Text("${lectureGetSet.session1Topic}", style: const TextStyle(color: black,fontWeight: FontWeight.w400,fontSize: 14,overflow: TextOverflow.clip),)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Expanded(flex: 1,child: Text("Type", style: TextStyle(color: black,fontWeight: FontWeight.w500,fontSize: 16),)),
                                Expanded(flex: 3,child: Text("${lectureGetSet.session1LectureType}", style: const TextStyle(color: black,fontWeight: FontWeight.w400,fontSize: 14,overflow: TextOverflow.clip),)),
                              ],
                            ),
                            Visibility(
                              visible: lectureGetSet.session1Starttime?.isNotEmpty ?? false,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Expanded(flex: 1,child: Text("Time", style: TextStyle(color: black,fontWeight: FontWeight.w500,fontSize: 16),)),
                                  Expanded(flex: 3,child: Text(lectureGetSet.session1Endtime?.isEmpty ?? false ? lectureGetSet.session1Starttime ?? '' : "${lectureGetSet.session1Starttime} To ${lectureGetSet.session1Endtime}", style: const TextStyle(color: black,fontWeight: FontWeight.w400,fontSize: 14),)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: lectureGetSet.session2FacultyName?.isNotEmpty ?? false,
                          child: Column(
                            children: [
                              const Gap(12),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Session 2", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 16),),
                                  const Gap(8),
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      startActivity(context, FacultyProfileScreen(lectureGetSet.session2Faculty ?? ''));
                                    },
                                    child: Row(
                                      children: [
                                        const Expanded(flex: 1,child: Text("Faculty - ", style: TextStyle(color: black,fontWeight: FontWeight.w500,fontSize: 16),)),
                                        Expanded(flex: 3,child: Text("${lectureGetSet.session2FacultyName}", style: const TextStyle(color: brandColor,fontWeight: FontWeight.w500,fontSize: 14),)),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(flex: 1,child: Text("Topic - ", style: TextStyle(color: black,fontWeight: FontWeight.w500,fontSize: 16),)),
                                      Expanded(flex: 3,child: Text("${lectureGetSet.session2Topic}", style: const TextStyle(color: black,fontWeight: FontWeight.w400,fontSize: 14),)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(flex: 1,child: Text("Type - ", style: TextStyle(color: black,fontWeight: FontWeight.w500,fontSize: 16),)),
                                      Expanded(flex: 3,child: Text("${lectureGetSet.session2LectureType}", style: const TextStyle(color: black,fontWeight: FontWeight.w400,fontSize: 14),)),
                                    ],
                                  ),
                                  Visibility(
                                    visible: lectureGetSet.session1Starttime?.isNotEmpty ?? false,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Expanded(flex: 1,child: Text("Time - ", style: TextStyle(color: black,fontWeight: FontWeight.w500,fontSize: 16),)),
                                        Expanded(flex: 3,child: Text(lectureGetSet.session1Endtime?.isEmpty ?? false ? lectureGetSet.session1Starttime ?? '' : "${lectureGetSet.session1Starttime} To ${lectureGetSet.session1Endtime}", style: const TextStyle(color: black,fontWeight: FontWeight.w400,fontSize: 14),)),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),
                        const Gap(12),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Module", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 16),),
                            const Gap(8),
                            Row(
                              children: [
                                const Expanded(flex: 1,child: Text("Name", style: TextStyle(color: black,fontWeight: FontWeight.w500,fontSize: 16),)),
                                Expanded(flex: 3,child: Text("${lectureGetSet.moduleDetails?.name}", style: const TextStyle(color: black,fontWeight: FontWeight.w400,fontSize: 14),)),
                              ],
                            ),
                            const Gap(6),
                            Text("${lectureGetSet.moduleDetails?.description}", style: const TextStyle(color: black,fontWeight: FontWeight.w400,fontSize: 15),),
                          ],
                        ),
                        Visibility(
                          visible: listClassMaterial.isNotEmpty,
                          child: Column(
                            children: [
                              const Gap(12),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Material", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 16),),
                                  const Gap(12),
                                  MediaQuery.removePadding(
                                    context: context,
                                    removeTop: true,
                                    removeBottom: true,
                                    child: ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: listClassMaterial.length,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                        var getSet = listClassMaterial[index];
                                          return GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap: () async {

                                              if (getSet.fileType == "pdf")
                                                {
                                                  startActivity(context, PdfViewer(getSet.fullPath ?? '', getSet.isPrivate ?? '0'));
                                                }
                                              else if (getSet.fileType == "pptx")
                                                {
                                                  startActivity(context, WebViewContainer(getSet.fullPath ?? '', "" ,getSet.isPrivate ?? '0'));
                                                }
                                              else
                                                {
                                                  startActivity(context, WebViewContainer(getSet.fullPath ?? '', "" ,getSet.isPrivate ?? '0'));
                                                }
                                            },
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      const Icon(Icons.file_present,color: brandColor,size: 28,),
                                                      const Gap(6),
                                                      Expanded(child: Text(getSet.file ?? '', style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: black,overflow: TextOverflow.clip),)),
                                                      RotatedBox(
                                                          quarterTurns: 3,
                                                          child: Image.asset('assets/images/ic_arrow_down.png',width: 18,height: 18,)
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                const Divider(color: grayNew,height: 0.7,thickness: 0.7,)
                                              ],
                                            ),
                                          );
                                        },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: lectureGetSet.allowUploadSubmissions == "1",
                          child: Column(
                            children: [
                              const Gap(12),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Submission", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 16),),
                                  const Gap(12),
                                  MediaQuery.removePadding(
                                    context: context,
                                    removeTop: true,
                                    removeBottom: true,
                                    child: ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: lectureGetSet.classWorksheet?.length ?? 0,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        var getSet = lectureGetSet.classWorksheet?[index] ?? ClassWorksheet();
                                        return GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () async {
                                            if (await canLaunchUrl(Uri.parse(getSet.fullPath ?? '')))
                                            {
                                              launchUrl(Uri.parse(getSet.fullPath ?? ''),mode: LaunchMode.externalApplication);
                                            }
                                          },
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Icon(Icons.file_present,color: brandColor,size: 28,),
                                                    const Gap(6),
                                                    Expanded(child: Text(getSet.file ?? '', style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: black,overflow: TextOverflow.clip),)),
                                                    GestureDetector(
                                                      behavior: HitTestBehavior.opaque,
                                                      onTap: () {
                                                        showDeleteBottomSheet(getSet.id ?? '');
                                                      },
                                                      child: Container(
                                                        width: 32,
                                                        height: 32,
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Image.asset('assets/images/ic_delete.png',width: 18,height: 18,),
                                                      ),
                                                    )

                                                  ],
                                                ),
                                              ),
                                              const Divider(color: grayNew,height: 0.7,thickness: 0.7,)
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  const Gap(18),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: getCommonButton("Upload Submission", () {
                                      pickImageFromGallery();
                                    }, isLoading),
                                  ),
                                  const Gap(18),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        ),
        onWillPop: () {
          Navigator.pop(context);
          return Future.value(true);
        },
    );
  }

  Future<void> pickImageFromGallery() async {
    final commonViewModel = Provider.of<MultipartApiViewModel>(context,listen: false);

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf'],allowCompression: true,allowMultiple: false);

      if (result != null) {

        File pickedFile = File(result.files.single.path!);
        var request = http.MultipartRequest('POST', Uri.parse(uploadResourceAddUrl));

        // Add file to the request
        var file = await http.MultipartFile.fromPath('files[0]', pickedFile.path);
        request.files.add(file);
        request.fields['class_id'] = lectureGetSet.id ?? '';
        request.fields['student_id'] = sessionManager.getUserId() ?? "";
        request.fields['document_type'] = 'worksheet';

        await commonViewModel.uploadFile(request);
        CommonResponseModel value = commonViewModel.response;
        if (value.success == "1")
        {
          showToast(value.message, context);
          lectureDetails();
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

  void showDeleteBottomSheet(String docId) {

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
                        const Text("Delete Submission",
                          style: TextStyle(
                              fontSize: 18, color: black,fontWeight: FontWeight.w500),textAlign: TextAlign.left,
                        ),
                        Container(
                          height: 10,
                        ),
                        const Text("Are you sure you want to delete this submission?",
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
                                      'doc_id': docId,
                                    };
                                    await commonViewModel.deleteResourceData(jsonBody);
                                    CommonResponseModel value = commonViewModel.response;
                                    if (value.success == "1")
                                    {
                                      showToast(value.message, context);
                                      Navigator.pop(context);
                                      lectureDetails();
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

  lectureDetails() async {
    setState(() {
      isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(lectureDetailsUrl);

    Map<String, String> jsonBody = {
      'student_id': sessionManager.getUserId() ?? '',
      'class_id': classId,
      'from_app': FROM_APP,
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> apiResponse = jsonDecode(body);
    var dataResponse = LectureDetailsResponseModel.fromJson(apiResponse);
    if (statusCode == 200 && dataResponse.success == "1")
      {
        setState(() {
          lectureGetSet = dataResponse.details ?? Details();

          if (lectureGetSet.classMaterial?.isNotEmpty ?? false)
            {
              List<ClassMaterial> listTempMaterial = lectureGetSet.classMaterial ?? [];
              for (var i=0; i < listTempMaterial.length;i++)
                {
                  if (listTempMaterial[i].allowMaterialAccess == "1")
                    {
                      listClassMaterial.add(listTempMaterial[i]);
                    }
                }
            }

          isLoading = false;
        });
      }
    else
      {
        setState(() {
          isLoading = false;
        });
      }
  }


  @override
  void castStatefulWidget() {
    widget is LectureDetailsScreen;
  }
}