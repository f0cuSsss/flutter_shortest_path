import 'package:flutter_shortest_path/infrastructure/core/dto/json_serializable.dart';

import 'result.dart';

class ResultItem with JsonSerializable<ResultItem> {
  final String id;
  final Result result;

  ResultItem(this.id, this.result);

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'result': result.toJson(),
    };
  }
}
