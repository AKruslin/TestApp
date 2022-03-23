import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:test_app/common/usecase.dart';
import 'package:test_app/data/models/comment.dart';
import 'package:test_app/domain/repository/comment_repository.dart';

@lazySingleton
class GetCommentsUsecase extends UseCase<List<Comment>, String> {
  GetCommentsUsecase(this.repository);
  final CommentRepository repository;

  @override
  Future<Either<Exception, List<Comment>>> call(params) async {
    return await repository.getComments();
  }
}
