import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:hacker_news/models/comment_modal.dart';

class NewsModal {
  final String createdAt;
  final String title;
  final String url;
  final String author;
  final String storyText;
  final int numComments;
  final String objectID;
  final int points;
  List<CommentModal> comments;

  NewsModal({
    this.createdAt,
    this.title,
    this.url,
    this.author,
    this.storyText,
    this.numComments,
    this.objectID,
    this.points,
    this.comments,
  });

  NewsModal copyWith({
    String createdAt,
    String title,
    String url,
    String author,
    String storyText,
    int numComments,
    String objectID,
    String points,
    List<CommentModal> comments,
  }) {
    return NewsModal(
      createdAt: createdAt ?? this.createdAt,
      title: title ?? this.title,
      url: url ?? this.url,
      author: author ?? this.author,
      storyText: storyText ?? this.storyText,
      numComments: numComments ?? this.numComments,
      objectID: objectID ?? this.objectID,
      points: points ?? this.points,
      comments: comments ?? this.comments,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'createdAt': createdAt,
      'title': title,
      'url': url,
      'author': author,
      'storyText': storyText,
      'numComments': numComments,
      'objectID': objectID,
      'points': points,
      'comments': comments?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory NewsModal.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return NewsModal(
      createdAt: map['created_at'],
      title: map['title'],
      url: map['url'],
      author: map['author'],
      storyText: map['story_text'],
      numComments: map['num_comments'],
      objectID: map['objectID'],
      points: map['points'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsModal.fromJson(String source) =>
      NewsModal.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NewsModal(createdAt: $createdAt, title: $title, url: $url, author: $author, storyText: $storyText, numComments: $numComments, objectID: $objectID, points: $points, comments: $comments)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is NewsModal &&
      o.createdAt == createdAt &&
      o.title == title &&
      o.url == url &&
      o.author == author &&
      o.storyText == storyText &&
      o.numComments == numComments &&
      o.objectID == objectID &&
      o.points == points &&
      listEquals(o.comments, comments);
  }

  @override
  int get hashCode {
    return createdAt.hashCode ^
      title.hashCode ^
      url.hashCode ^
      author.hashCode ^
      storyText.hashCode ^
      numComments.hashCode ^
      objectID.hashCode ^
      points.hashCode ^
      comments.hashCode;
  }
}
