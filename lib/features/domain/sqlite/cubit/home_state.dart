part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeNaN extends HomeState {
  final Object message;

  HomeNaN(this.message);
}

final class HomeLoaded extends HomeState {
  final CollectionLite data;

  HomeLoaded(this.data);
}

final class HomeError extends HomeState {
  final Exception ex;

  HomeError({required this.ex});
}
