import 'package:flutter/material.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:open_file/open_file.dart';
import 'base_class.dart';

class CustomCameraScreen extends StatefulWidget {
  const CustomCameraScreen({super.key});

  @override
  BaseState<CustomCameraScreen> createState() => _CustomCameraScreenState();
}

class _CustomCameraScreenState extends BaseState<CustomCameraScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CameraAwesomeBuilder.awesome(
        saveConfig: SaveConfig.photoAndVideo(),
        onMediaTap: (mediaCapture) {
          OpenFile.open(mediaCapture.captureRequest.path);
        },
      ),
    );
  }

  @override
  void castStatefulWidget() {
    widget is CustomCameraScreen;
  }
}