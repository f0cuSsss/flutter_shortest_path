import 'package:flutter_shortest_path/domain/execution/point.dart';

class ShortestPathSearcher {
  final List<String> grid;
  final Point start;
  final Point end;
  final int rows;
  final int cols;
  List<Point> shortestPath = [];
  List<Point> currentPath = [];

  static const int minGridSize = 2;
  static const int maxGridSize = 99;

  ShortestPathSearcher(
    this.grid,
    this.start,
    this.end,
  )   : rows = grid.length,
        cols = grid[0].length {
    if (rows < minGridSize ||
        rows > maxGridSize ||
        cols < minGridSize ||
        cols > maxGridSize) {
      throw Exception(
          'Grid size must be between $minGridSize and $maxGridSize.');
    }
  }

  final List<Point> directions = [
    Point('-1', '-1'),
    Point('-1', '0'),
    Point('-1', '1'),
    Point('0', '-1'),
    Point('0', '1'),
    Point('1', '-1'),
    Point('1', '0'),
    Point('1', '1'),
  ];

  bool isWithinBounds(int x, int y) {
    return x >= 0 && x < rows && y >= 0 && y < cols;
  }

  bool isBlocked(int x, int y) {
    return grid[x][y] == 'X';
  }

  void findPath(Point current) {
    if (current.x == end.x && current.y == end.y) {
      if (shortestPath.isEmpty || currentPath.length < shortestPath.length) {
        shortestPath = List.from(currentPath);
      }
      return;
    }

    currentPath.add(current);

    for (var direction in directions) {
      int x = int.parse(current.x);
      int y = int.parse(current.y);

      while (true) {
        x += int.parse(direction.x);
        y += int.parse(direction.y);

        if (isWithinBounds(x, y) && !isBlocked(x, y)) {
          findPath(Point(x.toString(), y.toString()));
        } else {
          break;
        }
      }
    }

    currentPath.removeLast();
  }

  List<Point> _getShortestPath() {
    findPath(start);
    return shortestPath;
  }

  List<Map<String, dynamic>> findShortestPaths(
    List<Map<String, dynamic>> data,
  ) {
    List<Map<String, dynamic>> results = [];

    for (var item in data) {
      List<String> grid = List<String>.from(item['field']);
      Point start =
          Point(item['start']['x'].toString(), item['start']['y'].toString());
      Point end =
          Point(item['end']['x'].toString(), item['end']['y'].toString());

      ShortestPathSearcher pathFinder = ShortestPathSearcher(grid, start, end);
      List<Point> path = pathFinder._getShortestPath();

      results.add({
        'start': {'x': start.x, 'y': start.y},
        'end': {'x': end.x, 'y': end.y},
        'path': path.map((pos) => {'x': pos.x, 'y': pos.y}).toList(),
      });
    }

    return results;
  }
}
