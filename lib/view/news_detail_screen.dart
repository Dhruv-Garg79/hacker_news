import 'package:flutter/material.dart';
import 'package:hacker_news/models/comment_modal.dart';
import 'package:hacker_news/models/news_modal.dart';
import 'package:hacker_news/providers/news_provider.dart';
import 'package:hacker_news/utils/common_func.dart';
import 'package:hacker_news/widgets/loader.dart';
import 'package:hacker_news/widgets/my_error_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_html/flutter_html.dart';

class NewsDetailScreen extends StatelessWidget {
  final int position;
  final String title;
  const NewsDetailScreen({Key key, this.position, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<NewsModal>(
        future: getDetails(context),
        builder: (context, snapshot) {
          final news = snapshot.data;
          return snapshot.connectionState == ConnectionState.waiting
              ? Loader()
              : news == null
                  ? MyErrorWidget(
                      onRetry: () {},
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Points : ${news.points}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Comments : ${news.numComments}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          buildComments(news.comments, 0),
                        ],
                      ),
                    );
        },
      ),
    );
  }

  Widget buildComments(List<CommentModal> list, int level) {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (context, index) {
        return buildCommentItem(list[index], level);
      },
    );
  }

  Widget buildCommentItem(CommentModal comment, int level) {
    return level == 0
        ? Container(
            color: Colors.grey[900],
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(8),
            child: buildComment(comment, level),
          )
        : Row(
          children: [
            VerticalDivider(
              thickness: 1,
              color: Colors.white,
            ),
            Flexible(
              child: buildComment(comment, level),
            ),
          ],
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
                  '${comment.author ?? ''} • ',
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
        if (comment.children != null && comment.children.isNotEmpty)
          buildComments(comment.children, level + 1),
      ],
    );
  }

  Future<NewsModal> getDetails(BuildContext context) {
    return Provider.of<NewsProvider>(context, listen: false)
        .fetchNewsDetails(position);
  }
}
