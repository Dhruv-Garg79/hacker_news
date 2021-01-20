import 'package:flutter/material.dart';
import 'package:hacker_news/app_theme.dart';

class MyErrorWidget extends StatelessWidget {
  final Function onRetry;

  const MyErrorWidget({Key key, this.onRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Something went wrong",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          RaisedButton(
            onPressed: onRetry,
            child: Text("Retry"),
            color: AppTheme.primaryColor,
          ),
        ],
      ),
    );
  }
}
