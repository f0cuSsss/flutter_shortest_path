import 'package:flutter_shortest_path/infrastructure/core/dto/json_serializable.dart';

class Point with JsonSerializable<Point> {
  final int x;
  final int y;

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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Point &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}

class PointString with JsonSerializable<PointString> {
  final String x;
  final String y;

  PointString(this.x, this.y);

  factory PointString.fromJson(Map<String, dynamic> json) {
    return PointString(
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
