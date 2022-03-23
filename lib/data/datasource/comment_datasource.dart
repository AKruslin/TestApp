import 'package:injectable/injectable.dart';
import 'package:test_app/common/services/network_service.dart';
import 'package:test_app/common/services/rest_client.dart';
import 'package:test_app/data/models/comment.dart';

abstract class CommentDatasource {
  Future<List<Comment>> getComments();
}

@LazySingleton(as: CommentDatasource)
class CommentDatasourceImpl implements CommentDatasource {
  NetworkService networkService;
  CommentDatasourceImpl({
    required this.networkService,
  });

  @override
  Future<List<Comment>> getComments()async {
        try {
      RestClient restClient = networkService.getRestClient();
      var response = await restClient.getComments();
      return response;
    } catch (e) {
      throw Exception();
    }
  }
}
