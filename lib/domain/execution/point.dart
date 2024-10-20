import 'package:flutter_shortest_path/infrastructure/core/dto/json_serializable.dart';

class Point with JsonSerializable<Point> {
  final String x;
  final String y;

  Point(this.x, this.y);

  factory Point.fromJson(Map<String, dynamic> json) {
    return Point(
      json['x'],
      json['y'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
    };
  }
}
