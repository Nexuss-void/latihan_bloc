part of 'get_table_resto_bloc.dart';

@immutable
sealed class GetTableRestoState {}

final class GetTableRestoInitial extends GetTableRestoState {}

final class GetTableRestoLoading extends GetTableRestoState {}

final class GetTableRestoLoaded extends GetTableRestoState {
  final List<TableRestoModel> listTableResto;

  GetTableRestoLoaded({required this.listTableResto});
}

final class GetTableRestoError extends GetTableRestoState {
  final String message;

  GetTableRestoError({required this.message});
}
