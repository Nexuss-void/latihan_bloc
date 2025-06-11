import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latihan_bloc_ti4malama/bloc/table_resto/get_table_resto_bloc.dart';

class TableRestoPage extends StatelessWidget {
  const TableRestoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Table Resto'),
      ),
      body: BlocBuilder<GetTableRestoBloc, GetTableRestoState>(
        builder: (context, state) {
          return switch (state) {
            GetTableRestoInitial() || GetTableRestoLoading() => Center(
                child: CircularProgressIndicator(),
              ),
            // TODO: Handle this case.
            GetTableRestoLoaded(listTableResto: var data)
                when data.isNotEmpty =>
              ListView.builder(
                  itemCount: state.listTableResto.length,
                  itemBuilder: (_, index) => ListTile(
                        title:
                            Text(state.listTableResto[index].name.toString()),
                      )),
            // TODO: Handle this case.
            GetTableRestoError() => Center(
                child: Text(state.message),
              ),
            // TODO: Handle this case.
            GetTableRestoLoaded() => Center(
                child: Text('tidak ada data'),
              )
          };
        },
      ),
    );
  }
}
