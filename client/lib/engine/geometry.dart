import 'dart:math';

class Triangle {
  final double x1;
  final double y1;
  final double x2;
  final double y2;
  final double x3;
  final double y3;
  final double area;

  Triangle(this.x1, this.y1, this.x2, this.y2, this.x3, this.y3)
      : area = areaFromPoints(x1, y1, x2, y2, x3, y3);

  factory Triangle.fromOriginAndVectors(
    double x,
    double y,
    double angle1,
    double magnitude1,
    double angle2,
    double magnitude2,
  ) {
    final int dx1 = (cos(angle1) * magnitude1).toInt();
    final int dy1 = (sin(angle1) * magnitude1).toInt();
    final int dx2 = (cos(angle2) * magnitude2).toInt();
    final int dy2 = (sin(angle2) * magnitude2).toInt();

    return Triangle(x, y, x + dx1, y + dy1, x + dx2, y + dy2);
  }

  // both area and contains implementation from
  // https://www.geeksforgeeks.org/check-whether-a-given-point-lies-inside-a-triangle-or-not/
  // potentially faster solutions
  // https://stackoverflow.com/questions/2049582/how-to-determine-if-a-point-is-in-a-2d-triangle
  bool contains(double x, double y) {
    final area23 = areaFromPoints(x, y, x2, y2, x3, y3);
    final area13 = areaFromPoints(x1, y1, x, y, x3, y3);
    final area12 = areaFromPoints(x1, y1, x2, y2, x, y);
    return area == (area23 + area13 + area12);
  }

  static double areaFromPoints(
    double x1,
    double y1,
    double x2,
    double y2,
    double x3,
    double y3,
  ) {
    return ((x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2)) / 2.0).abs();
  }

  @override
  String toString() {
    return 'Triangle{ ($x1:$y1) ,($x2:$y2), ($x3:$y3); area: $area}';
  }
}

class Circle {
  final double cx;
  final double cy;
  final double radius;

  Circle(this.cx, this.cy, this.radius);

  bool contains(double x, double y) {
    final dx = x - cx;
    final dy = y - cy;
    return dx * dx + dy * dy <= radius * radius;
  }
}

/*
void main() {
  final triangle = Triangle(0, 0, 10, 4, 8, 5);
  final contained = triangle.contains(9, 1);
  print('area: ${triangle.area}');
  print('contained: $contained');

  final triangle1 = Triangle.fromOriginAndVectors(0, 0, 0, 10, 3.14 / 4, 10);
  print(triangle1.toString());
}
*/
