import 'package:bloc/bloc.dart';
import 'package:latihan_bloc_ti4ma/param/table_resto_param.dart';
import 'package:latihan_bloc_ti4ma/repo/table_resto_repository.dart';
import 'package:latihan_bloc_ti4ma/response/table_resto_create.dart';
import 'package:latihan_bloc_ti4ma/response/table_resto_create_response.dart';
import 'package:meta/meta.dart';

part 'add_table_resto_event.dart';
part 'add_table_resto_state.dart';

class AddTableRestoBloc extends Bloc<AddTableRestoEvent, AddTableRestoState> {
  final tableRestoRepository = TableRestoRepository();

  AddTableRestoBloc() : super(AddTableRestoInitial()) {
    on<AddTableRestoPressed>(_onAddTableRestoPressed); // ✔️ handler ditambahkan dengan benar
  }

  Future<void> _onAddTableRestoPressed(
      AddTableRestoPressed event,
      Emitter<AddTableRestoState> emit,
      ) async {
    final params = TableRestoParam(
      code: event.tableRestoParam.code,
      name: event.tableRestoParam.name,
      capacity: event.tableRestoParam.capacity,
    );

    try {
      emit(AddTableRestoLoading());
      TableRestoCreateResponse response =
      await tableRestoRepository.addTableResto(params);
      emit(AddTableRestoSuccess(tableRestoCreateResponse: response));
    } catch (e) {
      emit(AddTableRestoError(message: e.toString()));
    }
  }
}
