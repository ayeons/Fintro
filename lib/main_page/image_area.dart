import 'dart:html';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'main_page.dart';

class ImageArea extends StatefulWidget {
  final String path;
  final String link;
  final bool isVideo;
  ImageArea(this.path, this.link, this.isVideo) : super(key: ValueKey(path));
  @override
  _ImageAreaState createState() => _ImageAreaState();
}

class _ImageAreaState extends State<ImageArea>
    with SingleTickerProviderStateMixin {
  AnimationController imageController;
  VideoPlayerController _videoController;
  Animation imageAni;
  @override
  void initState() {
    imageController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..addListener(() {
        setState(() {});
      });
    imageAni = CurveTween(curve: widget.isVideo?Curves.easeInOutExpo:Curves.bounceOut).animate(imageController);

    if (widget.isVideo) {
      _videoController = VideoPlayerController.asset(widget.path)
        ..initialize()
        ..addListener(() {
          setState(() {});
        });
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    var gs = GlobalS.of(context);
    if (gs.isReactive) {
      imageController.reset();
      imageController.forward();
    }
    imageController.forward();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    imageController.dispose();
    if (widget.isVideo) {
      _videoController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var gs = GlobalS.of(context);

    var mq = MediaQuery.of(context);

    return Column(
      children: [
        Visibility(
          maintainAnimation: true,
          maintainState: true,
          visible: gs.isStart,
          child: widget.isVideo
              ? Column(
                  children: [
                    Container(
                      width: imageAni.value *
                          mq.size.height /
                          2 *
                          _videoController.value.aspectRatio,
                      height: mq.size.height / 2,
                      child:
                          Stack(alignment: Alignment.bottomCenter, children: [
                        VideoPlayer(_videoController),
                        _ControlsOverlay(_videoController),
                        VideoProgressIndicator(
                          _videoController,
                          allowScrubbing: true,
                          padding: EdgeInsets.all(5),
                        ),
                      ]),
                    ),
                  ],
                )
              : Container(
                  width: imageAni.value * 600,
                  height: imageAni.value * (mq.size.height / 2),
                  child: InkWell(
                    onTap: () {
                      window.location.href = widget.link;
                    },
                    child: Image.asset(
                      widget.path,
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}

class _ControlsOverlay extends StatefulWidget {
  final VideoPlayerController controller;
  const _ControlsOverlay(this.controller);

  @override
  __ControlsOverlayState createState() => __ControlsOverlayState();
}

class __ControlsOverlayState extends State<_ControlsOverlay> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: widget.controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100,
                    ),
                  ),
                ),
        ),
        InkWell(
          onTap: () {
            widget.controller.value.isPlaying
                ? widget.controller.pause()
                : widget.controller.play();
          },
        ),
        !widget.controller.value.isPlaying
            ? Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return PlayerVideoAndPopPage();
                    }));
                  },
                  child: Icon(
                    Icons.laptop_mac_outlined,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              )
            : SizedBox.shrink()
      ],
    );
  }
}

class PlayerVideoAndPopPage extends StatefulWidget {
  @override
  _PlayerVideoAndPopPageState createState() => _PlayerVideoAndPopPageState();
}

class _PlayerVideoAndPopPageState extends State<PlayerVideoAndPopPage> {
  VideoPlayerController _videoPlayerController;
  bool startedPlaying = false;

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.asset('images/foodD.mp4');
    _videoPlayerController.addListener(() {
      if (startedPlaying && !_videoPlayerController.value.isPlaying) {
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future<bool> started() async {
    await _videoPlayerController.initialize();
    await _videoPlayerController.play();
    startedPlaying = true;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      child: Center(
        child: FutureBuilder<bool>(
          future: started(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.data == true) {
              return Stack(alignment: Alignment.bottomCenter, children: [
                AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController),
                ),
                VideoProgressIndicator(
                  _videoPlayerController,
                  allowScrubbing: true,
                  padding: EdgeInsets.all(8),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                        backgroundColor: Colors.orangeAccent,
                        child: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                ),
              ]);
            } else {
              return Stack(children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                        backgroundColor: Colors.orangeAccent,
                        child: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                ),
                Padding(padding: EdgeInsets.all(20),child:Center(child: Text("waiting for video to load",textScaleFactor: 2,)))
              ],);
            }
          },
        ),
      ),
    );
  }
}
