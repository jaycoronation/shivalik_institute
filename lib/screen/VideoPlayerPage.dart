import 'package:auto_orientation/auto_orientation.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shivalik_institute/common_widget/common_widget.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import '../constant/colors.dart';
import '../utils/app_utils.dart';

class VideoPlayerPage extends StatefulWidget {
  final bool play;
  final String url;
  final String title;

  const VideoPlayerPage(this.play,this.url,this.title, {Key? key}) : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoPlayerPage>
{
  VideoPlayerController videoPlayerController = VideoPlayerController.network('') ;
  late Future<void> _initializeVideoPlayerFuture;
  late ChewieController _chewieController;
  @override
  void initState() {
    if(widget.url.startsWith("https"))
    {
      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.url));
    }
    else
    {
      videoPlayerController = VideoPlayerController.file(File(widget.url));
    }

    _initializeVideoPlayerFuture = videoPlayerController.initialize().then((_) {
      setState(() {});
    });

    _chewieController = ChewieController(
        fullScreenByDefault: true,
        videoPlayerController: videoPlayerController,
        autoInitialize: true,
        allowedScreenSleep: false,
        showControls: true,
        allowFullScreen: true,
        looping: false,
        autoPlay: true,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              errorMessage,
              style: const TextStyle(color: Colors.white),
            ),
          );
        }
    );
    _chewieController.enterFullScreen();
    _chewieController.play();
    _chewieController.addListener(() {
      if(!_chewieController.isFullScreen)
      {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
      }
      else
      {
        SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
      }
    });
    super.initState();
  } // This closing tag was missing

  @override
  void dispose() {
    videoPlayerController.dispose();
    _chewieController.dispose();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    AutoOrientation.portraitAutoMode();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child:  Scaffold(
          backgroundColor: white,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
              toolbarHeight: 55,
              automaticallyImplyLeading: false,
              backgroundColor: white,
              elevation: 0,
              centerTitle: false,
              titleSpacing: 0,
              leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: getBackArrow(),
              ),
              title: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.title,
                  maxLines: 1,
                  style: TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 18),
                ),
              )
          ),
          body:FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Chewie(
                  controller: _chewieController,
                );
              }
              else {
                return const Center(
                  child: CircularProgressIndicator(),);
              }
            },
          ),
        ),
        onWillPop: () {
          Navigator.pop(context);
          return Future.value(true);
        });
  }
}