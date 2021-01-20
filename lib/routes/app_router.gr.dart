// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../view/news_detail_screen.dart';
import '../view/news_list_screen.dart';

class Routes {
  static const String newsListScreen = '/news-list-screen';
  static const String newsDetailScreen = '/news-detail-screen';
  static const all = <String>{
    newsListScreen,
    newsDetailScreen,
  };
}

class AppRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.newsListScreen, page: NewsListScreen),
    RouteDef(Routes.newsDetailScreen, page: NewsDetailScreen),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    NewsListScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => NewsListScreen(),
        settings: data,
      );
    },
    NewsDetailScreen: (data) {
      final args = data.getArgs<NewsDetailScreenArguments>(
        orElse: () => NewsDetailScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => NewsDetailScreen(
          key: args.key,
          position: args.position,
          title: args.title,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// NewsDetailScreen arguments holder class
class NewsDetailScreenArguments {
  final Key key;
  final int position;
  final String title;
  NewsDetailScreenArguments({this.key, this.position, this.title});
}
