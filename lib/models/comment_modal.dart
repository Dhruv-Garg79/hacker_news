import 'dart:convert';

import 'package:flutter/foundation.dart';

class CommentModal {
  final int id;
  final String createdAt;
  final String author;
  final String text;
  final List<CommentModal> children;

  CommentModal({
    this.id,
    this.createdAt,
    this.author,
    this.text,
    this.children,
  });

  CommentModal copyWith({
    int id,
    String createdAt,
    String author,
    String text,
    List<CommentModal> children,
  }) {
    return CommentModal(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      author: author ?? this.author,
      text: text ?? this.text,
      children: children ?? this.children,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdAt': createdAt,
      'author': author,
      'text': text,
      'children': children?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory CommentModal.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return CommentModal(
      id: map['id'],
      createdAt: map['created_at'],
      author: map['author'],
      text: map['text'],
      children: List<CommentModal>.from(map['children']?.map((x) => CommentModal.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModal.fromJson(String source) => CommentModal.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CommentModal(id: $id, createdAt: $createdAt, author: $author, text: $text, children: $children)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is CommentModal &&
      o.id == id &&
      o.createdAt == createdAt &&
      o.author == author &&
      o.text == text &&
      listEquals(o.children, children);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      createdAt.hashCode ^
      author.hashCode ^
      text.hashCode ^
      children.hashCode;
  }
}
