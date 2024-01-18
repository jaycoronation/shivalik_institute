import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shivalik_institute/common_widget/loading.dart';
import 'package:shivalik_institute/constant/colors.dart';
import 'package:shivalik_institute/constant/global_context.dart';
import 'package:shivalik_institute/model/CommonResponseModel.dart';
import 'package:shivalik_institute/model/FeedbackFormResponseModel.dart';

import '../common_widget/common_widget.dart';
import '../constant/api_end_point.dart';
import '../utils/app_utils.dart';
import '../utils/base_class.dart';

class FeedbackFormScreen extends StatefulWidget {
  const FeedbackFormScreen({super.key});

  @override
  BaseState<FeedbackFormScreen> createState() => _FeedbackFormScreenState();
}

class _FeedbackFormScreenState extends BaseState<FeedbackFormScreen> {

  bool isLoading = false;
  bool isSaving = false;
  Details getSet = Details();
  List<Questions> listQuestions = [];

  @override
  void initState(){
    super.initState();
    getFeedbackForm();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12)
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: isLoading
            ? const LoadingWidget()
            : Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 12,bottom: 12),
                      child: Text(getSet.formName ?? '',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: black)),
                    ),
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: listQuestions.length,
                      itemBuilder: (context, index) {
                        var getSet = listQuestions[index];
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Gap(12),
                            Text(getSet.title ?? '',style: const TextStyle(color: black,fontWeight: FontWeight.w500,fontSize: 16),),
                            const Gap(12),
                            getSet.inputName == "checkbox"
                                ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: getSet.options?.length ?? 0,
                              itemBuilder: (context, indexInner) {
                                var getSetInner = getSet.options?[indexInner] ?? Options();
                                return GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    setState(() {
                                      getSetInner.isSelected = !getSetInner.isSelected;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          getSetInner.isSelected
                                              ? "assets/images/ic_checked.png"
                                              : "assets/images/ic_un_checked.png",
                                          width: 24,
                                          height: 24,
                                        ),
                                        const Gap(8),
                                        Text(
                                            getSetInner.options ?? '',
                                            style: const TextStyle(fontSize: 14,color: black,fontWeight: FontWeight.w400)
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                                : getSet.inputName == "radio"
                                ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: getSet.options?.length ?? 0,
                              itemBuilder: (context, indexInner) {
                                var getSetInner = getSet.options?[indexInner] ?? Options();
                                return GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    setState(() {
                                      for (var i=0; i < (getSet.options?.length ?? 0); i++)
                                      {
                                        if (indexInner == i)
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
                                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                            style: const TextStyle(fontSize: 14,color: black,fontWeight: FontWeight.w400)
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                                : getSet.inputName == "textarea"
                                ? TextField(
                              cursorColor: black,
                              textCapitalization: TextCapitalization.sentences,
                              controller: getSet.controller,
                              keyboardType: TextInputType.text,
                              maxLines: 5,
                              minLines: 3,
                              style: getTextFiledStyle(),
                              decoration: const InputDecoration(
                                labelText: 'Answer',
                              ),
                            )
                                : getSet.inputName == "text"
                                ? TextField(
                              cursorColor: black,
                              textCapitalization: TextCapitalization.sentences,
                              controller: getSet.controller,
                              keyboardType: TextInputType.text,
                              style: getTextFiledStyle(),
                              decoration: const InputDecoration(
                                labelText: 'Answer',
                              ),
                            )
                                : Container()
                          ],
                        );
                      },
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                      child: getCommonButton("Submit", () {
                        if (checkValidation())
                        {
                          print("[${getAnswers()}]");
                          saveFeedbackForm();
                        }
                      }, isSaving),
                    )
                  ],
                ),
              ),
            ),
      ),
    );
  }

  getFeedbackForm() async {
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
      setState(() {
        isLoading = false;
      });
    }
    else
    {
      setState(() {
        isLoading = false;
      });
      showSnackBar(dataResponse.message, context);
    }
  }

  saveFeedbackForm() async {
    setState(() {
      isSaving = true;
    });

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(saveFeedbackUrl);

    Map<String, String> jsonBody = {
      'form_id': getSet.formId ?? '',
      'answers': "[${getAnswers()}]",
      'class_id': sessionManager.getClassId() ?? '',
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
      sessionManager.setClassId("");
      Navigator.pop(context);
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
    widget is FeedbackFormScreen;
  }

  bool checkValidation() {
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
                  showToast("Please select at least one checkbox", context);
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
                    showToast("Please select at least one radio button", context);
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
                showToast("Please enter all details", context);
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
                showToast("Please enter all details", context);
              }
            else
              {
                isValid = true;
              }
          }
      }

    return isValid;
  }

  String getAnswers() {
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