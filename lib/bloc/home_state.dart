part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {
  List<DataRow> getData() => [];
  bool getDataLocation() => false;

  @override
  List<Object?> get props => [];
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
  @override
  List<Object?> get props => [data, isLiveData];
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

  @override
  List<Object?> get props => [data, isLiveData];
}

class ErrorWhileLoading extends HomeState {}
