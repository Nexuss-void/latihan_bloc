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

// globalkey
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  String? selectTableStatus;

  String? selectStatus;

  @override
  void initState() {
    if (widget.tableRestoModel != null) {
      // Edit data
      tecCode.text = widget.tableRestoModel!.code!;
      tecName.text = widget.tableRestoModel!.name!;
      tecCapacity.text = widget.tableRestoModel!.capacity!.toString();
      selectTableStatus = widget.tableRestoModel?.table_status!;
      selectStatus = widget.tableRestoModel?.status!;
    } else {
      emptyForm();
    }
    super.initState();
  }

  @override
  void emptyForm() {
    tecCode.clear();
    tecName.clear();
    tecCapacity.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Table Resto"),
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
              if (widget.tableRestoModel != null) ...[
                DropdownButtonFormField<String>(
                  value: selectTableStatus,
                  decoration: InputDecoration(
                    labelText: 'Status Meja',
                    border: OutlineInputBorder(),
                  ),
                  items: ['Terisi', 'Kosong'].map((value) {
                    return DropdownMenuItem(value: value, child: Text(value));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectTableStatus = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectStatus,
                  decoration: InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(),
                  ),
                  items: ['Aktif', 'Tidak Aktif'].map((value) {
                    return DropdownMenuItem(value: value, child: Text(value));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectStatus = value;
                    });
                  },
                ),
              ],
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
                              TableRestoParam params = TableRestoParam(
                                code: tecCode.text,
                                name: tecName.text,
                                capacity: int.parse(tecCapacity.text),
                              );
                              context.read<AddTableRestoBloc>().add(
                                  AddTableRestoPressed(
                                      tableRestoParam: params));
                            } else {
                              TableRestoParam params = TableRestoParam(
                                id: widget.tableRestoModel!.id,
                                code: tecCode.text,
                                name: tecName.text,
                                capacity: int.parse(tecCapacity.text),
                                table_status: selectTableStatus.toString(),
                                status: selectStatus.toString(),
                              );
                              context.read<AddTableRestoBloc>().add(
                                  UpdateTableRestoPressed(
                                      id: widget.tableRestoModel!.id!,
                                      tableRestoParam: params));
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
                        child: Text('Simpan'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
