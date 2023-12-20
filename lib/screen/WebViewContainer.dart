import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/colors.dart';

class WebViewContainer extends StatefulWidget {
  final String url;
  final String title;
  const WebViewContainer(this.url, this.title, {super.key});
  @override
  _WebViewContainerState createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  final _key = UniqueKey();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 56,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () async {
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.pop(context);
          },
          child: Container(
            alignment: Alignment.center,
            child: Image.asset('assets/images/ic_Left_Arrow.png',
              height: 20, width: 20,),
          ),
        ),
        title: Text(widget.title,style: GoogleFonts.manrope(fontSize: 18,color: black,fontWeight: FontWeight.w800),),
        elevation: 0,
        centerTitle: true,
        titleSpacing: 0,
        backgroundColor: white,
      ),
    );
  }
}