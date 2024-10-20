import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shortest_path/application/execution/execution_process_bloc.dart';
import 'package:flutter_shortest_path/presentation/result/result_list_screen.dart';

class ExecutionProcessScreen extends StatelessWidget {
  const ExecutionProcessScreen({super.key});

  onSendResultsToServer(BuildContext context) {
    context.read<ExecutionProcessBloc>().add(SendResults());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Process screen'),
        backgroundColor: const Color.fromARGB(255, 39, 190, 255),
      ),
      body: SafeArea(
        child: BlocConsumer<ExecutionProcessBloc, ExecutionProcessState>(
          listener: (context, state) {
            if (state.isResultSent) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const ResultListScreen(),
                ),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Text(
                    state.isProcessing
                        ? 'Processing...'
                        : 'All calculations has finished, you can send your results to server',
                  ),
                  const SizedBox(height: 10),
                  Text(
                    ' ${(state.percentageProgress * 100).toStringAsFixed(0)}%',
                  ),
                  const SizedBox(height: 20),
                  if (state.isProcessing)
                    const Center(
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(
                          strokeWidth: 0.5,
                        ),
                      ),
                    ),
                  const SizedBox(height: 10),
                  const Spacer(),
                  if (!state.isProcessing)
                    state.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 0.5,
                            ),
                          )
                        : SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: FilledButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  Colors.blue[300],
                                ),
                                shape: WidgetStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(
                                      color: Colors.black,
                                      width: 0.5,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () => onSendResultsToServer(context),
                              child: const Text('Send results to server'),
                            ),
                          ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
