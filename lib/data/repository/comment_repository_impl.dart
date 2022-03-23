import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:test_app/data/datasource/comment_datasource.dart';
import 'package:test_app/data/models/comment.dart';
import 'package:test_app/domain/repository/comment_repository.dart';

@Singleton(as: CommentRepository)
class CommentRepositoryImpl implements CommentRepository {
  CommentDatasource commentDatasource;
  CommentRepositoryImpl({
    required this.commentDatasource,
  });

  @override
  Future<Either<Exception, List<Comment>>> getComments() async {
    try {
      return Right(await commentDatasource.getComments());
    } catch (e) {
      return Left(Exception());
    }
  }
}
