import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shortest_path/application/execution/execution_process_bloc.dart';
import 'package:flutter_shortest_path/presentation/execution/execution_process_screen.dart';

class BaseUrlScreen extends StatelessWidget {
  const BaseUrlScreen({super.key});

  onStartPressed(BuildContext context) {
    context.read<ExecutionProcessBloc>().add(ObtainDataAndStartProcessing());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home screen'),
        backgroundColor: const Color.fromARGB(255, 39, 190, 255),
      ),
      body: SafeArea(
        child: BlocConsumer<ExecutionProcessBloc, ExecutionProcessState>(
          listener: (context, state) {
            if (state.items.isNotEmpty && !state.hasNavigateToProcessing) {
              context.read<ExecutionProcessBloc>().add(NavigatedToProcessing());
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const ExecutionProcessScreen(),
                ),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Set valid API base URL in order to continue'),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.arrow_right_alt),
                    ),
                    onChanged: (value) {
                      context
                          .read<ExecutionProcessBloc>()
                          .add(UrlChanged(value));
                    },
                  ),
                  const Spacer(),
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
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.blue[300]),
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
                            onPressed: () => onStartPressed(context),
                            child: const Text('Start counting process'),
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
