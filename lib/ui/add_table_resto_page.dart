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

  @override
  void initState() {
    if (widget.tableRestoModel != null) {
      // Edit data
      tecCode.text = widget.tableRestoModel!.code!;
      tecName.text = widget.tableRestoModel!.name!;
      tecCapacity.text = widget.tableRestoModel!.capacity!.toString();
    } else {
      emptyForm();
    }
    super.initState();
  }

  @override
  void emptyForm() {
    tecCode.dispose();
    tecName.dispose();
    tecCapacity.dispose();
    super.dispose();
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
                            TableRestoParam params = TableRestoParam(
                              code: tecCode.text,
                              name: tecName.text,
                              capacity: int.parse(tecCapacity.text),
                            );
                            context.read<AddTableRestoBloc>().add(
                                AddTableRestoPressed(tableRestoParam: params));
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
