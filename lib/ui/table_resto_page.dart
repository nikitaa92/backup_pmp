import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latihan_bloc_ti4ma/bloc/get_table_resto_bloc.dart';
import 'package:latihan_bloc_ti4ma/bloc/table_resto/create/add_table_resto_bloc.dart';
import 'package:latihan_bloc_ti4ma/models/table_resto_model.dart';
import 'package:latihan_bloc_ti4ma/ui/add_table_resto_page.dart';

class TableRestoPage extends StatelessWidget {
  const TableRestoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text('Table Resto'),
      ),
      body: BlocBuilder<GetTableRestoBloc, GetTableRestoState>(
        builder: (context, state) {
          return switch (state) {
            GetTableRestoInitial() || GetTableRestoLoading() =>
                Center(
                  child: CircularProgressIndicator(),
                ),
          // TODO: Handle this case.
            GetTableRestoLoaded(listTableResto: var data)
            when data.isNotEmpty =>
                ListView.builder(
                    itemCount: state.listTableResto.length,
                    itemBuilder: (_, index) {
                      TableRestoModel tableRestoModel =
                      state.listTableResto[index];
                      return ListTile(
                        onTap: () {
                          debugPrint('Item:${tableRestoModel.name}');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      AddTableRestoPage(
                                          tableRestoModel: tableRestoModel)));
                        },
                        title: Text(tableRestoModel.name.toString()),
                      );
                    }),
          // TODO: Handle this case.
            GetTableRestoError() => Center(child: Text(state.message)),
          // TODO: Handle this case.
            GetTableRestoLoaded() => Center(child: Text('tidak ada data')),
          };
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) =>
                BlocProvider(
                  create: (context) => AddTableRestoBloc(),
                  child: AddTableRestoPage(),
                )),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
