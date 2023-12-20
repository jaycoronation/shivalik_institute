import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../constant/colors.dart';
import 'common_widget.dart';

class VideoProjectWidget extends StatefulWidget {

  final bool play;
  final String url;

  const VideoProjectWidget({Key? key, required this.url, required this.play}) : super(key: key);

  @override
  State<VideoProjectWidget> createState() => _VideoProjectWidgetState();
}

class _VideoProjectWidgetState extends State<VideoProjectWidget> {
  late VideoPlayerController videoPlayerController ;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.url));
    _initializeVideoPlayerFuture = videoPlayerController.initialize().then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: appBg,
        leading:  InkWell(
          borderRadius: BorderRadius.circular(52),
          onTap: () {
            Navigator.pop(context);
          },
          child: getBackArrow(),
        ),
        titleSpacing: 0,
        centerTitle: false,
      ),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.zero,
              child: Card(
                margin: EdgeInsets.zero,
                key: PageStorageKey(widget.url),
                elevation: 0.0,
                child: Chewie(
                  key: PageStorageKey(widget.url),
                  controller: ChewieController(
                    showControls: true,
                    videoPlayerController: videoPlayerController,
                    aspectRatio: Platform.isIOS ? 14/22 : 12 / 18,
                    looping: true,
                    autoPlay: true,
                    errorBuilder: (context, errorMessage) {
                      return Center(
                        child: Text(
                          errorMessage,
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          }
          else {
            return const Center(
              child: CircularProgressIndicator(color: black),
            );
          }
        },
      ),
    );
  }
}