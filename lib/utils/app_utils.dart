import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shivalik_institute/utils/pdf_viewer.dart';
import 'package:shivalik_institute/utils/pptx_viewer.dart';
import 'package:shivalik_institute/utils/session_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common_widget/common_widget.dart';
import '../constant/colors.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart' as tab;

import '../screen/WebViewContainer.dart';


RegExp htmlExp = RegExp(r"<[^>]*>",multiLine: true,caseSensitive: true);

/*show message to user*/
showSnackBar(String? message,BuildContext? context) {
  try {
    return ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(message!),
          duration: const Duration(seconds: 1),
        ),
      );
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

TextStyle getTextStyle({required FontWeight fontWeight, required Color color, required double fontSize}){
  return GoogleFonts.rubik(fontWeight: fontWeight, color: color, fontSize: fontSize);
}

TextStyle getTitleFontStyle(){
  return GoogleFonts.rubik(fontWeight: FontWeight.w600, color: black, fontSize: 18);
}

TextStyle getSecondaryTitleFontStyle(){
  return GoogleFonts.rubik(fontWeight: FontWeight.w400, color: black, fontSize: 14);
}
/*
void logFirebase(String name,Map<String,String?> params){
  params.addAll({"user_name" : "${SessionManager().getName()} ${SessionManager().getLastName()}",'user_id' : SessionManager().getUserId()});
  analytics.logEvent(name: name,parameters: params,).then((value) {
  });
}

 */
void logFirebase(String name, Map<String, Object?> params) {
  final cleanedParams = <String, Object>{};

  // Clean nulls and ensure values are Object (not null)
  params.forEach((key, value) {
    if (value != null) {
      cleanedParams[key] = value;
    }
  });

  cleanedParams.addAll({
    "user_name": "${SessionManager().getName() ?? ''} ${SessionManager().getLastName() ?? ''}",
    "user_id": SessionManager().getUserId() ?? '',
  });

  analytics.logEvent(
    name: name,
    parameters: cleanedParams,
  );
}



Future<String> getLocalDownloadPath(String fileName) async {
  final _directory = await getTemporaryDirectory();
  final downloadPath = "${_directory.path}/${fileName}";
  return downloadPath;

}

String getFileExtension(String fileNameParam) {

  String fileName = fileNameParam;

  try {
    print('.${fileName.split('.').last}');
    return ".${fileName.split('.').last}";
  } catch(e){
    return "";
  }
}

String getFileNameWithExtension(String fileNameParam) {

  String fileName = fileNameParam;

  try {
    return fileName.split('/').last;
  } catch(e){
    return "";
  }
}

String getCurrentYear() {
  String formattedDate = "0";
  var now = DateTime.now();
  var formatter = DateFormat('yyyy');
  formattedDate = formatter.format(now);
  return formattedDate;
  print(formattedDate); // 2016-01-25
}

checkValidString (String? value) {
  if (value == null || value == "null" || value == "<null>" || value == "Null")
  {
    value = "";
  }
  return value.trim();
}

openFileView(BuildContext context,String fileType, String fullPath,String isPrivate,String fileName) async {
  if (fileType == "pdf")
  {
    startActivity(context, PdfViewer(fullPath ?? "",isPrivate ?? "",fileName ?? "",));
  }
  else if ((fileType == "xls") || (fileType == "xlsx"))
  {
    Uri fileUri = Uri.parse(fullPath?? "");

    if (await canLaunchUrl(fileUri))
      {
      launchUrl(fileUri,mode: LaunchMode.externalApplication);
      }
  }
  else if (fileType == "pptx")
    {
      startActivity(context, PPTXViewer(fullPath ?? '',isPrivate ?? '0',fileName));
    }
  else
    {
      startActivity(context, WebViewContainer(fullPath ?? "",'',isPrivate ?? ''));
    }
}

String timeStampToDateTimeForMsg(Timestamp? myTimeStamp)
{
  if(myTimeStamp !=null)
  {
    DateTime myDateTime = myTimeStamp.toDate();
    var dateCon = DateFormat('yyyy-MM-dd HH:mm:ss').format(myDateTime);
    return universalDateConverter("yyyy-MM-dd HH:mm:ss", "hh:mm a", dateCon);
  }
  else
  {
    return "";
  }
}

String getDayFromTimestamp(Timestamp? myTimeStamp)
{
  if(myTimeStamp !=null)
  {
    Timestamp myDateTime = myTimeStamp;
    var dateCon = DateFormat('yyyy-MM-dd HH:mm:ss').format((myDateTime).toDate());

    return convertToDay(dateCon);
  }
  else
  {
    return "";
  }
}

