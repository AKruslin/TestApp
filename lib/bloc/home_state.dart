part of 'home_bloc.dart';

@immutable
abstract class HomeState {
  List<DataRow> getData() => [];
  bool getDataLocation() => false;
}

class HomeInitial extends HomeState {}

class LoadingComments extends HomeState {}

class LoadedNetworkComments extends HomeState {
  final List<DataRow> data;
  final bool isLiveData = true;
  LoadedNetworkComments({
    required this.data,
  });

  @override
  List<DataRow> getData() => data;
  @override
  bool getDataLocation() => isLiveData;
}

class LoadedDatabaseComments extends HomeState {
  final List<DataRow> data;
  final bool isLiveData = false;
  LoadedDatabaseComments({
    required this.data,
  });
  @override
  List<DataRow> getData() => data;
  @override
  bool getDataLocation() => isLiveData;
}

class ErrorWhileLoading extends HomeState {}
