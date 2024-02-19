import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shivalik_institute/common_widget/loading.dart';
import 'package:shivalik_institute/constant/colors.dart';
import 'package:shivalik_institute/model/CommonResponseModel.dart';
import 'package:shivalik_institute/model/PendingFeedbackResponseModel.dart';
import 'package:shivalik_institute/screen/DashboardScreen.dart';

import '../common_widget/common_widget.dart';
import '../constant/api_end_point.dart';
import '../model/LectureDetailsResponseModel.dart' as lecture;
import '../utils/app_utils.dart';
import '../utils/base_class.dart';

class FeedbackFormScreenNew extends StatefulWidget {
  final List<Records> listFeedbacks;
  const FeedbackFormScreenNew(this.listFeedbacks, {super.key});

  @override
  BaseState<FeedbackFormScreenNew> createState() => _FeedbackFormScreenNewState();
}

class _FeedbackFormScreenNewState extends BaseState<FeedbackFormScreenNew> with TickerProviderStateMixin {

  bool isLoading = false;
  bool isSaving = false;
  //Details getSet = Details();
  lecture.Details lectureGetSet = lecture.Details();
  List<Questions> listQuestions = [];
  List<Records> listPendingFeedbacks = [];
  String formId = '';
  String classId = '';
  String currentIndex = '1';
  int indexToPass = 0;
  String pageTitle = '';
  PageController pageController = PageController(initialPage: 0);

