part of 'execution_process_bloc.dart';

@immutable
class ExecutionProcessState {
  final String url;
  final bool isLoading;

  const ExecutionProcessState(this.url, this.isLoading);

  factory ExecutionProcessState.initial() {
    return const ExecutionProcessState('', false);
  }

  ExecutionProcessState copyWith({String? url}) {
    return ExecutionProcessState(
      url ?? this.url,
      isLoading,
    );
  }
}
