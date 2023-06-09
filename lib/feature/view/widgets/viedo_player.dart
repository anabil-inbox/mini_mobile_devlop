import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:inbox_clients/feature/view/widgets/three_size_dot.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:video_player/video_player.dart';

import '../../../util/app_shaerd_data.dart';

class VideoPlayer extends StatefulWidget {
  final String? videoUrl;
  final String? assetsPath;
  const VideoPlayer({Key? key, this.videoUrl, this.assetsPath}) : super(key: key);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  var videoPlayerController;

  var chewieController;

  var playerWidget;

  @override
  void initState() {
    super.initState();
    print("msg_url ${ConstanceNetwork.imageUrl}${widget.videoUrl} ");
    initVideoPlayer();
  }

  initVideoPlayer() async {
    if(widget.assetsPath != null) {
      videoPlayerController = VideoPlayerController.asset("${widget.assetsPath}");
    }else{
      videoPlayerController = VideoPlayerController.network("${ConstanceNetwork.imageUrl}${widget.videoUrl}");
    }
    await videoPlayerController.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: false,
      showOptions: true,
      showControls: true,
      showControlsOnInitialize: true,
      allowPlaybackSpeedChanging: true,
      allowedScreenSleep: true,
      allowMuting: true,
      autoInitialize: true,
      // aspectRatio: (MediaQuery.of(context).size.width /
      //     MediaQuery.of(context).size.width) /*w,h*/
    );
    playerWidget = Chewie(
      controller: chewieController,
    );
    setState(() {});
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    if (!GetUtils.isNull(chewieController)) {
      chewieController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
        color: colorContainerGray,
        height: sizeH320,
        width: sizeW320,
        child: Stack(
          children: [
            PositionedDirectional(
                start: 0,
                end: 0,
                bottom: 0,
                top: 0,
                child: ThreeSizeDot(
                  color_1: colorPrimary,
                  color_2: colorPrimary,
                  color_3: colorPrimary,
                )),
            SizedBox(
              child: playerWidget,
            ),
          ],
        ));
  }
}