String convertToDay(String dateTime) {
  DateTime input = DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime, false);

  DateTime now = DateTime.now();
  DateTime yesterday = now.subtract(const Duration(days: 1));

  String formattedInput = DateFormat('dd/MM/yyyy').format(input);
  String formattedNow = DateFormat('dd/MM/yyyy').format(now);
  String formattedYesterday = DateFormat('dd/MM/yyyy').format(yesterday);

  if (formattedInput == formattedNow) {
    return 'Today';
  } else if (formattedInput == formattedYesterday) {
    return 'Yesterday';
  } else {
    //return universalDateConverter("yyyy-MM-dd HH:mm:ss", "dd/MM/yyyy", dateTime);
    return universalDateConverter("yyyy-MM-dd HH:mm:ss", "dd,MMM HH:mm:ss", dateTime);
  }
}

showToast(String? message,BuildContext? context){
  Fluttertoast.showToast(
      msg: message.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: gray,
      textColor: Colors.black,
      fontSize: 16.0
  );
}

/*check email validation*/
bool isValidEmail(String? input) {
  try {
    return RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(input!);
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return false;
  }
}

isValidPhoneNumber(String? input)
{
  try {
    return RegExp(r'(0/91)?[7-9][0-9]{9}').hasMatch(input!);
  } catch (e) {
    if(kDebugMode){

      print(e);
    }
    return false;
  }
}

/*convert string to CamelCase*/
// toDisplayCase (String str) {
//   try {
//     return str.toLowerCase().split(' ').map((word) {
//         String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
//         return word[0].toUpperCase() + leftText;
//       }).join(' ');
//   } catch (e) {
//     if (kDebugMode) {
//       print(e);
//     }
//   }
// }

String toDisplayCase(String str) {
  try {

    if (str == null || str.toLowerCase() == "null" || str.isEmpty) {
      return "";
    } else {

      return str.toLowerCase().split(RegExp(r'(\s+|[\.,;])')).map((word) {
        if (word.isEmpty) {
          return word;
        }
        String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
        return word[0].toUpperCase() + leftText;
      }).join(' ');
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return "";
  }
}

String universalDateConverter(String inputDateFormat,String outputDateFormat, String date) {
  var outputDate = "";
  try {
    var inputFormat = DateFormat(inputDateFormat);
    var inputDate = inputFormat.parse(date);

    var outputFormat = DateFormat(outputDateFormat);
    outputDate = outputFormat.format(inputDate);
    //print(outputDate); // 12/31/2000 11:59 PM <-- MM/dd 12H format
  } catch (e) {
  }
  return outputDate;
}

getRandomCartSession() {
  try {
    var r = Random();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(8, (index) => _chars[r.nextInt(_chars.length)]).join();
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}


String getDateFromTimestamp(String timeStamp){
  int timestamp = int.parse(timeStamp); // example timestamp
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000); // convert timestamp to DateTime object

  String formattedDate = DateFormat('dd MMM, yyyy').format(date); // format DateTime object to desired date format

  //print(formattedDate); // output: 2022-03-09
  return formattedDate;
}

convertCommaSeparatedAmount (String value) {
  try {
    var formatter = NumberFormat('#,##,000');
    return formatter.format(value);
  } catch (e) {
    return value;
  }
}


String getPrice(String text) {
  if(text.isNotEmpty)
  {
    try {
      var formatter = NumberFormat('#,##,###');
      return formatter.format(double.parse(text));
    } catch (e) {
      return text;
    }
  }
  else
  {
    return "$text";
  }
}

noInterNet(BuildContext? context) {
  try {
    return ScaffoldMessenger.of(context!).showSnackBar(
      const SnackBar(
        content: Text("Please check your internet connection!"),
        duration: Duration(seconds: 1),
      ),
    );
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

void launchCustomTab(BuildContext context,String url) async {
  try {
    await tab.launchUrl(
      Uri.parse(url),
      customTabsOptions:  tab.CustomTabsOptions(
        animations: tab.CustomTabsSystemAnimations.slideIn(),
      ),
      safariVCOptions: const tab.SafariViewControllerOptions(
        preferredBarTintColor: black,
        preferredControlTintColor: white,
        barCollapsingEnabled: true,
        entersReaderIfAvailable: false,
        dismissButtonStyle: tab.SafariViewControllerDismissButtonStyle.close,
      ),
    );
  } catch (e) {
    // An exception is thrown if browser app is not installed on Android device.
    debugPrint(e.toString());
  }
}

MaterialColor createMaterialColor(Color color) {
  try {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return const MaterialColor(0xFFFFFFFF, <int, Color>{});
  }
}