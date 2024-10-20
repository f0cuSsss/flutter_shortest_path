import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shortest_path/application/execution/execution_process_bloc.dart';
import 'package:flutter_shortest_path/domain/execution/point.dart';
import 'package:flutter_shortest_path/domain/execution/result_item.dart';
import 'package:flutter_shortest_path/domain/start/path_item.dart';
import 'package:flutter_shortest_path/presentation/core/colors.dart';

class PreviewResultScreen extends StatelessWidget {
  const PreviewResultScreen(
      {super.key, required this.item, required this.resultItem});

  final PathItem item;
  final ResultItem resultItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview screen'),
        backgroundColor: const Color.fromARGB(255, 39, 190, 255),
      ),
      body: BlocConsumer<ExecutionProcessBloc, ExecutionProcessState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          item.field.isNotEmpty ? item.field[0].length : 1,
                      childAspectRatio: 1,
                    ),
                    itemCount: item.field.length * item.field[0].length,
                    itemBuilder: (context, index) {
                      int row = index ~/ item.field[0].length;
                      int col = index % item.field[0].length;
                      String cell = item.field[row][col];

                      Color cellColor;

                      if (Point(row, col) == item.start) {
                        cellColor = startCellColor;
                      } else if (Point(row, col) == item.end) {
                        cellColor = endCellColor;
                      } else if (resultItem.result.steps.any((step) =>
                          step.x == row.toString() &&
                          step.y == col.toString())) {
                        cellColor = shortestPathColor;
                      } else {
                        cellColor =
                            cell == 'X' ? blockedCellColor : emptyCellColor;
                      }

                      return Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: cellColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Center(
                          child: Text(
                            '($row;$col)',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Text(resultItem.result.path),
              ],
            ),
          );
        },
      ),
    );
  }
}
