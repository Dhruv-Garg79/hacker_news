import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hacker_news/models/news_modal.dart';
import 'package:hacker_news/providers/news_provider.dart';
import 'package:hacker_news/routes/app_router.gr.dart';
import 'package:hacker_news/utils/common_func.dart';
import 'package:hacker_news/widgets/loader.dart';
import 'package:hacker_news/widgets/my_error_widget.dart';
import 'package:provider/provider.dart';

class NewsListScreen extends StatefulWidget {
  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  String query;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextField(
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: Colors.white),
            hintText: "Search...",
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
          ),
          onChanged: (val) {
            query = val;
          },
          onSubmitted: (val) {
            Provider.of<NewsProvider>(context, listen: false).fetchNews(val);
          },
        ),
      ),
      body: Consumer<NewsProvider>(
        builder: (context, provider, child) {
          return provider.state == ViewState.Idle
              ? Center(
                  child: Text("Search for your desired topic"),
                )
              : provider.state == ViewState.Loading
                  ? Loader()
                  : provider.state == ViewState.Error
                      ? MyErrorWidget(
                          onRetry: () => provider.fetchNews(query),
                        )
                      : mainContent(provider.news);
        },
      ),
    );
  }

  Widget mainContent(List<NewsModal> list) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, index) {
        return newsItem(list[index], index);
      },
      itemCount: list.length,
    );
  }

  Widget newsItem(NewsModal news, int pos) {
    return news.title != null
        ? InkWell(
            onTap: () {
              ExtendedNavigator.root.push(
                Routes.newsDetailScreen,
                arguments: NewsDetailScreenArguments(
                  position: pos,
                  title: news.title,
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${news.author ?? ''} • ${CommonFunc.formattedDateTime(news.createdAt)}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          )
        : SizedBox();
  }
}
