import 'package:flutter_shortest_path/domain/execution/point.dart';
import 'package:flutter_shortest_path/infrastructure/core/dto/json_serializable.dart';

class Result with JsonSerializable<Result> {
  final List<PointString> steps;
  final String path;

  Result(this.steps, this.path);

  @override
  Map<String, dynamic> toJson() {
    return {
      'steps': steps.map((el) => el.toJson()).toList(),
      'path': path,
    };
  }
}
