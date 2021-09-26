part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class LoadingComments extends HomeState {}

class LoadedComments extends HomeState {
  final List<Comment> data;
  final bool isLiveData;
  LoadedComments({
    required this.data,
    required this.isLiveData,
  });
}

class ErrorWhileLoading extends HomeState {}
