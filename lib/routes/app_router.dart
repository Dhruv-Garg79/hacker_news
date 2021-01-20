import 'package:auto_route/auto_route_annotations.dart';
import 'package:hacker_news/view/news_detail_screen.dart';
import 'package:hacker_news/view/news_list_screen.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: NewsListScreen),
    MaterialRoute(page: NewsDetailScreen),
  ],
)
class $AppRouter {}
