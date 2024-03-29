import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:shivalik_institute/common_widget/common_widget.dart';
import 'package:shivalik_institute/constant/colors.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common_widget/loading.dart';
import '../common_widget/no_data_new.dart';
import 'app_utils.dart';
import 'base_class.dart';

class PdfViewer extends StatefulWidget {
  final String pdfUrl;
  final String isPrivate;
  final String fileName;

  const PdfViewer(this.pdfUrl,this.isPrivate, this.fileName,  {Key? key}) : super(key: key);

  @override
  _PdfViewer createState() => _PdfViewer();
}

class _PdfViewer extends BaseState<PdfViewer> {
  String pdfUrl = "";
  String isPrivate = "";
  String fileName = "";
  bool isLoading = false;
  final bool _isNoData = false;
    final PdfViewerController _pdfViewerController = PdfViewerController();

  @override
  void initState() {

    pdfUrl = (widget as PdfViewer).pdfUrl;
    isPrivate = (widget as PdfViewer).isPrivate;
    fileName = (widget as PdfViewer).fileName;

    print(pdfUrl);

    if (pdfUrl.isEmpty)
      {
        setState(() {
          isLoading = true;
        });
      }

    if (isPrivate == "1")
      {
        secureScreen();
      }

    super.initState();
  }

  Future<void> secureScreen() async {
    await ScreenProtector.preventScreenshotOn();
    await ScreenProtector.protectDataLeakageWithBlur();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          toolbarHeight: 60,
          automaticallyImplyLeading: false,
          backgroundColor: white,
          elevation: 0,
          centerTitle: false,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: getBackArrow()
          ),
          actions: <Widget>[
            Visibility(
              visible: !_isNoData,
              child: IconButton(
                tooltip: "Previous",
                icon: const Icon(
                  Icons.keyboard_arrow_left,
                  color: Colors.black,
                ),
                onPressed: () {
                  _pdfViewerController.previousPage();
                },
              ),
            ),
            Visibility(
              visible: !_isNoData,
              child: IconButton(
                tooltip: "Next",
                icon: const Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.black,
                ),
                onPressed: () {
                  _pdfViewerController.nextPage();
                },
              ),
            ),
            Visibility(
              visible: !_isNoData,
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
              visible: (!_isNoData) && (isPrivate == "0"),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () async {
                  _getDownloadDirectory(context,pdfUrl);
                },
                child: Image.asset('assets/images/ic_download.png',width: 24,height: 24),
              ),
            ),
            const Gap(12)
          ],
        ),
        body: isLoading
            ? const LoadingWidget()
            : _isNoData
            ? const MyNoDataNewWidget(msg: 'PDF not found please try again later.', img: '',)
            : SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SfPdfViewer.network(
                  pdfUrl,
                  controller: _pdfViewerController,
                  canShowPaginationDialog: true,
                  canShowScrollStatus: true,
                  enableDoubleTapZooming: true,
                  onHyperlinkClicked: (details) {
                    launchCustomTab(context, details.uri.toString());
                  },
                  enableTextSelection: true,
                  enableHyperlinkNavigation: true,
                  interactionMode: PdfInteractionMode.selection,
                  pageLayoutMode: PdfPageLayoutMode.single,
                )
            ),
      )
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
    String fileUrl = fileUrlServer;
    //String fileName = '${sessionManager.getBatchName()}_${DateTime.now().millisecondsSinceEpoch / 1000}.pdf';

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

  void _portraitModeOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void castStatefulWidget() {
    widget is PdfViewer;
  }

  @override
  void dispose() async {
    super.dispose();
    _portraitModeOnly();
    await ScreenProtector.preventScreenshotOff();
    await ScreenProtector.protectDataLeakageOff();
  }
}
