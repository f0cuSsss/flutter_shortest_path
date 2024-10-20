import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shortest_path/application/execution/execution_process_bloc.dart';
import 'package:flutter_shortest_path/injection.dart';
import 'package:flutter_shortest_path/presentation/start/base_url_screen.dart';

class ShortestPathApp extends StatelessWidget {
  const ShortestPathApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shortest Path',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider<ExecutionProcessBloc>(
        create: (context) => getIt<ExecutionProcessBloc>(),
        child: const BaseUrlScreen(),
      ),
    );
  }
}
