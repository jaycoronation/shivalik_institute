
import 'package:flutter/material.dart';
import '../constant/colors.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart' as tab;


Widget getBackArrow(){
  return Container(
    alignment: Alignment.centerLeft,
    margin: const EdgeInsets.only(left: 0,right:0,top: 4,bottom: 4),
    child: Padding(
      padding: const EdgeInsets.only(left: 18.0),
      child: Image.asset('assets/images/ic_back_button.png', width: 22, height: 22,color: black,),
    ),
  );
}



Widget getTitle(String title){
  return Text(
    title,
    textAlign: TextAlign.start,
    style: const TextStyle(fontWeight: FontWeight.w700, color: black, fontSize: 18),
  );
}


Widget getCommonButton(String title, void Function() onPressed, bool isLoading ){
  return TextButton(
    onPressed: onPressed,
    style: ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      backgroundColor: MaterialStateProperty.all<Color>(black),
    ),
    child: isLoading
        ? const Padding(
          padding: EdgeInsets.only(top: 10,bottom: 10),
          child: SizedBox(width: 20,height: 20,child: CircularProgressIndicator(color: white,strokeWidth: 2)),
        )
        : Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white, ),
          ),
    ),
  );
}

double kEditTextCornerRadius = 6.0;
double kBorderRadius = 5.0;
double kButtonCornerRadius = 8.0;
double kButtonHeight = 42;
double kDropDownHeight = 32;
double contentSize = 14.0;
double titleSize = 18.0;
double textFiledSize = 16.0;


getTitleTextStyle(){
  return TextStyle(fontWeight: FontWeight.w700, color: black, fontSize: titleSize);
}

getTextFiledStyle(){
  return TextStyle(fontWeight: FontWeight.w500, color: black, fontSize: textFiledSize);
}

startActivityAnimation(BuildContext context, Widget screen){
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, a1, a2) {
        return screen;
      },
      transitionsBuilder: (context, a1, a2, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: a1.drive(tween),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 500),
    ),
  );
}

startActivity(BuildContext context, Widget screen){
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}

closeAndStartActivity(BuildContext context, Widget screen){
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => screen), (Route<dynamic> route) => false);
}