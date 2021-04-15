import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:topshot_scan/data/data.dart';
import 'package:topshot_scan/theme/color_theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:topshot_scan/theme/nba_theme.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';

class MomentVideo extends StatefulWidget {
  MomentVideo(this.playID, this.path, this.team, {this.hero = ""});

  final String? playID;
  final String? path;
  final String? team;
  final String? hero;

  @override
  _MomentVideoState createState() => _MomentVideoState();
}

class _MomentVideoState extends State<MomentVideo> {
  TargetPlatform? _platform;
  late VideoPlayerController _videoPlayerController1;
  ChewieController? _chewieController;
  bool dismiss = true;

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController1.dispose();
    _chewieController?.dispose();
  }

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController1 = VideoPlayerController.network(
        "${widget.path}${video_endpoint}",
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true));
    await Future.wait([
      _videoPlayerController1.initialize(),
    ]);
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController1,
        autoPlay: true,
        allowMuting: true,
        autoInitialize: true,
        looping: true,
        showControls: false,
        placeholder: SpinKitCircle(
          color: NBAColors[widget.team]!["secondary"]!,
        ));
    Future.delayed(Duration(microseconds: 30), () {
      if (mounted) {
        setState(() {
          dismiss = false;
        });
      }
    });

    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          dismiss = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      color: MainColors.background,
      child: Stack(
        children: [
          Center(
            child: Hero(
                tag: "${widget.playID}${widget.hero}",
                child: CarouselSlider(
                  options: CarouselOptions(
                      height: 1200,
                      initialPage: 1,
                      viewportFraction: 0.95,
                      enlargeCenterPage: true),
                  items: [0, 1, 2, 3, 4, 5].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return i == 0
                            ? _chewieController != null &&
                                    _chewieController!.videoPlayerController
                                        .value.isInitialized
                                ? Chewie(
                                    controller: _chewieController!,
                                  )
                                : ExtendedImage.network(
                                    "${widget.path}${image_endpoint_array[1]}",
                                    cache: false, loadStateChanged:
                                        (ExtendedImageState state) {
                                    switch (state.extendedImageLoadState) {
                                      case LoadState.loading:
                                        return SpinKitCircle(
                                          color: NBAColors[widget.team]![
                                              "secondary"]!,
                                        );
                                        break;

                                      case LoadState.completed:
                                        return null;
                                        break;

                                      case LoadState.failed:
                                        return null;
                                        break;
                                    }
                                  })
                            : ExtendedImage.network(
                                "${widget.path}${image_endpoint_array[i]}",
                                cache: false,
                                loadStateChanged: (ExtendedImageState state) {
                                switch (state.extendedImageLoadState) {
                                  case LoadState.loading:
                                    return SpinKitCircle(
                                      color: i % 2 == 0
                                          ? NBAColors[widget.team]!["primary"]!
                                          : NBAColors[widget.team]![
                                              "secondary"]!,
                                    );
                                    break;

                                  case LoadState.completed:
                                    return null;
                                    break;

                                  case LoadState.failed:
                                    return null;
                                    break;
                                }
                              });
                      },
                    );
                  }).toList(),
                )),
          ),
          AnimatedOpacity(
              opacity: !dismiss ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              child: Container(
                height: 20,
                width: MediaQuery.of(context).size.width,
                child: Center(
                    child: GradientText(
                  text: "Swipe to examine >>",
                  style: TextStyle(fontFamily: "Lexend", fontSize: 18),
                  colors: [NBAColors[widget.team]!["primary"]!, Colors.white],
                )),
              ))
        ],
      ),
    );
  }
}
