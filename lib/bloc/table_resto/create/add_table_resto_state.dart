part of 'add_table_resto_bloc.dart';

@immutable
sealed class AddTableRestoState {}

final class AddTableRestoInitial extends AddTableRestoState {}

final class AddTableRestoLoading extends AddTableRestoState {}

final class AddTableRestoSuccess extends AddTableRestoState {
  final TabelRestoCreateResponse tabelRestoCreateResponse;

  AddTableRestoSuccess({required this.tabelRestoCreateResponse});
}

final class AddTableRestoError extends AddTableRestoState {
  final String message;

  AddTableRestoError({required this.message});
}
