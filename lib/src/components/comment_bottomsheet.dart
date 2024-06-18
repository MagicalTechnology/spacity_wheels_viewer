import 'package:flutter/material.dart';
import 'package:spacity_wheels_viewer/spacity_wheels_viewer.dart';
import 'package:spacity_wheels_viewer/src/components/comment_item.dart';

class CommentBottomSheet extends StatefulWidget {
  final List<ReelCommentModel> commentList;
  final Function(String, String)? onComment;
  final ReelModel item;
  final String profilePicUrl;
  final String userName;
  const CommentBottomSheet({Key? key, required this.commentList,this.onComment, required this.item, required this.profilePicUrl, required this.userName})
      : super(key: key);

  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  final commentController = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: Colors.transparent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Text(
              'Comments',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
          const SizedBox(height: 20),
          if (widget.commentList.isNotEmpty)
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 16, right: 16),
                itemCount: widget.commentList.length,
                itemBuilder: (ctx, i) =>
                    CommentItem(commentItem: widget.commentList[i]),
              ),
            ),
          if (widget.commentList.isEmpty)
            const Expanded(
                child: Center(
              child: Text('No Comments yet.'),
            )),
          const Divider(),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: TextField(
              controller: commentController,
              decoration: InputDecoration(
                hintText: 'Add a comment...',
                hintStyle: const TextStyle(color: Colors.grey),
                contentPadding: const EdgeInsets.all(10),
                border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                suffixIcon: InkWell(onTap: () {
                  if(widget.onComment!=null){
                  ReelCommentModel newComment = ReelCommentModel(
                    comment: commentController.text,
                    userProfilePic: widget.profilePicUrl, // Update with actual user profile pic URL
                    userName: widget.userName, // Update with actual user name
                    commentTime: DateTime.now(),
                  );
                  // Add the new comment to the comment list

                    String comment = commentController.text;
                    widget.onComment!(comment, widget.item.id!);
                    setState(() {
                      widget.commentList.add(newComment);
                      commentController.clear(); // Clear the text field after sending the comment
                    });
                  }
                  Navigator.pop(context);
                }, child: const Icon(Icons.send)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
