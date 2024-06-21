import 'package:card_swiper/card_swiper.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:spacity_wheels_viewer/src/models/reel_model.dart';
import 'package:spacity_wheels_viewer/src/utils/url_checker.dart';
import 'package:video_player/video_player.dart';
import 'components/like_icon.dart';
import 'components/screen_options.dart';

class ReelsPage extends StatefulWidget {
  final ReelModel item;
  final bool showVerifiedTick;
  final Function(String)? onShare;
  final Function(bool, String)? onLike;
  final Function(String, String)? onComment;
  final Function(String)? onClickMoreBtn;
  final Function(bool, String)? onFollow;
  final SwiperController swiperController;
  final bool showProgressIndicator;

  final String profilePicUrl;
  final String userName;
  const ReelsPage({
    Key? key,
    required this.item,
    this.showVerifiedTick = true,
    this.onClickMoreBtn,
    this.onComment,
    this.onFollow,
    this.onLike,
    this.onShare,
    this.showProgressIndicator = true,
    required this.swiperController, required this.profilePicUrl, required this.userName,
  }) : super(key: key);

  @override
  State<ReelsPage> createState() => _ReelsPageState();
}

class _ReelsPageState extends State<ReelsPage> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _liked = false;
  @override
  void initState() {
    super.initState();
    if (!UrlChecker.isImageUrl(widget.item.url) &&
        UrlChecker.isValid(widget.item.url)) {
      initializePlayer();
    }
  }

  Future initializePlayer() async {
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.item.url));

    await Future.wait([_videoPlayerController.initialize()]);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      showControls: false,
      looping: false,

    );
    setState(() {});
    _videoPlayerController.addListener(() {
      if (_videoPlayerController.value.position ==
          _videoPlayerController.value.duration) {
        widget.swiperController.next();
      }
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    if (_chewieController != null) {
      _chewieController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getVideoView();
  }

  Widget getVideoView() {
    return Stack(
      fit: StackFit.expand,
      children: [
        _chewieController != null &&
                _chewieController!.videoPlayerController.value.isInitialized
            ? FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: GestureDetector(
                    onLongPressStart: (_) {
                      _videoPlayerController.pause();
                    },
                    onLongPressEnd: (_) {
                      _videoPlayerController.play();
                    },
                    onDoubleTap: () {
                      if (!widget.item.isLiked) {
                        _liked = true;
                        if (widget.onLike != null) {
                          setState(() {

                              if(!widget.item.isLiked) {
                                widget.item.likeCount += 1;


                                widget.item.isLiked = true;
                                widget.onLike!(widget.item.isLiked, widget.item
                                    .id!);
                              }
                          });

                        }
                        setState(() {});
                      }
                    },
                    child: Chewie(
                      controller: _chewieController!,
                    ),
                  ),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 5),
                ],
              ),
        if (_liked)
          const Center(
            child: LikeIcon(),
          ),
        if (widget.showProgressIndicator)
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            height: 13,
            child: VideoProgressIndicator(
              _videoPlayerController,
              allowScrubbing: true,
              colors: const VideoProgressColors(
                backgroundColor: Colors.blueGrey,
                bufferedColor: Colors.blueGrey,
                playedColor: Colors.blueAccent,
              ),
            ),
          ),
        ScreenOptions(
          onClickMoreBtn: widget.onClickMoreBtn,
          onComment: widget.onComment,
          onFollow: widget.onFollow,
          onLike: widget.onLike,
          onShare: widget.onShare,
          showVerifiedTick: widget.showVerifiedTick,
          profilePicUrl: widget.profilePicUrl,
          userName: widget.userName,
          item: widget.item,
        )
      ],
    );
  }
}
