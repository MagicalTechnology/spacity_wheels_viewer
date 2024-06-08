import 'package:spacity_wheels_viewer/spacity_wheels_viewer.dart';

class ReelModel {
  final String? id;
  final String url;
  bool isLiked;
  bool isFollowed;
  final int likeCount;
  final bool? showFollowButton;
  final bool? s;
  final String userName;
  final String? profileUrl;
  final String? reelDescription;
  final String? musicName;
  final List<ReelCommentModel>? commentList;
  ReelModel(this.url,this.userName, this.isLiked,this.isFollowed, this.s,{this.id,this.showFollowButton,this.likeCount=0,this.profileUrl,this.reelDescription,this.musicName,this.commentList});
}