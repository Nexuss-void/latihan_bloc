import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latihan_bloc_ti4malama/bloc/table_resto/create/add_table_resto_bloc.dart';
import 'package:latihan_bloc_ti4malama/param/tabel_resto_param.dart';
import 'package:latihan_bloc_ti4malama/models/table_resto_model.dart';

class AddTableRestoPage extends StatefulWidget {
  TableRestoModel? tableRestoModel;

  AddTableRestoPage({this.tableRestoModel, super.key});

  @override
  State<AddTableRestoPage> createState() => _AddTableRestoPageState();
}

class _AddTableRestoPageState extends State<AddTableRestoPage> {
  final TextEditingController tecCode = TextEditingController();

  final TextEditingController tecName = TextEditingController();

  final TextEditingController tecCapacity = TextEditingController();

  var selectedTableStatus = 'Kosong';
  var selectedStatus = 'Aktif';
  var tableStatusList = ['Kosong', 'Terisi'];
  var statusList = ['Aktif', 'Tidak Aktif'];

// globalkey
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  // String? selectTableStatus;
  // String? selectStatus;

  @override
  void initState() {
    if (widget.tableRestoModel != null) {
      // Edit data
      tecCode.text = widget.tableRestoModel!.code!;
      tecName.text = widget.tableRestoModel!.name!;
      tecCapacity.text = widget.tableRestoModel!.capacity!.toString();
      // selectedTableStatus = widget.tableRestoModel!.table_status!;
      // selectedStatus = widget.tableRestoModel!.status!;
    } else {
      emptyForm();
    }
    super.initState();
  }

  @override
  void emptyForm() {
    tecCode.text = '';
    tecName.text = '';
    tecCapacity.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddTableRestoBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.tableRestoModel == null
                ? 'Add Table Resto'
                : 'Update Table Resto',
          ),
          backgroundColor: Colors.orange,
          foregroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: globalKey, // Bungkus dalam Form
            child: Column(
              children: [
                // Input Kode Meja
                TextFormField(
                  controller: tecCode,
                  decoration: InputDecoration(
                    labelText: 'Kode Meja',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kode meja wajib diisi';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Input Nama Meja
                TextFormField(
                  controller: tecName,
                  decoration: InputDecoration(
                    labelText: 'Nama Meja',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama meja wajib diisi';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Input Kapasitas Meja
                TextFormField(
                  controller: tecCapacity,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Kapasitas Meja',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kapasitas wajib diisi';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Harus berupa angka';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                widget.tableRestoModel != null
                    ? DropdownButtonFormField<String>(
                        value: widget.tableRestoModel != null
                            ? widget.tableRestoModel!.table_status
                            : selectedTableStatus,
                        decoration: InputDecoration(
                          labelText: 'Status Meja',
                          border: OutlineInputBorder(),
                        ),
                        items: tableStatusList
                            .map(
                              (element) => DropdownMenuItem<String>(
                                  value: element, child: Text(element)),
                            )
                            .toList(),
                        onChanged: (String? value) {
                          setState(() {
                            selectedTableStatus = value!;
                          });
                        },
                      )
                    : SizedBox(height: 16),
                SizedBox(height: 16),
                widget.tableRestoModel != null
                    ? DropdownButtonFormField<String>(
                        value: widget.tableRestoModel != null
                            ? widget.tableRestoModel!.status
                            : selectedStatus,
                        decoration: InputDecoration(
                          labelText: 'Status',
                          border: OutlineInputBorder(),
                        ),
                        items: statusList
                            .map(
                              (element) => DropdownMenuItem<String>(
                                  value: element, child: Text(element)),
                            )
                            .toList(),
                        onChanged: (String? value) {
                          setState(() {
                            selectedStatus = value!;
                          });
                        },
                      )
                    : SizedBox(height: 16),
                SizedBox(height: 24),
                // Tombol Simpan
                BlocListener<AddTableRestoBloc, AddTableRestoState>(
                  listener: (context, state) {
                    if (state is AddTableRestoSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.tabelRestoCreateResponse.message),
                        ),
                      );
                    } else if (state is AddTableRestoError) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.message)));
                    } else if (state is UpdateTableRestoSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text(state.tabelRestoCreateResponse.message)));
                    }
                  },
                  child: BlocBuilder<AddTableRestoBloc, AddTableRestoState>(
                    builder: (context, state) {
                      if (state is AddTableRestoLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (globalKey.currentState!.validate()) {
                              if (widget.tableRestoModel == null) {
                                var params = TableRestoParam(
                                  code: tecCode.text,
                                  name: tecName.text,
                                  capacity: int.parse(tecCapacity.text),
                                );
                                context.read<AddTableRestoBloc>().add(
                                    AddTableRestoPressed(
                                        tableRestoParam: params));
                              } else {
                                var paramsUpdate = TableRestoParam(
                                  id: widget.tableRestoModel!.id,
                                  code: tecCode.text,
                                  name: tecName.text,
                                  capacity: int.parse(tecCapacity.text),
                                  table_status: selectedTableStatus.toString(),
                                  status: selectedStatus.toString(),
                                );
                                context.read<AddTableRestoBloc>().add(
                                    UpdateTableRestoPressed(
                                        id: widget.tableRestoModel!.id!,
                                        tableRestoParam: paramsUpdate));
                              }

                              print(
                                  "ID yang dikirim: ${widget.tableRestoModel?.id}");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Text(widget.tableRestoModel == null
                              ? 'Simpan'
                              : 'Ubah'),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
