import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:test_app/database/database.dart';
import 'package:test_app/models/comment.dart';
import 'package:test_app/services/network_service.dart';
import 'package:test_app/services/rest_client.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  NetworkService _networkService;
  AppDatabase? database;
  HomeBloc(this._networkService) : super(HomeInitial()) {
    on<LoadData>((event, emit) async {
      emit(LoadingComments());
      database = await getDatabase();
      try {
        RestClient restClient = _networkService.getRestClient();
        List<Comment> comments = await restClient.getComments();
        //isLiveData is for user to know if it was fetched from network or from local database
        emit(LoadedComments(data: comments, isLiveData: true));
        for (var i = 0; i < comments.length; i++) {
          database!.commentDao.insertComment(comments[i]);
        }
      } catch (e) {
        List<Comment> commentsFromDB =
            await database!.commentDao.findAllPersons();
        commentsFromDB.isEmpty
            ? emit(ErrorWhileLoading())
            : emit(LoadedComments(data: commentsFromDB, isLiveData: false));
      }
    });
  }

  Future<AppDatabase> getDatabase() {
    if (database != null) {
      return Future.value(database);
    } else {
      return $FloorAppDatabase.databaseBuilder('test4.db').build();
    }
  }
}
