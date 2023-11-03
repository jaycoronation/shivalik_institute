import 'package:flutter/material.dart';
import '../constant/colors.dart';

class LoadingMoreWidget extends StatelessWidget {
  const LoadingMoreWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: 30,
              height: 30,
              child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: black,
                        width: 1,
                      )),
                  child: const Padding(
                    padding: EdgeInsets.all(6.0),
                    child: CircularProgressIndicator(color: black, strokeWidth: 2),
                  ))),
          Text('Loading more...', style: TextStyle(color: black, fontWeight: FontWeight.w400, fontSize: 16))
        ],
      ),
    );
  }
}
