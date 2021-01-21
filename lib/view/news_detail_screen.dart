import 'package:flutter/material.dart';
import 'package:hacker_news/models/news_modal.dart';
import 'package:hacker_news/providers/news_provider.dart';
import 'package:hacker_news/view/comment_widget.dart';
import 'package:hacker_news/widgets/loader.dart';
import 'package:hacker_news/widgets/my_error_widget.dart';
import 'package:provider/provider.dart';

class NewsDetailScreen extends StatefulWidget {
  final int position;
  final String title;
  const NewsDetailScreen({Key key, this.position, this.title})
      : super(key: key);

  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<NewsModal>(
        future: getDetails(context),
        builder: (context, snapshot) {
          final news = snapshot.data;
          return snapshot.connectionState == ConnectionState.waiting
              ? Loader()
              : news == null
                  ? MyErrorWidget(
                      onRetry: () {
                        setState(() {});
                      },
                    )
                  : CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
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
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext ctx, int index) {
                              return CommentWidget(
                                comment: news.comments[index],
                                level: 0,
                              );
                            },
                            childCount: news.comments.length,
                          ),
                        )
                      ],
                    );
        },
      ),
    );
  }

  Future<NewsModal> getDetails(BuildContext context) {
    return Provider.of<NewsProvider>(context, listen: false)
        .fetchNewsDetails(widget.position);
  }
}
