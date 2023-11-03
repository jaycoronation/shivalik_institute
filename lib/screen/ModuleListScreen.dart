import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../common_widget/common_widget.dart';
import '../constant/colors.dart';
import '../utils/base_class.dart';

class ModuleListScreen extends StatefulWidget {

  @override
  BaseState<ModuleListScreen> createState() => _ModuleListScreenState();
}

class _ModuleListScreenState extends BaseState<ModuleListScreen> {
  @override
  Widget build(BuildContext context) {
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
           title: Text("Modules",
             textAlign: TextAlign.start,
             style: getTitleTextStyle(),
           ),

         ),
         body: const SingleChildScrollView(
           child: Padding(
             padding: EdgeInsets.only(left: 18.0, right: 18),
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
    widget is ModuleListScreen;
  }

}