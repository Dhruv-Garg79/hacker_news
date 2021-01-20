import 'package:flutter/material.dart';
import 'package:hacker_news/models/comment_modal.dart';
import 'package:hacker_news/models/news_modal.dart';
import 'package:hacker_news/providers/news_provider.dart';
import 'package:hacker_news/utils/common_func.dart';
import 'package:hacker_news/widgets/comment_widget.dart';
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
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Comments : ${news.numComments}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "Points : ${news.points}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
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
        return CommentWidget(comment: list[index], level: level);
      },
    );
  }

  Future<NewsModal> getDetails(BuildContext context) {
    return Provider.of<NewsProvider>(context, listen: false)
        .fetchNewsDetails(position);
  }
}
