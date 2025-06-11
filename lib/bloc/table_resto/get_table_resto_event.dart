part of 'get_table_resto_bloc.dart';

@immutable
sealed class GetTableRestoEvent {}

final class TableRestoFetched extends GetTableRestoEvent {}
