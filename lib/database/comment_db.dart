// database.dart

import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:test_app/database/dao/comment_dao.dart';
import 'package:test_app/models/comment.dart';

part 'comment_db.g.dart';

@Database(version: 1, entities: [Comment])
abstract class AppDatabase extends FloorDatabase {
  CommentDao get commentDao;
}
