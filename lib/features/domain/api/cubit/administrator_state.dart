part of 'administrator_cubit.dart';

@immutable
sealed class AdministratorState {}

final class AdministratorInitial extends AdministratorState {}

final class AuthorizationLoaded extends AdministratorState {
  final TokenAuthorize data;

  AuthorizationLoaded(this.data);
}

final class AuthorizationError extends AdministratorState {}
