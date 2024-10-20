import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shortest_path/application/execution/execution_process_bloc.dart';
import 'package:flutter_shortest_path/injection.dart';

class ExecutionProcessScreen extends StatelessWidget {
  const ExecutionProcessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExecutionProcessBloc>(
      create: (context) => getIt<ExecutionProcessBloc>(),
      child: const ExecutionProcessScreenContent(),
    );
  }
}

class ExecutionProcessScreenContent extends StatelessWidget {
  const ExecutionProcessScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Process screen'),
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}
