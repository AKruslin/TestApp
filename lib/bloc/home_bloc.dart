import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:test_app/database/database.dart';
import 'package:test_app/models/comment.dart';
import 'package:test_app/models/comment_data_table_source.dart';
import 'package:test_app/services/network_service.dart';
import 'package:test_app/services/rest_client.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final NetworkService _networkService;
  AppDatabase? database;
  HomeBloc(this._networkService) : super(LoadingComments()) {
    on<LoadData>(loadData);
    on<LoadMoreData>(loadMoreData);
  }
  List<Comment> comments = List.empty(growable: true);
  List<DataRow> rowComments = List.empty(growable: true);
  int endPointer = 50;
  bool isLive = false;

  FutureOr<void> loadData(event, emit) async {
    database = await getDatabase();
    try {
      RestClient restClient = _networkService.getRestClient();
      comments = await restClient.getComments();
      rowComments =
          CommentDataTableRow(comments, event.context).dataRowComments;
      //isLiveData is for user to know if it was fetched from network or from local database
      isLive = true;
      emit(
        LoadedNetworkComments(
            data: rowComments.sublist(0, endPointer)),
      );
      saveData();
    } catch (e) {
      comments = await database!.commentDao.findAllPersons();
      rowComments =
          CommentDataTableRow(comments, event.context).dataRowComments;
      isLive = false;
      comments.isEmpty
          ? emit(ErrorWhileLoading())
          : emit(LoadedNetworkComments(
              data: rowComments.sublist(0, endPointer)));
    }
  }

  void saveData() {
    for (var i = 0; i < comments.length; i++) {
      database!.commentDao.insertComment(comments[i]);
    }
  }

  FutureOr<void> loadMoreData(event, emit) async {
    if (endPointer <= 450) {
      endPointer += 50;
      emit(
        LoadedNetworkComments(
            data: rowComments.sublist(0, endPointer)),
      );
    }
  }

  Future<AppDatabase> getDatabase() {
    if (database != null) {
      return Future.value(database);
    } else {
      return $FloorAppDatabase.databaseBuilder('test5.db').build();
    }
  }
}
