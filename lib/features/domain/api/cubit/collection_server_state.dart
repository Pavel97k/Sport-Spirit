part of 'collection_server_cubit.dart';

@immutable
sealed class CollectionServerState {}

class CollectionServerInitial extends CollectionServerState {}

class CollectionServerLoaded extends CollectionServerState {
  final List<CollectionServer> data;

  CollectionServerLoaded(this.data);
}

class CollectionServerError extends CollectionServerState {
  final Object error;

  CollectionServerError(this.error);
}