  @override
  void initState(){
    super.initState();
    listPendingFeedbacks = (widget as FeedbackFormScreenNew).listFeedbacks;

    formId = listPendingFeedbacks[0].feedbackFormId ?? '';
    classId = listPendingFeedbacks[0].classId ?? '';
    pageTitle = listPendingFeedbacks[0].feedbackFormData?.formName ?? '';

    for (var i=0; i < listPendingFeedbacks.length; i++)
    {
      for (var j=0; j < (listPendingFeedbacks[i].feedbackFormData?.questions?.length ?? 0); j++)
        {
          if (j == 0)
          {
            listPendingFeedbacks[i].feedbackFormData?.questions?[j].isOpen = true;
          }
          listPendingFeedbacks[i].feedbackFormData?.questions?[j].animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300), upperBound: 0.5,);
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
          toolbarHeight: kToolbarHeight,
          backgroundColor: appBg,
          centerTitle: false,
          title: getTitle(pageTitle),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 16,bottom: 16),
              child: Text("$currentIndex/${listPendingFeedbacks.length}",style: const TextStyle(fontSize: 16,color: black,fontWeight: FontWeight.w600),),
            ),
            const Gap(12)
          ],
        ),
        body: isLoading
            ? const LoadingWidget()
            : Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: PageView.builder(
                  controller: pageController,
                  itemCount: listPendingFeedbacks.length,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (value) {
                    setState(() {
                      formId = listPendingFeedbacks[value].feedbackFormId ?? '';
                      classId = listPendingFeedbacks[value].classId ?? '';
                      currentIndex = (value + 1).toString();
                      indexToPass = value;
                      pageTitle = listPendingFeedbacks[value].feedbackFormData?.formName ?? '';
                    });
                  },
                  itemBuilder: (context, index) {
                  var getSet = listPendingFeedbacks[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 22,bottom: 22),
                                child: Text(
                                    'Leave your feedback of the ${getSet.moduleName} session by ${getSet.facultyName}',
                                    style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: black,fontFamily: 'Colfax',),textAlign: TextAlign.start,
                                ),
                              ),
                              MediaQuery.removePadding(
                                context: context,
                                removeBottom: true,
                                removeTop: true,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: getSet.feedbackFormData?.questions?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    var getSetInner = getSet.feedbackFormData?.questions?[index] ?? Questions();
                                    return Container(
                                      decoration: BoxDecoration(
                                          color: white,
                                          borderRadius: BorderRadius.circular(16),
                                          border: Border.all(color: grayLight,width: 1)
                                      ),
                                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                                      margin: const EdgeInsets.only(bottom: 22),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap: () {
                                              setState(() {
                                                for (var i=0; i < (getSet.feedbackFormData?.questions?.length ?? 0); i++)
                                                {
                                                  if (i == index)
                                                  {
                                                    if (getSet.feedbackFormData?.questions?[i].isOpen ?? false)
                                                    {
                                                      getSet.feedbackFormData?.questions?[i].animationController.reverse(from: 0.5);
                                                    }
                                                    else
                                                    {
                                                      getSet.feedbackFormData?.questions?[i].animationController.forward(from: 0.0);
                                                    }
                                                    getSet.feedbackFormData?.questions?[i].isOpen = true;

                                                  }
                                                  else
                                                  {
                                                    getSet.feedbackFormData?.questions?[i].isOpen = false;
                                                  }
                                                }
                                              });
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("${index+1}. ",style: const TextStyle(color: black,fontWeight: FontWeight.w500,fontSize: 16,fontFamily: 'Colfax'),),
                                                      Expanded(child: Text(getSetInner.title ?? '',style: const TextStyle(color: black,fontWeight: FontWeight.w500,fontSize: 16,fontFamily: 'Colfax',overflow: TextOverflow.clip),)),
                                                    ],
                                                  ),
                                                ),
                                                RotationTransition(
                                                  turns: Tween(begin: 0.0, end: 1.0).animate(getSetInner.animationController),
                                                  child: const Icon(Icons.expand_less),
                                                )
                                              ],
                                            ),
                                          ),
                                          Visibility(
                                            visible: getSetInner.isOpen,
                                            child: getSetInner.inputName == "checkbox"
                                                ? ListView.builder(
                                                  shrinkWrap: true,
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  itemCount: getSetInner.options?.length ?? 0,
                                                  itemBuilder: (context, indexInner) {
                                                    var getSetInnerQuestion = getSetInner.options?[indexInner] ?? Options();
                                                    return GestureDetector(
                                                      behavior: HitTestBehavior.opaque,
                                                      onTap: () {
                                                        setState(() {
                                                          getSetInnerQuestion.isSelected = !getSetInnerQuestion.isSelected;
                                                        });
                                                      },
                                                      child: Container(
                                                        padding: const EdgeInsets.all(8),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Image.asset(
                                                              getSetInnerQuestion.isSelected
                                                                  ? "assets/images/ic_checked.png"
                                                                  : "assets/images/ic_un_checked.png",
                                                              width: 24,
                                                              height: 24,
                                                              color: getSetInnerQuestion.isSelected ? brandColor : black,
                                                            ),
                                                            const Gap(8),
                                                            Text(
                                                                getSetInnerQuestion.options ?? '',
                                                                style: const TextStyle(fontSize: 14,color: black,fontWeight: FontWeight.w400,fontFamily: 'Colfax')
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                )
                                                : getSetInner.inputName == "radio"
                                                ? SizedBox(
                                                  height: 60,
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    scrollDirection: Axis.horizontal,
                                                    physics: const NeverScrollableScrollPhysics(),
                                                    itemCount: getSetInner.options?.length ?? 0,
                                                    itemBuilder: (context, indexInner) {
                                                      var getSetInnerQuestion = getSetInner.options?[indexInner] ?? Options();
                                                      return GestureDetector(
                                                        behavior: HitTestBehavior.opaque,
                                                        onTap: () {
                                                          setState(() {
                                                            for (var i=0; i < (getSetInner.options?.length ?? 0); i++)
                                                            {
                                                              if (indexInner == i)
                                                              {
                                                                getSetInner.options?[i].isSelected = true;
                                                              }
                                                              else
                                                              {
                                                                getSetInner.options?[i].isSelected = false;
                                                              }
                                                            }
                                                          });
                                                        },
                                                        child: Container(
                                                          padding: const EdgeInsets.all(8),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Image.asset(
                                                                getSetInnerQuestion.isSelected
                                                                    ? "assets/images/ic_radio_selected.png"
                                                                    : "assets/images/ic_radio_unselected.png",
                                                                width: 24,
                                                                height: 24,
                                                              ),
                                                              const Gap(8),
                                                              Text(
                                                                  getSetInnerQuestion.options ?? '',
                                                                  style: const TextStyle(fontSize: 14,color: black,fontWeight: FontWeight.w400,fontFamily: 'Colfax')
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                )
                                                : getSetInner.inputName == "textarea"
                                                ? Container(
                                                  margin: const EdgeInsets.only(top: 6),
                                                  child: TextField(
                                                    cursorColor: black,
                                                    textCapitalization: TextCapitalization.sentences,
                                                    controller: getSetInner.controller,
                                                    keyboardType: TextInputType.text,
                                                    maxLines: 5,
                                                    minLines: 3,
                                                    style: getTextFiledStyle(),
                                                    decoration: const InputDecoration(
                                                        hintText: 'Answer',
                                                        alignLabelWithHint: true,
                                                        enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(color: Colors.transparent, width: 0.0),
                                                        ),
                                                        border: OutlineInputBorder(
                                                          borderSide: BorderSide(color: Colors.transparent, width: 0.0),
                                                        ),
                                                        focusedBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(color: Colors.transparent, width: 0.0),
                                                        )
                                                    ),
                                                  ),
                                                )
                                                : getSetInner.inputName == "text"
                                                ? Container(
                                                  margin: const EdgeInsets.only(top: 12),
                                                  child: TextField(
                                                    cursorColor: black,
                                                    textCapitalization: TextCapitalization.sentences,
                                                    controller: getSetInner.controller,
                                                    keyboardType: TextInputType.text,
                                                    style: getTextFiledStyle(),
                                                    decoration: const InputDecoration(
                                                        hintText: 'Answer',
                                                        enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(color: Colors.transparent, width: 0.0),
                                                        ),
                                                        border: OutlineInputBorder(
                                                          borderSide: BorderSide(color: Colors.transparent, width: 0.0),
                                                        ),
                                                        focusedBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(color: Colors.transparent, width: 0.0),
                                                        )
                                                    ),
                                                  ),
                                                )
                                                : Container(),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.fromLTRB(8, 12, 8, 42),
                          child: getCommonButton("Submit", () {
                            if (checkValidation(getSet.feedbackFormData?.questions ?? []))
                            {
                              print(getAnswers(getSet.feedbackFormData?.questions ?? []));
                              saveFeedbackForm(getSet.feedbackFormData?.questions ?? []);
                            }
                          }, isSaving),
                        )
                      ],
                    );
                  },
              ),
            ),
      ),
      onWillPop: () {
        showSnackBar("Please fill feedback form first", context);
        return Future.value(false);
      },
    );
  }

  Widget getRadioButtons(Questions getSet){
    return Wrap(
      runSpacing: 6,
      spacing: 6,
      children: getSet.options!.map((e) {
          return buildStageChip(e,getSet);
        },
      ).toList(),
    );
  }

  Widget buildStageChip(Options getSetInner, Questions getSet) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          for (var i=0; i < (getSet.options?.length ?? 0); i++)
          {
            if (getSetInner.optId == getSet.options?[i].optId)
              {
                getSet.options?[i].isSelected = true;
              }
            else
              {
                getSet.options?[i].isSelected = false;
              }
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              getSetInner.isSelected
                  ? "assets/images/ic_radio_selected.png"
                  : "assets/images/ic_radio_unselected.png",
              width: 24,
              height: 24,
            ),
            const Gap(8),
            Text(
                getSetInner.options ?? '',
                style: const TextStyle(fontSize: 14,color: black,fontWeight: FontWeight.w400,fontFamily: 'Colfax')
            ),
          ],
        ),
      ),
    );
  }

  void showThankYouDialog() async {

    Navigator.of(context).push(MaterialPageRoute<String>(
        builder: (BuildContext context) {
          return Scaffold(
            backgroundColor: white,
            appBar: AppBar(
              toolbarHeight: kToolbarHeight,
              elevation: 0,
              leading: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  closeAndStartActivity(context, const DashboardScreen());
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 4,right: 4,top: 4,bottom: 4),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset('assets/images/ic_close.png', width: 48, height: 48,),
                  ),
                ),
              ),
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset('assets/images/thank_you_animation.json'),
                  const Gap(22),
                  const Text("Thank you for your Feedback",style: TextStyle(fontSize: 22,color: black,fontWeight: FontWeight.w600),)
                ],
              ),
            ),
          );
        },
        fullscreenDialog: true
    ));

  }

  /*getFeedbackForm() async {
    setState(() {
      isLoading = true;
    });

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(feedbackFormUrl);

    final response = await http.get(url);

    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = FeedbackFormResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == "1")
    {
      getSet = dataResponse.details ?? Details();
      listQuestions = getSet.questions ?? [];

      for (var i=0; i < listQuestions.length; i++)
        {
          if (i == 0)
            {
              listQuestions[i].isOpen = true;
            }

          listQuestions[i].animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300), upperBound: 0.5,);
        }

    }
    else
    {
      setState(() {
        isLoading = false;
      });
      showSnackBar(dataResponse.message, context);
    }
    lectureDetails();
  }*/

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
      'class_id': sessionManager.getClassId() ?? '',
      'from_app': FROM_APP,
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> apiResponse = jsonDecode(body);
    var dataResponse = lecture.LectureDetailsResponseModel.fromJson(apiResponse);
    if (statusCode == 200 && dataResponse.success == "1")
    {
      setState(() {
        lectureGetSet = dataResponse.details ?? lecture.Details();
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

  saveFeedbackForm(List<Questions> list) async {
    setState(() {
      isSaving = true;
    });

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(saveFeedbackUrl);

    Map<String, String> jsonBody = {
      'form_id': formId,
      'answers': getAnswers(list),
      'class_id': classId,
      'student_id': sessionManager.getUserId() ?? '',
      'from_app' : FROM_APP
    };

    final response = await http.post(url,body: jsonBody);

    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = CommonResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == "1")
    {
      print(indexToPass);
      print(listPendingFeedbacks.length);
      if (indexToPass != (listPendingFeedbacks.length - 1))
        {
          pageController.jumpToPage(int.parse(currentIndex));
        }
      else
        {
          Navigator.pop(context);
        }
      showSnackBar(dataResponse.message, context);
      setState(() {
        isSaving = false;
      });
    }
    else
    {
      setState(() {
        isSaving = false;
      });
      showSnackBar(dataResponse.message, context);
    }
  }

  @override
  void castStatefulWidget() {
    widget is FeedbackFormScreenNew;
  }

  bool checkValidation(List<Questions> listQuestions) {
    bool isValid = false;

    Map<String,String> mapAnswer = {};

    for (var i=0; i < listQuestions.length; i++)
      {
        if (listQuestions[i].inputName == "checkbox")
          {
            if (listQuestions[i].options?.isNotEmpty ?? false)
              {
                var isSelected = false;
                for (var j=0; j < listQuestions[i].options!.length; j++)
                  {
                    if (listQuestions[i].options?[j].isSelected ?? false)
                      {
                        isSelected = listQuestions[i].options?[j].isSelected ?? false;
                        break;
                      }
                  }

                if (!isSelected)
                {
                  isValid = false;
                  showToast("Please answer all the questions", context);
                  break;
                }
                isValid = true;
              }
          }
        else if (listQuestions[i].inputName == "radio")
          {
            if (listQuestions[i].options?.isNotEmpty ?? false)
              {
                var isSelected = false;
                for (var j=0; j < listQuestions[i].options!.length; j++)
                  {
                    if (listQuestions[i].options?[j].isSelected ?? false)
                      {
                        isSelected = listQuestions[i].options?[j].isSelected ?? false;
                        break;
                      }
                  }

                if (!isSelected)
                  {
                    isValid = false;
                    showToast("Please answer all the questions", context);
                    break;
                  }
                isValid = true;
              }
          }
        else if (listQuestions[i].inputName == "textarea")
          {
            if (listQuestions[i].controller.value.text.isEmpty)
              {
                isValid = false;
                showToast("Please answer all the questions", context);
                break;
              }
            else
              {
                isValid = true;
              }
          }
        else if (listQuestions[i].inputName == "text")
          {
            if (listQuestions[i].controller.value.text.isEmpty)
              {
                showToast("Please answer all the questions", context);
              }
            else
              {
                isValid = true;
              }
          }
      }

    return isValid;
  }

  String getAnswers(List<Questions> listQuestions) {
    String answers = '';

    Map<String,String> tempMap = {};

    for (var i=0; i < listQuestions.length; i++)
      {
        if (listQuestions[i].inputName == "checkbox")
          {
            if (listQuestions[i].options?.isNotEmpty ?? false)
            {
              var tempStringData = '';
              for (var j=0; j < listQuestions[i].options!.length; j++)
              {

                if (listQuestions[i].options?[j].isSelected ?? false)
                {
                  if (tempStringData.isEmpty)
                    {
                      tempStringData = listQuestions[i].options?[j].options ?? '';
                    }
                  else
                    {
                      tempStringData = "$tempStringData , ${listQuestions[i].options?[j].options ?? ''}";
                    }
                }
              }
              tempMap[listQuestions[i].questionId ?? ''] = tempStringData;

            }
          }

        if (listQuestions[i].inputName == "radio")
          {
            if (listQuestions[i].options?.isNotEmpty ?? false)
            {
              for (var j=0; j < listQuestions[i].options!.length; j++)
              {
                if (listQuestions[i].options?[j].isSelected ?? false)
                {
                  tempMap[listQuestions[i].questionId ?? ''] = listQuestions[i].options?[j].options ?? '';
                }
              }
            }
          }

        if (listQuestions[i].inputName == "textarea")
          {
            if (listQuestions[i].controller.value.text.isNotEmpty)
            {
              tempMap[listQuestions[i].questionId ?? ''] = listQuestions[i].controller.value.text;
            }

          }

        if (listQuestions[i].inputName == "text")
          {
            if (listQuestions[i].controller.value.text.isNotEmpty)
            {
              tempMap[listQuestions[i].questionId ?? ''] = listQuestions[i].controller.value.text;
            }
          }
      }

    print("TEMP MAP ==== $tempMap");

    answers = jsonEncode(tempMap);

    return answers;
  }
}