import 'package:flutter/material.dart';
import 'package:spacity_wheels_viewer/spacity_wheels_viewer.dart';
import 'package:spacity_wheels_viewer/src/components/user_profile_image.dart';
import 'package:spacity_wheels_viewer/src/utils/convert_numbers_to_short.dart';

import 'comment_bottomsheet.dart';

class ScreenOptions extends StatefulWidget {
  final ReelModel item;
  final bool showVerifiedTick;
  final Function(String)? onShare;
  final Function(bool, String)? onLike;
  final Function(String, String)? onComment;
  final Function()? onClickMoreBtn;
  final Function(bool, String)? onFollow;

  const ScreenOptions({
    Key? key,
    required this.item,
    this.showVerifiedTick = true,
    this.onClickMoreBtn,
    this.onComment,
    this.onFollow,
    this.onLike,
    this.onShare,
  }) : super(key: key);

  @override
  _ScreenOptionsState createState() => _ScreenOptionsState();
}

class _ScreenOptionsState extends State<ScreenOptions> {

  @override
  void initState() {
    super.initState();
  }

  void toggleLike() {
    setState(() {
      widget.item.isLiked = !widget.item.isLiked;
      if (widget.onLike != null) {
        widget.onLike!(widget.item.isLiked, widget.item.id!);
      }
    });
  }

  void toggleFollow() {
    setState(() {
      widget.item.isFollowed = !widget.item.isFollowed;
      if (widget.onFollow != null) {
        widget.onFollow!(widget.item.isFollowed, widget.item.id!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {// Assuming ReelModel has isFollowed field

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 110),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (widget.item.profileUrl != null)
                          UserProfileImage(profileUrl: widget.item.profileUrl??''),
                        if (widget.item.profileUrl == null)
                          const CircleAvatar(
                            child: Icon(Icons.person, size: 18),
                            radius: 16,
                          ),
                        const SizedBox(width: 6),
                        Text(widget.item.userName,
                            style: const TextStyle(color: Colors.white)),
                        const SizedBox(width: 10),
                        if (widget.showVerifiedTick)
                          const Icon(
                            Icons.verified,
                            size: 15,
                            color: Colors.white,
                          ),
                        if (widget.showVerifiedTick) const SizedBox(width: 6),
                        if (widget.onFollow != null)
                          TextButton(
                            onPressed: toggleFollow,
                            child: Text(
                              widget.item.showFollowButton!=null&&widget.item.showFollowButton!?(widget.item.isFollowed ? 'Unfollow' : 'Follow'):'',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: 6),
                    if (widget.item.reelDescription != null)
                      Text(widget.item.reelDescription ?? '',
                          style: const TextStyle(color: Colors.white)),
                    const SizedBox(height: 10),
                    if (widget.item.musicName != null)
                      Row(
                        children: [
                          const Icon(
                            Icons.music_note,
                            size: 15,
                            color: Colors.white,
                          ),
                          Text(
                            'Original Audio - ${widget.item.musicName}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              Column(
                children: [
                  IconButton(
                    icon: Icon(
                      widget.item.isLiked ? Icons.favorite : Icons.favorite_outline,
                      color: widget.item.isLiked ? Colors.red : Colors.white,
                    ),
                    onPressed: toggleLike,
                  ),
                  Text(NumbersToShort.convertNumToShort(widget.item.likeCount),
                      style: const TextStyle(color: Colors.white)),
                  const SizedBox(height: 20),
                  IconButton(
                    icon: const Icon(Icons.comment_rounded, color: Colors.white),
                    onPressed: () {
                      if (widget.onComment != null) {
                        showModalBottomSheet(
                          barrierColor: Colors.transparent,
                          context: context,
                          builder: (ctx) => CommentBottomSheet(commentList: widget.item.commentList ?? [], onComment: widget.onComment, item: widget.item,)
                        );
                      }
                    },
                  ),
                  Text(NumbersToShort.convertNumToShort(widget.item.commentList?.length ?? 0), style: const TextStyle(color: Colors.white)),
                  const SizedBox(height: 20),
                  if (widget.onShare != null)
                    InkWell(
                      onTap: () => widget.onShare!(widget.item.url),
                      child: Transform(
                        transform: Matrix4.rotationZ(5.8),
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  if (widget.onClickMoreBtn != null)
                    IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () => widget.onClickMoreBtn!(),
                      color: Colors.white,
                    ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
