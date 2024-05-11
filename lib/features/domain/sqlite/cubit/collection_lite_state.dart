part of 'collection_lite_cubit.dart';

@immutable
sealed class CollectionLiteState {}

final class CollectionLiteInitial extends CollectionLiteState {}

class CollectionLiteListLoaded extends CollectionLiteState {
  final List<CollectionLite> data;
  final int? id;

  CollectionLiteListLoaded(this.data, this.id);
}

class CollectionLiteLoaded extends CollectionLiteState {
  final CollectionLite data;

  CollectionLiteLoaded(this.data);
}

final class CollectionLiteError extends CollectionLiteState {
  final Object ex;

  CollectionLiteError(this.ex);
}
