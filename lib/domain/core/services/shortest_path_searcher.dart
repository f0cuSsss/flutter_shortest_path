import 'package:flutter_shortest_path/domain/execution/point.dart';
import 'package:flutter_shortest_path/domain/execution/result.dart';
import 'package:flutter_shortest_path/domain/execution/result_item.dart';
import 'package:flutter_shortest_path/domain/start/path_item.dart';

class ShortestPathService {
  ResultItem? findShortestPath(
    PathItem item,
  ) {
    ShortestPathSearcher pathFinder =
        ShortestPathSearcher(item.field, item.start, item.end);
    List<Point> path = pathFinder.getShortestPath();

    return path.isEmpty
        ? null
        : ResultItem(
            item.id,
            Result(
              path
                  .map((pos) => PointString(pos.x.toString(), pos.y.toString()))
                  .toList(),
              path.map((pos) => '(${pos.x},${pos.y})').join('->'),
            ),
          );
  }
}

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

  ShortestPathSearcher(this.grid, this.start, this.end)
      : rows = grid.length,
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
    Point(-1, -1),
    Point(-1, 0),
    Point(-1, 1),
    Point(0, -1),
    Point(0, 1),
    Point(1, -1),
    Point(1, 0),
    Point(1, 1),
  ];

  bool isWithinBounds(int x, int y) {
    return x >= 0 && x < rows && y >= 0 && y < cols;
  }

  bool isBlocked(int x, int y) {
    return grid[x][y] == 'X';
  }

  void findPath(Point current, Set<Point> visited) {
    if (current.x == end.x && current.y == end.y) {
      if (shortestPath.isEmpty || currentPath.length < shortestPath.length) {
        shortestPath = List.from(currentPath);
      }
      return;
    }

    currentPath.add(current);
    visited.add(current);

    for (var direction in directions) {
      int newX = current.x + direction.x;
      int newY = current.y + direction.y;

      if (isWithinBounds(newX, newY) &&
          !isBlocked(newX, newY) &&
          !visited.contains(Point(newX, newY))) {
        findPath(Point(newX, newY), visited);
      }
    }

    currentPath.removeLast();
    visited.remove(current);
  }

  List<Point> getShortestPath() {
    Set<Point> visited = {start};
    findPath(start, visited);

    List<Point> fullPath = [];
    fullPath.addAll(shortestPath);
    if (!shortestPath.contains(end)) {
      fullPath.add(end);
    }

    return fullPath;
  }
}
