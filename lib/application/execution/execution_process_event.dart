part of 'execution_process_bloc.dart';

@immutable
sealed class ExecutionProcessEvent {}

final class UrlChanged extends ExecutionProcessEvent {
  final String url;
  UrlChanged(this.url);
}

final class ObtainDataAndStartProcessing extends ExecutionProcessEvent {}

final class SendResults extends ExecutionProcessEvent {}

final class NavigatedToProcessing extends ExecutionProcessEvent {}
