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
  // late WebViewController controller;

  @override
 /* void initState() {
    super.initState();
    print("URL IN Init State ==== ${widget.url}");

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    setState((){
      isLoading = true;
    });
  }*/

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
      /*body: Stack(
        children: [
          WebViewWidget(controller: controller),
          Visibility(
              visible: isLoading,
              child: const Center(
                  child: CircularProgressIndicator(color: textGrey,)
              )
          )
        ],
      ),*/
    );
  }
}