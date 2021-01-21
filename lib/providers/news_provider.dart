import 'package:flutter/widgets.dart';
import 'package:hacker_news/models/comment_modal.dart';
import 'package:hacker_news/models/news_modal.dart';
import 'package:hacker_news/services/api_client.dart';
import 'package:hacker_news/utils/app_logger.dart';
import 'package:hacker_news/utils/global.dart';

enum ViewState { Idle, Loading, Done, Error }

class NewsProvider extends ChangeNotifier {
  List<NewsModal> _news = [];
  ViewState _state = ViewState.Idle;

  List<NewsModal> get news => [..._news];
  ViewState get state => _state;

  Future<void> fetchNews(String query) async {
    _state = ViewState.Loading;
    notifyListeners();

    try {
      final path = "${Global.baseurl}/search";
      final response = await ApiClient.getInstance().get(
        path,
        queryParameters: {
          "query": query,
        },
      );
      
      if (response.statusCode == 200) {
        final List<NewsModal> list = [];
        (response.data['hits'] as List).forEach((element) {
          list.add(NewsModal.fromMap(element));
        });
      
        _news.addAll(list);
        _state = ViewState.Done;
      } else {
        _state = ViewState.Error;
      }
    } on Exception catch (e) {
      AppLogger.print(e.toString());
      _state = ViewState.Error;
    }

    notifyListeners();
  }

  Future<NewsModal> fetchNewsDetails(int pos) async {
    final news = _news[pos];

    if (news.comments != null) return news;

    final path = "${Global.baseurl}/items/${news.objectID}";
    final response = await ApiClient.getInstance().get(path);

    if (response.statusCode == 200) {
      final List<CommentModal> list = [];
      (response.data['children'] as List).forEach((element) {
        list.add(CommentModal.fromMap(element));
      });

      _news[pos].comments = list;
      return _news[pos];
    }

    return null;
  }
}
