import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hacker_news/app_theme.dart';
import 'package:hacker_news/providers/news_provider.dart';
import 'package:hacker_news/routes/app_router.gr.dart';
import 'package:hacker_news/utils/global.dart';
import 'package:hacker_news/view/news_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => NewsProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Global.appName,
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: AppTheme.primaryColor,
          accentColor: AppTheme.accentColor,
          fontFamily: 'Montserrat',
          canvasColor: Colors.black,
        ),
        builder: ExtendedNavigator.builder<AppRouter>(
          router: AppRouter(),
          initialRoute: Routes.newsListScreen,
        ),
        home: NewsListScreen(),
      ),
    );
  }
}
