part of 'execution_process_bloc.dart';

@immutable
sealed class ExecutionProcessEvent {}

final class UrlChanged extends ExecutionProcessEvent {
  final String url;
  UrlChanged(this.url);
}

final class SaveUrl extends ExecutionProcessEvent {}

final class ObtainData extends ExecutionProcessEvent {}
