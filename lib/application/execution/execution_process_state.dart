part of 'execution_process_bloc.dart';

@immutable
class ExecutionProcessState {
  final String url;
  final bool isLoading;
  final bool isProcessing;
  final List<PathItem> items;
  final List<ResultItem> resultItems;
  final double percentageProgress;
  final bool hasNavigateToProcessing;
  final bool isResultSent;

  const ExecutionProcessState(
    this.url,
    this.isLoading,
    this.isProcessing,
    this.items,
    this.resultItems,
    this.percentageProgress,
    this.hasNavigateToProcessing,
    this.isResultSent,
  );

  factory ExecutionProcessState.initial() {
    return const ExecutionProcessState(
      '',
      false,
      false,
      [],
      [],
      0,
      false,
      false,
    );
  }

  ExecutionProcessState copyWith({
    String? url,
    bool? isLoading,
    bool? isProcessing,
    List<PathItem>? items,
    List<ResultItem>? resultItems,
    double? percentageProgress,
    bool? hasNavigateToProcessing,
    bool? isResultSent,
  }) {
    return ExecutionProcessState(
      url ?? this.url,
      isLoading ?? this.isLoading,
      isProcessing ?? this.isProcessing,
      items ?? this.items,
      resultItems ?? this.resultItems,
      percentageProgress ?? this.percentageProgress,
      hasNavigateToProcessing ?? this.hasNavigateToProcessing,
      isResultSent ?? this.isResultSent,
    );
  }
}
