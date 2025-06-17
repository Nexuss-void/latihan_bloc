part of 'add_table_resto_bloc.dart';

@immutable
sealed class AddTableRestoEvent {}

final class AddTableRestoPressed extends AddTableRestoEvent {
  final TableRestoParam tableRestoParam;

  AddTableRestoPressed({required this.tableRestoParam});
}

final class UpdateTableRestoPressed extends AddTableRestoEvent {
  final TableRestoParam tableRestoParam;

  UpdateTableRestoPressed({required this.tableRestoParam});
}
