import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shivalik_institute/common_widget/common_widget.dart';
import 'package:shivalik_institute/constant/colors.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../common_widget/loading.dart';
import '../common_widget/no_data_new.dart';
import '../constant/api_end_point.dart';
import 'app_utils.dart';
import 'base_class.dart';

class PdfViewer extends StatefulWidget {
  final String pdfUrl;
  final String isPrivate;

  const PdfViewer(this.pdfUrl,this.isPrivate,  {Key? key}) : super(key: key);

  @override
  _PdfViewer createState() => _PdfViewer();
}

class _PdfViewer extends BaseState<PdfViewer> {
  String pdfUrl = "";
  String isPrivate = "";
  bool isLoading = false;
  final bool _isNoData = false;
  final PdfViewerController _pdfViewerController = PdfViewerController();

  @override
  void initState() {
    pdfUrl = (widget as PdfViewer).pdfUrl;
    isPrivate = (widget as PdfViewer).isPrivate;

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

  @override
  void castStatefulWidget() {
    widget is PdfViewer;
  }

  @override
  void dispose() async {
    super.dispose();
    await ScreenProtector.preventScreenshotOff();
    await ScreenProtector.protectDataLeakageOff();
  }
}
