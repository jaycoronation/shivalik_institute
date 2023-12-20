 import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../constant/colors.dart';

class MyNoDataNewWidget extends StatelessWidget {
  final String msg;
  final String img;

  const MyNoDataNewWidget({Key? key, required this.msg, required this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 100),
        alignment: Alignment.center,
        decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(22)),
        width: 330,
        height: 220,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: img.isNotEmpty,
                child: Image.asset(img, width: 70,)
            ),
            Container(height: 18),
             Text(
              msg,
              style: const TextStyle(
                  color: black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500
              ),
              textAlign: TextAlign.center,
            ),
            Container(height: 12),
            // const Text(
            //   " Data Will Applied Here Once You Add From List",
            //   style: TextStyle(
            //       color: black,
            //       fontSize: 16,
            //       fontWeight: FontWeight.w400
            //   ),
            //   textAlign: TextAlign.center,
            // )
          ],
        ),
      ),
    );
  }
}
