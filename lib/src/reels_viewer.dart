import 'dart:async';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:spacity_wheels_viewer/src/models/reel_model.dart';
import 'package:spacity_wheels_viewer/src/reels_page.dart';

class ReelsViewer extends StatefulWidget {
  /// use reel model and provide list of reels, list contains reels object, object contains url and other parameters
  final List<ReelModel> reelsList;

  /// use to show/hide verified tick, by default true
  final bool showVerifiedTick;

  /// function invoke when user click on share btn and return reel url
  final Function(String)? onShare;

  /// function invoke when user click on like btn and return reel url
  final Function(bool, String)? onLike;

  /// function invoke when user click on comment btn and return reel comment
  final Function(String, String)? onComment;


  /// function invoke when reel change and return current index
  final Function(int)? onIndexChanged;

  /// function invoke when user click on more options btn
  final Function()? onClickMoreBtn;

  /// function invoke when user click on follow btn
  final Function(bool, String)? onFollow;

  /// for change appbar title
  final String? appbarTitle;

  /// for show/hide appbar, by default true
  final bool showAppbar;

  /// for show/hide video progress indicator, by default true
  final bool showProgressIndicator;

  /// function invoke when user click on back btn
  final Function()? onClickBackArrow;
  final Stream<List<ReelModel>> reelsStream;
  final String profilePicUrl;
  final String userName;


  const ReelsViewer({
    Key? key,
    required this.reelsList,
    required this.reelsStream,
    this.showVerifiedTick = true,
    this.onClickMoreBtn,
    this.onComment,
    this.onFollow,
    this.onLike,
    this.onShare,
    this.appbarTitle,
    this.showAppbar = true,
    this.onClickBackArrow,
    this.onIndexChanged,
    this.showProgressIndicator =true, required this.profilePicUrl, required this.userName,
  }) : super(key: key);

  @override
  State<ReelsViewer> createState() => _ReelsViewerState();
}

class _ReelsViewerState extends State<ReelsViewer> {
  SwiperController controller = SwiperController();
    StreamSubscription<List<ReelModel>>? _streamSubscription;
  List<ReelModel> reelsList = [];

  @override
  void initState() {
    super.initState();
    this.reelsList=widget.reelsList;
    _streamSubscription = widget.reelsStream.listen((List<ReelModel> reels) {
      setState(() {
          var existingIds = Set<String>.from(this.reelsList.map((reel) => reel.id));
          this.reelsList.addAll(reels.where((reel) => !existingIds.contains(reel.id)).toList());
      });
    });
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: SafeArea(
        child: Stack(
          children: [
            //We need swiper for every content
            Swiper(
              itemBuilder: (BuildContext context, int index) {
                return ReelsPage(
                  item: this.reelsList[index],
                  onClickMoreBtn: widget.onClickMoreBtn,
                  onComment: widget.onComment,
                  onFollow: widget.onFollow,
                  onLike: widget.onLike,
                  onShare: widget.onShare,
                  showVerifiedTick: widget.showVerifiedTick,
                  swiperController: controller,
                  showProgressIndicator: widget.showProgressIndicator,
                  profilePicUrl: widget.profilePicUrl,
                  userName: widget.userName
                );
              },
              controller: controller,
              itemCount: widget.reelsList.length,
              scrollDirection: Axis.vertical,
              onIndexChanged: widget.onIndexChanged,
            ),
            if (widget.showAppbar)
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: widget.onClickBackArrow ??
                            () => { widget.onClickBackArrow!(),Navigator.pop(context)},
                        icon: const Icon(Icons.arrow_back,color: Colors.white,)
                    ),
                    const SizedBox(),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
