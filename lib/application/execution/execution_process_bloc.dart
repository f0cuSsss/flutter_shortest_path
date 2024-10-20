import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'execution_process_event.dart';
part 'execution_process_state.dart';

class ExecutionProcessBloc
    extends Bloc<ExecutionProcessEvent, ExecutionProcessState> {
  ExecutionProcessBloc() : super(ExecutionProcessInitial()) {
    on<UrlChanged>((event, emit) {
      //
    });
    on<SaveUrl>((event, emit) {
      //
    });
    on<ObtainData>((event, emit) {
      //
    });
  }
}
