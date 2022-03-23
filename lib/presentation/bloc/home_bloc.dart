import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:test_app/common/database/database.dart';
import 'package:test_app/data/models/comment.dart';
import 'package:test_app/data/models/comment_data_table_source.dart';
import 'package:test_app/di/injection.dart';
import 'package:test_app/domain/usecases/get_comments_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  AppDatabase? database;
  HomeBloc() : super(LoadingComments()) {
    on<LoadData>(loadData);
    on<LoadMoreData>(loadMoreData);
  }
  List<Comment> comments = List.empty(growable: true);
  List<DataRow> rowComments = List.empty(growable: true);
  int endPointer = 50;
  bool isLive = false;

  FutureOr<void> loadData(event, emit) async {
    emit(LoadingComments());
    database = await getDatabase();
    var either = await getIt<GetCommentsUsecase>().call('');
    if (either.isRight()) {
      either.fold((l) => null, (r) => comments = r);
      rowComments = CommentDataTableRow(comments, scaffoldKey.currentContext!)
          .dataRowComments;
      //isLiveData is for user to know if it was fetched from network or from local database
      isLive = true;
      emit(
        LoadedNetworkComments(data: rowComments.sublist(0, endPointer)),
      );
      saveData();
    } else {
      comments = await database!.commentDao.findAllPersons();
      rowComments = CommentDataTableRow(comments, scaffoldKey.currentContext!)
          .dataRowComments;
      isLive = false;
      comments.isEmpty
          ? emit(ErrorWhileLoading())
          : emit(
              LoadedDatabaseComments(data: rowComments.sublist(0, endPointer)));
    }
  }

  Future<void> saveData() async {
    for (var i = 0; i < comments.length; i++) {
      await database!.commentDao.insertComment(comments[i]);
    }
  }

  FutureOr<void> loadMoreData(event, emit) async {
    if (endPointer <= 450) {
      endPointer += 50;
      isLive
          ? emit(
              LoadedNetworkComments(data: rowComments.sublist(0, endPointer)),
            )
          : emit(
              LoadedDatabaseComments(data: rowComments.sublist(0, endPointer)),
            );
    }
  }

  Future<AppDatabase> getDatabase() {
    if (database != null) {
      return Future.value(database);
    } else {
      return $FloorAppDatabase.databaseBuilder('testapp.db').build();
    }
  }
}
