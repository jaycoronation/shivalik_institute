import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../constant/colors.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart' as tab;



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

String getCurrentYear() {
  String formattedDate = "0";
  var now = DateTime.now();
  var formatter = DateFormat('yyyy');
  formattedDate = formatter.format(now);
  return formattedDate;
  print(formattedDate); // 2016-01-25
}



checkValidString (String? value) {
  if (value == null || value == "null" || value == "<null>")
  {
    value = "";
  }
  return value.trim();
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
toDisplayCase (String str) {
  try {
    return str.toLowerCase().split(' ').map((word) {
        String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
        return word[0].toUpperCase() + leftText;
      }).join(' ');
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

String universalDateConverter(String inputDateFormat,String outputDateFormat, String date) {
  var outputDate = "";
  try {
    var inputFormat = DateFormat(inputDateFormat);
    var inputDate = inputFormat.parse(date);

    var outputFormat = DateFormat(outputDateFormat);
    outputDate = outputFormat.format(inputDate);
    print(outputDate); // 12/31/2000 11:59 PM <-- MM/dd 12H format
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

  print(formattedDate); // output: 2022-03-09
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
      return "${formatter.format(double.parse(text))}";
    } catch (e) {
      return "$text";
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
    await tab.launch(
      url,
      customTabsOption:  tab.CustomTabsOption(
        toolbarColor: black,
        animation: tab.CustomTabsSystemAnimation.slideIn(),
        enableDefaultShare: true,
        enableUrlBarHiding: true,
        showPageTitle: true,
        extraCustomTabs: const <String>[
          'org.mozilla.firefox',
          'com.microsoft.emmx',
        ],
      ),
      safariVCOption: const tab.SafariViewControllerOption(
        preferredBarTintColor: black,
        preferredControlTintColor: Colors.white,
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