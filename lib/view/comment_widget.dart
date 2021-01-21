import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hacker_news/models/comment_modal.dart';
import 'package:hacker_news/utils/common_func.dart';

class CommentWidget extends StatefulWidget {
  final CommentModal comment;
  final int level;

  const CommentWidget({Key key, this.comment, this.level}) : super(key: key);

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  bool _show = false;

  @override
  Widget build(BuildContext context) {
    int level = widget.level;
    CommentModal comment = widget.comment;

    return widget.level == 0
        ? Container(
            color: Colors.grey[900],
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(8),
            child: buildComment(comment, level),
          )
        : Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  width: 0.5,
                  color: Colors.white,
                ),
              ),
            ),
            padding: const EdgeInsets.only(left: 8, top: 8),
            margin: const EdgeInsets.only(left: 4),
            child: buildComment(comment, level),
          );
  }

  Widget buildComment(CommentModal comment, int level) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  '${comment.author ?? 'Anonymous'} • ',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  comment.createdAt == null
                      ? ''
                      : CommonFunc.formattedDateTime(comment.createdAt),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Html(
              data: comment.text ?? '',
            ),
          ],
        ),
        if (comment.children != null && comment.children.isNotEmpty && !_show)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                child: Text("Show replies"),
                onPressed: () {
                  setState(() {
                    _show = true;
                  });
                },
              ),
            ],
          ),
        if (comment.children != null && comment.children.isNotEmpty && _show)
          ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: comment.children.length,
            itemBuilder: (context, index) {
              return CommentWidget(
                  comment: comment.children[index], level: level + 1);
            },
          ),
      ],
    );
  }
}
