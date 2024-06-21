import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:spacity_wheels_viewer/spacity_wheels_viewer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spacity Wheels',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final StreamController<List<ReelModel>> reelsStream =
      StreamController<List<ReelModel>>();
  List<ReelModel> reelsList = [
    ReelModel(
        'https://assets.mixkit.co/videos/preview/mixkit-tree-with-yellow-flowers-1173-large.mp4',
        'Darshan Patil',
        true,
        true,
        true,
        id: 'd23d',
        likeCount: 2000,
        musicName: 'In the name of Love',
        reelDescription: "Life is better when you're laughing.",
        profileUrl:
            'https://opt.toiimg.com/recuperator/img/toi/m-69257289/69257289.jpg',
        commentList: [
          ReelCommentModel(
            comment: 'Nice...',
            userProfilePic:
                'https://opt.toiimg.com/recuperator/img/toi/m-69257289/69257289.jpg',
            userName: 'Darshan',
            commentTime: DateTime.now(),
          ),
          ReelCommentModel(
            comment: 'Superr...',
            userProfilePic:
                'https://opt.toiimg.com/recuperator/img/toi/m-69257289/69257289.jpg',
            userName: 'Darshan',
            commentTime: DateTime.now(),
          ),
          ReelCommentModel(
            comment: 'Great...',
            userProfilePic:
                'https://opt.toiimg.com/recuperator/img/toi/m-69257289/69257289.jpg',
            userName: 'Darshan',
            commentTime: DateTime.now(),
          ),
        ]),
    ReelModel(
      'https://assets.mixkit.co/videos/preview/mixkit-father-and-his-little-daughter-eating-marshmallows-in-nature-39765-large.mp4',
      'Rahul',
      true,
      true,
      true,
      id: 'idjwoe',
      showFollowButton: false,
      musicName: 'In the name of Love',
      reelDescription: "Life is better when you're laughing.",
      profileUrl:
          'https://opt.toiimg.com/recuperator/img/toi/m-69257289/69257289.jpg',
    ),
    ReelModel(
      'https://assets.mixkit.co/videos/preview/mixkit-mother-with-her-little-daughter-eating-a-marshmallow-in-nature-39764-large.mp4',
      'Rahul',
      true,
      true,
      true,
      id: 'doijqdiw',
      showFollowButton: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ReelsViewer(
      reelsList: reelsList,
      reelsStream: reelsStream.stream,
      userName: "blabla",
      profilePicUrl: "lelington",
      appbarTitle: 'Spacity Wheels',
      onShare: (url) {
        log('Shared reel url ==> $url');
      },
      onLike: (liked, url) {
        log('Liked reel url ==> $url');
      },
      onFollow: (followed, url) {
        log('======> Clicked on follow <======');
      },
      onComment: (comment, id) {
        log('Comment on reel ==> $comment $id');
      },
      onClickMoreBtn: (id) {
        log('======> Clicked on more option on $id <======');
      },
      onClickBackArrow: () {
        log('======> Clicked on back arrow <======');
      },
      onIndexChanged: (index){
        log('======> Current Index ======> $index <========');
        if(index==reelsList.length-1){
          reelsStream.add([
            ReelModel(
              'https://assets.mixkit.co/videos/preview/mixkit-father-and-his-little-daughter-eating-marshmallows-in-nature-39765-large.mp4',
              'Rahul',
              true,
              true,
              true,
              id: 'idjwoe',
              showFollowButton: false,
              musicName: 'In the name of Love',
              reelDescription: "Life is better when you're laughing.",
              profileUrl:
              'https://opt.toiimg.com/recuperator/img/toi/m-69257289/69257289.jpg',
            ),
            ReelModel(
              'https://assets.mixkit.co/videos/preview/mixkit-father-and-his-little-daughter-eating-marshmallows-in-nature-39765-large.mp4',
              'Rahulbibi',
              true,
              true,
              true,
              id: 'idjwoe',
              showFollowButton: false,
              musicName: 'In the name of Love',
              reelDescription: "Life is better when you're laughing.",
              profileUrl:
              'https://opt.toiimg.com/recuperator/img/toi/m-69257289/69257289.jpg',
            ),
          ]);
        }
      },
      showProgressIndicator: true,
      showVerifiedTick: true,
      showAppbar: true,
    );
  }
}
