import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shortest_path/application/execution/execution_process_bloc.dart';
import 'package:flutter_shortest_path/domain/execution/result_item.dart';
import 'package:flutter_shortest_path/presentation/result/preview_result_screen.dart';

class ResultListScreen extends StatelessWidget {
  const ResultListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result list screen'),
        backgroundColor: const Color.fromARGB(255, 39, 190, 255),
      ),
      body: SafeArea(
          child: BlocConsumer<ExecutionProcessBloc, ExecutionProcessState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.resultItems.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () => onItemTapped(context, state.resultItems[index]),
                title: Text(state.resultItems[index].result.path),
              );
            },
          );
        },
      )),
    );
  }

  onItemTapped(BuildContext context, ResultItem item) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PreviewResultScreen(
          item: context
              .read<ExecutionProcessBloc>()
              .state
              .items
              .firstWhere((el) => el.id == item.id),
          resultItem: item,
        ),
      ),
    );
  }
}
