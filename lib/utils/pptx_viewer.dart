import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:shivalik_institute/common_widget/common_widget.dart';
import 'package:shivalik_institute/common_widget/loading.dart';
import 'package:shivalik_institute/utils/session_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../constant/colors.dart';
import '../utils/app_utils.dart';

class PPTXViewer extends StatefulWidget {
  final String url;
  final String isPrivate;
  final String fileName;

  const PPTXViewer(this.url, this.isPrivate, this.fileName, {super.key});

  @override
  State<PPTXViewer> createState() => _PPTXViewerState();
}

class _PPTXViewerState extends State<PPTXViewer> {
  bool isLoading = false;
  late WebViewController controller;
  String isPrivate = '';
  String fileName = '';

  @override
  void initState(){
    super.initState();

    isPrivate = widget.isPrivate;
    fileName = widget.fileName;

    print("isPrivate === $isPrivate");
    print("URL === ${widget.url}");

    if (isPrivate == "1")
    {
      secureScreen();
    }

    setState(() {
      isLoading  = true;
    });

    String url = '';

    if (Platform.isIOS)
      {
        url = widget.url;
      }
    else
      {
        url = "https://docs.google.com/gview?embedded=true&url=${widget.url}";
      }

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..enableZoom(true)
      ..clearLocalStorage()
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
          onPageStarted: (url) {
            print("url ==== $url");
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
      ..loadRequest(Uri.parse(url));
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
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: white,
        actions: [
          Visibility(
            visible: !widget.url.contains("https://www.shivalik.institute/privacy_policy/") && (widget.url != 'https://www.shivalik.institute/terms-conditions/'),
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
          const Gap(18),
          Visibility(
            visible: !widget.url.contains("https://www.shivalik.institute/privacy_policy/") && (widget.url != 'https://www.shivalik.institute/terms-conditions/') && (isPrivate == "0"),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                _getDownloadDirectory(context,widget.url);
              },
              child: Image.asset('assets/images/ic_download.png',width: 24,height: 24),
            ),
          ),
          const Gap(12)
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: controller,
            layoutDirection: TextDirection.ltr,
          ),
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

  _getDownloadDirectory(BuildContext context, String fileUrlServer) async {
    String? directory;
    try {
      //

      if (Platform.isIOS)
      {
        var pathMain = await getApplicationDocumentsDirectory();
        directory = pathMain.path;
      }
      else
      {
        directory = await FilePicker.platform.getDirectoryPath();
      }

      _downloadFile(directory ?? '',fileUrlServer);

    } catch (e) {
      print("Error while picking directory: $e");
    }
    if (directory == null) {
      showSnackBar("No directory selected!", context);
      return "";
    }
  }

  Future<void> _downloadFile(String downloadPath, String fileUrlServer) async {
    // Example using `http` package

    SessionManager sessionManager = SessionManager();

    String fileUrl = fileUrlServer;

    print('fileName ==== $fileName');

    if (Platform.isIOS)
    {
      var permissionStatus = await Permission.storage.status;
      if (permissionStatus.isDenied)
      {
        await Permission.storage.request();
      }
    }

    HttpClient().getUrl(Uri.parse(fileUrl))
        .then((HttpClientRequest request) => request.close())
        .then((HttpClientResponse response) async {
      File file = File('$downloadPath/$fileName');

      await response.pipe(file.openWrite(mode: FileMode.write));

      print('File Path ==== ${file.path}');

      if (Platform.isAndroid)
      {
        final result = await OpenFile.open(file.path);
        setState(() {
          var openResult = "type=${result.type}  message=${result.message}";
          print("openResult === $openResult");
        });
        //Navigator.pop(context);
      }
      else
      {
        final result = await OpenFile.open(file.path);
        var openResult = "type=${result.type}  message=${result.message}";
        print("openResult === $openResult");
      }
    });

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