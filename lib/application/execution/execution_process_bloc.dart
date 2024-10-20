import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shortest_path/domain/core/storage/local_storage.dart';
import 'package:flutter_shortest_path/injection.dart';

part 'execution_process_event.dart';
part 'execution_process_state.dart';

class ExecutionProcessBloc
    extends Bloc<ExecutionProcessEvent, ExecutionProcessState> {
  ExecutionProcessBloc() : super(ExecutionProcessState.initial()) {
    on<UrlChanged>((event, emit) {
      emit(state.copyWith(url: event.url));
    });
    on<SaveUrl>((event, emit) async {
      await getIt<ILocalStorage>().saveBaseUrl(state.url);
    });
    on<ObtainData>((event, emit) {
      //
    });
  }
}
