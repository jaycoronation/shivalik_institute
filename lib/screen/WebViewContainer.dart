import 'package:flutter/material.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:shivalik_institute/common_widget/common_widget.dart';
import 'package:shivalik_institute/common_widget/loading.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../constant/colors.dart';

class WebViewContainer extends StatefulWidget {
  final String url;
  final String title;
  final String isPrivate;
  const WebViewContainer(this.url, this.title, this.isPrivate, {super.key});
  @override
  _WebViewContainerState createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  bool isLoading = false;
  late WebViewController controller;
  String isPrivate = '';

  @override
  void initState(){
    super.initState();

    if (isPrivate == "1")
    {
      secureScreen();
    }

    setState(() {
      isLoading  = true;
    });

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress == 100)
            {
              setState(() {
                isLoading = false;
              });
            }
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest navigation) {
            print(navigation.url);
            if (navigation.url.contains("payment=failed"))
            {
              Navigator.pop(context,"failed");
            }
            else if (navigation.url.contains("payment=success"))
            {
              Navigator.pop(context,"success");
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

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
            child: getBackArrow(),
          ),
        ),
        title: getTitle(widget.title),
        elevation: 0,
        centerTitle: true,
        titleSpacing: 0,
        backgroundColor: white,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          Visibility(
              visible: isLoading,
              child: const Center(
                  child: LoadingWidget()
              )
          )
        ],
      ),
    );
  }

  Future<void> secureScreen() async {
    await ScreenProtector.preventScreenshotOn();
    await ScreenProtector.protectDataLeakageWithBlur();
  }

  @override
  void dispose() async {
    super.dispose();
    await ScreenProtector.preventScreenshotOff();
    await ScreenProtector.protectDataLeakageOff();
  }

}