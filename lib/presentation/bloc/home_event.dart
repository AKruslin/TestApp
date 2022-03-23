part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class LoadData extends HomeEvent {
  final BuildContext context;
  LoadData({
    required this.context,
  });
}

class LoadMoreData extends HomeEvent {}
