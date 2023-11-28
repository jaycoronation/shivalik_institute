import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shivalik_institute/model/HolidayResponseModel.dart';
import '../common_widget/common_widget.dart';
import '../constant/colors.dart';
import '../model/CommonResponseModel.dart';
import '../utils/app_utils.dart';
import '../utils/base_class.dart';
import '../viewmodels/CommonViewModel.dart';

class AddHolidayScreen extends StatefulWidget {
  final HolidayList getSet;
  const AddHolidayScreen(this.getSet, {super.key});

  @override
  BaseState<AddHolidayScreen> createState() => _AddHolidayScreenState();
}

class _AddHolidayScreenState extends BaseState<AddHolidayScreen> {
  HolidayList getSet = HolidayList();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    getSet = (widget as AddHolidayScreen).getSet;
    if(getSet.id != null)
      {
        if (getSet.id?.isNotEmpty ?? false)
          {
            _titleController.text = getSet.title.toString();
            _descriptionController.text = getSet.description.toString();
            _dateController.text = (universalDateConverter("dd-MM-yyyy", "dd/MM/yyyy", getSet.holidayDate ?? ""));
          }
      }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final commonViewModel = Provider.of<CommonViewModel>(context);


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
            title: getTitle("Add Holiday",),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
              child: Column(
                children: [
                  Container(height: 18,),
                  TextField(
                    cursorColor: black,
                    textCapitalization: TextCapitalization.words,
                    controller: _titleController,
                    keyboardType: TextInputType.text,
                    style: getTextFiledStyle(),
                    decoration: const InputDecoration(
                      labelText: 'Holiday Title. *',
                    ),
                  ),
                  Container(height: 18,),
                  TextField(
                    cursorColor: black,
                    textCapitalization: TextCapitalization.words,
                    controller: _descriptionController,
                    keyboardType: TextInputType.text,
                    style: getTextFiledStyle(),
                    decoration: const InputDecoration(
                      labelText: 'Description',
                    ),
                  ),
                  Container(height: 18,),
                  TextField(
                    cursorColor: black,
                    textCapitalization: TextCapitalization.words,
                    controller: _dateController,
                    keyboardType: TextInputType.number,
                    style: getTextFiledStyle(),
                    decoration: const InputDecoration(
                      labelText: 'Birthdate',
                      hintText: 'DD/MM/YYYY',
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9/]")),
                      LengthLimitingTextInputFormatter(10),
                      _DateFormatter(),
                    ],
                  ),
                  Container(height: 18,),
                  Container(
                    margin: const EdgeInsets.only(top: 30,left: 8, right: 8),
                    width: double.infinity,
                    child: TextButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(kBorderRadius),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(black)
                        ),

                        onPressed: () async {
                          FocusScope.of(context).requestFocus(FocusNode());

                          Map<String, String> jsonBody =
                          {
                            'title':_titleController.value.text,
                            'description':_descriptionController.value.text,
                            'holiday_date':(universalDateConverter("dd/MM/yyyy", "dd-MM-yyyy",  _dateController.value.text )),
                            'id':getSet.id ?? ""
                          };

                          await commonViewModel.saveHolidayAddData(jsonBody);
                          CommonResponseModel value = commonViewModel.response;
                          if (value.success == "1")
                          {
                            // showToast(value.message, context);
                            Navigator.pop(context);
                          }
                          else
                          {
                            showToast(value.message, context);
                          }
                        },
                        child: commonViewModel.isLoading
                            ? const Padding(
                              padding: EdgeInsets.only(top: 10,bottom: 10),
                              child: SizedBox(width: 20,height: 20,child: CircularProgressIndicator(color: white,strokeWidth: 2)),
                            )
                            : const Padding(
                              padding: EdgeInsets.only(top: 10,bottom: 10),
                              child: Text(
                                "Submit",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16, color: white, fontWeight: FontWeight.w400),
                              ),
                            )
                    ),
                  ),
                  Container(height: 18,),
                ],
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

  @override
  void castStatefulWidget() {
    widget is AddHolidayScreen;
  }

}

class _DateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue prevText, TextEditingValue currText) {
    int selectionIndex;

    // Get the previous and current input strings
    String pText = prevText.text;
    String cText = currText.text;
    // Abbreviate lengths
    int cLen = cText.length;
    int pLen = pText.length;

    if (cLen == 1) {
      // Can only be 0, 1, 2 or 3
      if (int.parse(cText) > 3) {
        // Remove char
        cText = '';
      }
    } else if (cLen == 2 && pLen == 1) {
      // Days cannot be greater than 31
      int dd = int.parse(cText.substring(0, 2));
      if (dd == 0 || dd > 31) {
        // Remove char
        cText = cText.substring(0, 1);
      } else {
        // Add a / char
        cText += '/';
      }
    } else if (cLen == 4) {
      // Can only be 0 or 1
      if (int.parse(cText.substring(3, 4)) > 1) {
        // Remove char
        cText = cText.substring(0, 3);
      }
    } else if (cLen == 5 && pLen == 4) {
      // Month cannot be greater than 12
      int mm = int.parse(cText.substring(3, 5));
      if (mm == 0 || mm > 12) {
        // Remove char
        cText = cText.substring(0, 4);
      } else {
        // Add a / char
        cText += '/';
      }
    } else if ((cLen == 3 && pLen == 4) || (cLen == 6 && pLen == 7)) {
      // Remove / char
      cText = cText.substring(0, cText.length - 1);
    } else if (cLen == 3 && pLen == 2) {
      if (int.parse(cText.substring(2, 3)) > 1) {
        // Replace char
        cText = cText.substring(0, 2) + '/';
      } else {
        // Insert / char
        cText =
            cText.substring(0, pLen) + '/' + cText.substring(pLen, pLen + 1);
      }
    } else if (cLen == 6 && pLen == 5) {
      // Can only be 1 or 2 - if so insert a / char
      int y1 = int.parse(cText.substring(5, 6));
      if (y1 < 1 || y1 > 2) {
        // Replace char
        cText = cText.substring(0, 5) + '/';
      } else {
        // Insert / char
        cText = cText.substring(0, 5) + '/' + cText.substring(5, 6);
      }
    } else if (cLen == 7) {
      // Can only be 1 or 2
      int y1 = int.parse(cText.substring(6, 7));
      if (y1 < 1 || y1 > 2) {
        // Remove char
        cText = cText.substring(0, 6);
      }
    } else if (cLen == 8) {
      // Can only be 19 or 20
      int y2 = int.parse(cText.substring(6, 8));
      if (y2 < 19 || y2 > 20) {
        // Remove char
        cText = cText.substring(0, 7);
      }
    }

    selectionIndex = cText.length;
    return TextEditingValue(
      text: cText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}