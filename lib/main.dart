import 'package:flutter/material.dart';

import 'injection.dart';
import 'presentation/core/shortest_path_app.dart';

void main() {
  configureInjection();

  runApp(const ShortestPathApp());
}
