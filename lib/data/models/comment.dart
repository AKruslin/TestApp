import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';
@Entity(tableName: "commentDB")
@JsonSerializable()
class Comment {
  int postId;
  @primaryKey
  int id;
  String name;
  String email;
  String body;
  Comment({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
