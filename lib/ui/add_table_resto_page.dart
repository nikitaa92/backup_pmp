import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latihan_bloc_ti4ma/bloc/table_resto/create/add_table_resto_bloc.dart';
import 'package:latihan_bloc_ti4ma/models/table_resto_model.dart';
import 'package:latihan_bloc_ti4ma/param/table_resto_param.dart';

class AddTableRestoPage extends StatefulWidget {
  TableRestoModel? tableRestoModel;
  AddTableRestoPage({super.key, this.tableRestoModel});

  @override
  State<AddTableRestoPage> createState() => _AddTableRestoPageState();
}

class _AddTableRestoPageState extends State<AddTableRestoPage> {
  final _formKey = GlobalKey<FormState>();
  final _tecCode = TextEditingController();
  final _tecName = TextEditingController();
  final _tecCapacity = TextEditingController();

  @override
  void initState() {
    if (widget.tableRestoModel != null) {
      //Edit data
      _tecCode.text = widget.tableRestoModel!.code!;
      _tecName.text = widget.tableRestoModel!.name!;
      _tecCapacity.text = widget.tableRestoModel!.capacity!.toString();
    }
    super.initState();
  }

  @override
  void emptyForm() {
    _tecCode.dispose();
    _tecName.dispose();
    _tecCapacity.dispose();
    super.dispose();
  }

  // void _simpanData() {
  //   if (_formKey.currentState!.validate()) {
  //     TableRestoParam tableRestoParam = TableRestoParam(
  //         code: _tecCode.text,
  //         name: _tecName.text,
  //         capacity: int.parse(_tecCapacity.text));
  //     context
  //         .read<AddTableRestoBloc>()
  //         .add(AddTableRestoPressed(tableRestoParam: tableRestoParam));
  //
  //     // TODO: Integrasi dengan BLoC atau simpan ke database di sini
  //
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Meja "$_tecName" berhasil disimpan')),
  //     );
  //
  //     Navigator.pop(context, true); // Kembali ke halaman sebelumnya
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Table Resto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _tecCode,
                decoration: const InputDecoration(labelText: 'Kode Meja'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Wajib diisi' : null,
              ),
              TextFormField(
                controller: _tecName,
                decoration: const InputDecoration(labelText: 'Nama Meja'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Wajib diisi' : null,
              ),
              TextFormField(
                controller: _tecCapacity,
                decoration: const InputDecoration(labelText: 'Kapasitas Meja'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Wajib diisi';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              BlocListener<AddTableRestoBloc, AddTableRestoState>(
                listener: (context, state) {
                  // TODO: implement listener
                  if (state is AddTableRestoSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.tableRestoCreateResponse.message),
                      ),
                    );
                  } else if (state is AddTableRestoError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  }
                },
                child: BlocBuilder<AddTableRestoBloc, AddTableRestoState>(
                  builder: (context, state) {
                    if (state is AddTableRestoLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          TableRestoParam tableRestoParam = TableRestoParam(
                            code: _tecCode.text,
                            name: _tecName.text,
                            capacity: int.parse(_tecCapacity.text),
                          );
                          context.read<AddTableRestoBloc>().add(
                              AddTableRestoPressed(
                                  tableRestoParam: tableRestoParam));
                        }
                      },
                      child: Text('Simpan'),
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

  // void emptyForm() {
  //   print('mengosongkan data...');
  // }
}
