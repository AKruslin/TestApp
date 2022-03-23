import 'package:dartz/dartz.dart';
import 'package:test_app/data/models/comment.dart';

abstract class CommentRepository {
  Future<Either<Exception,List<Comment>>> getComments();
}