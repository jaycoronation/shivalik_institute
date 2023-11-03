import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../constant/colors.dart';

class MyNoInternetWidget extends StatelessWidget {
  final void Function() onPress;

  const MyNoInternetWidget(this.onPress, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/ic_no_internnet.png',
              width: 32, height: 32,color: black),
          Container(height: 22),
          const Padding(
            padding: EdgeInsets.only(left: 16,right: 16),
            child: Text(
              "No Internet",
              style: TextStyle(
                  color: black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(height: 12),
          const Padding(
            padding: EdgeInsets.only(left: 16,right: 16),
            child: Text(
              'Try to connect with internet and try again later.',
              style: TextStyle(
                  color: black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(height: 22),
          TextButton(
            onPressed: onPress,
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                      side: const BorderSide(width: 1,color: black)
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(black)),
            child: const Padding(
              padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
              child: Text(
                'Try Again',
                style: TextStyle(
                    color: white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          /*Padding(
            padding: const EdgeInsets.only(left: 8,right: 8),
            child: Text(
              'No Internet Connected',
              style: TextStyle(
                  color: black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500
              ),
              textAlign: TextAlign.center,
            ),
          )*/
        ],
      ),
    );
  }

}
