import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_filereader/flutter_filereader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:shivalik_institute/common_widget/loading.dart';
import 'package:shivalik_institute/common_widget/no_data_new.dart';
import 'package:shivalik_institute/utils/app_utils.dart';

import '../common_widget/common_widget.dart';
import '../constant/colors.dart';

class FileReaderPage extends StatefulWidget {
  final String filePath;
  final String isPrivate;

  const FileReaderPage({super.key, required this.filePath, required this.isPrivate});

  @override
  _FileReaderPageState createState() => _FileReaderPageState();
}

class _FileReaderPageState extends State<FileReaderPage> {

  bool isLoading = false;
  String isPrivate = '';
  String fileLocalPath = '';
  late final String path;

  @override
  void initState(){
    super.initState();
    isPrivate = widget.isPrivate;
    setState(() {
      isLoading = true;
    });

    initPlatformState();
  }

  Future<void> initPlatformState() async {
    _setPath();
    if (!mounted) return;
  }

  void _setPath() async {
    path = (await getApplicationSupportDirectory()).path;
    if (Platform.isIOS)
    {
      downloadFile(widget.filePath);
    }
    else
    {
      FileDownloader.downloadFile(
          url: widget.filePath,
          name: "THE FILE NAME AFTER DOWNLOADING",//(optional)
          onProgress: (fileName, progress) {
            print('FILE DOWNLOAD PROGRESS TO PATH: $progress');
          },
          onDownloadCompleted: (String path) {
            setState(() {
              isLoading = true;
              fileLocalPath = path;
            });
            print('FILE DOWNLOADED TO PATH: $path');
          },
          onDownloadError: (String error) {
            print('DOWNLOAD ERROR: $error');
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: isLoading
          ? const LoadingWidget()
          : FileReaderView(
            loadingWidget: const LoadingWidget(),
            unSupportFileWidget: const MyNoDataNewWidget(msg: "Not Supported", img: ''),
            filePath: fileLocalPath,
          ),
    );
  }

  Future<void> secureScreen() async {
    await ScreenProtector.preventScreenshotOn();
    await ScreenProtector.protectDataLeakageWithBlur();
  }


  Future<File> downloadFile(String url) async {
    var file = await DefaultCacheManager().getSingleFile(url);

    setState(() {
      isLoading = false;
      fileLocalPath = file.path;
    });

    return file;
  }

  @override
  void dispose() async {
    super.dispose();
    await ScreenProtector.preventScreenshotOff();
    await ScreenProtector.protectDataLeakageOff();
  }


}