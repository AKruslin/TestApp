import 'package:floor/floor.dart';
import 'package:test_app/data/models/comment.dart';

@dao
abstract class CommentDao {
  @Query('SELECT * FROM commentDB')
  Future<List<Comment>> findAllPersons();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertComment(Comment comment);
}