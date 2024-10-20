import 'package:flutter_shortest_path/domain/execution/point.dart';
import 'package:flutter_shortest_path/infrastructure/core/dto/json_serializable.dart';

class PathItem with JsonSerializable<PathItem> {
  final String id;
  final List<String> field;
  final Point start;
  final Point end;

  PathItem(this.id, this.field, this.start, this.end);

  factory PathItem.fromJson(Map<String, dynamic> json) {
    return PathItem(
      json['id'],
      List<String>.from(json['field'] as List<dynamic>),
      Point.fromJson(json['start']),
      Point.fromJson(json['end']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}
