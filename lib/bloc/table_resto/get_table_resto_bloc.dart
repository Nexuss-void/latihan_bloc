import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:latihan_bloc_ti4malama/models/table_resto_model.dart';
import 'package:latihan_bloc_ti4malama/repo/table_resto_repository.dart';
import 'package:meta/meta.dart';

part 'get_table_resto_event.dart';

part 'get_table_resto_state.dart';

class GetTableRestoBloc extends Bloc<GetTableRestoEvent, GetTableRestoState> {
  final tableRestoRepository = TableRestoRepository();

  GetTableRestoBloc() : super(GetTableRestoInitial()) {
    on<TableRestoFetched>(_onTableRestoFetched);
    // TODO: implement event handler
  }

  Future<void> _onTableRestoFetched(
    TableRestoFetched event,
    Emitter<GetTableRestoState> exit,
  ) async {
    emit(GetTableRestoLoading());
    try {
      List<TableRestoModel> list = await tableRestoRepository.getTableRestos();
      emit(GetTableRestoLoaded(listTableResto: list));
    } catch (e) {
      emit(GetTableRestoError(message: e.toString()));
    }
  }
}
