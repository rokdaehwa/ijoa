import 'package:flutter/material.dart';
import 'package:ijoa/utils/variables.dart';

class LineChartPainter extends CustomPainter {
  List<double> points1;
  List<double> points2;
  List<double> points3;
  List<double> points4;
  List<double> points5;

  LineChartPainter({
    @required this.points1,
    @required this.points2,
    @required this.points3,
    @required this.points4,
    @required this.points5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    List<Offset> offsets1 = getCoordinates(points1, size);
    List<Offset> offsets2 = getCoordinates(points2, size);
    List<Offset> offsets3 = getCoordinates(points3, size);
    List<Offset> offsets4 = getCoordinates(points4, size);
    List<Offset> offsets5 = getCoordinates(points5, size);
    drawLines(canvas, size, offsets1, graphColors['sociality']);
    drawLines(canvas, size, offsets2, graphColors['selfEsteem']);
    drawLines(canvas, size, offsets3, graphColors['creativity']);
    drawLines(canvas, size, offsets4, graphColors['happiness']);
    drawLines(canvas, size, offsets5, graphColors['science']);
  }

  List<Offset> getCoordinates(List<double> points, Size size) {
    List<Offset> coordinates = [];
    int len = points.length;
    for (int i = 0; i < len; i++) {
      Offset point = Offset((size.width * (2 * i + 1)) / (2 * len),
          size.height * (1 - points[i] / 5));
      coordinates.add(point);
    }
    return coordinates;
  }

  void drawLines(
      Canvas canvas, Size size, List<Offset> offsets, Color lineColor) {
    Paint paint = Paint()
      ..color = lineColor
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Path path = Path();

    double dx = offsets[0].dx;
    double dy = offsets[0].dy;

    path.moveTo(dx, dy);
    offsets.map((offset) => path.lineTo(offset.dx, offset.dy)).toList();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(LineChartPainter old) {
    return points1 != old.points1 ||
        points2 != old.points2 ||
        points3 != old.points3 ||
        points4 != old.points4 ||
        points5 != old.points5;
  }
}
