import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
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
  State<WebViewContainer> createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  bool isLoading = false;
  late WebViewController controller;
  String isPrivate = '';

  @override
  void initState(){
    super.initState();

    isPrivate = widget.isPrivate;

    print("isPrivate === $isPrivate");
    print("URL === ${widget.url}");

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
          onPageFinished: (url) {
            print("url ==== $url");
          },
          onHttpAuthRequest: (request) {
            print("request ==== ${request.host}");
          },
          onWebResourceError: (WebResourceError error) {
            print("description ==== ${error.description}");
            print("errorCode ==== ${error.errorCode}");
            print("url ==== ${error.url}");

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
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: white,
        actions: [
          Visibility(
            visible: !widget.url.contains("https://www.shivalik.institute/privacy_policy/"),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if(MediaQuery.of(context).orientation == Orientation.portrait)
                {
                  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
                }
                else
                {
                  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
                }
              },
              child: Image.asset('assets/images/ic_rotate.png',width: 24,height: 24),
            ),
          ),
          Gap(12)
        ],
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

  /// blocks rotation; sets orientation to: portrait
  void _portraitModeOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() async {
    super.dispose();
    _portraitModeOnly();
    await ScreenProtector.preventScreenshotOff();
    await ScreenProtector.protectDataLeakageOff();
  }

}