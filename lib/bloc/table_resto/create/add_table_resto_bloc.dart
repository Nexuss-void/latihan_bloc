import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:latihan_bloc_ti4malama/param/tabel_resto_param.dart';
import 'package:latihan_bloc_ti4malama/repo/table_resto_repository.dart';
import 'package:latihan_bloc_ti4malama/response/tabel_resto_create_respon.dart';
import 'package:meta/meta.dart';

part 'add_table_resto_event.dart';

part 'add_table_resto_state.dart';

class AddTableRestoBloc extends Bloc<AddTableRestoEvent, AddTableRestoState> {
  final tableRestoRepository = TableRestoRepository();

  AddTableRestoBloc() : super(AddTableRestoInitial()) {
    on<AddTableRestoPressed>(_onAddTableRestoPressed);
    // TODO: implement event handler
    on<UpdateTableRestoPressed>(_onUpdateTableRestoPressed);
  }

  FutureOr<void> _onAddTableRestoPressed(
      AddTableRestoPressed event, Emitter<AddTableRestoState> emit) async {
    final params = TableRestoParam(
        code: event.tableRestoParam.code,
        name: event.tableRestoParam.name,
        capacity: event.tableRestoParam.capacity);

    try {
      emit(AddTableRestoLoading());
      TabelRestoCreateResponse response =
          await tableRestoRepository.addTableResto(params);
      emit(AddTableRestoSuccess(tabelRestoCreateResponse: response));
    } catch (e) {
      emit(AddTableRestoError(message: e.toString()));
    }
  }

  Future<void> _onUpdateTableRestoPressed(
      UpdateTableRestoPressed event, Emitter<AddTableRestoState> emit) async {
    final params = TableRestoParam(
        id: event.tableRestoParam.id,
        code: event.tableRestoParam.code,
        name: event.tableRestoParam.name,
        capacity: event.tableRestoParam.capacity,
        table_status: event.tableRestoParam.table_status,
        status: event.tableRestoParam.status);

    emit(AddTableRestoLoading());
    try {
      TabelRestoCreateResponse response =
          await tableRestoRepository.updateTableResto(params);
      emit(AddTableRestoSuccess(tabelRestoCreateResponse: response));
    } catch (e) {
      emit(AddTableRestoError(message: e.toString()));
    }
  }
}
