import 'dart:math';

import 'package:flutter/material.dart';

class RadarChartPainter extends CustomPainter {
  final List<double> scores;
  RadarChartPainter({this.scores});
  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2.0;
    var centerY = size.height / 2.0;
    var centerOffset = Offset(centerX, centerY);
    var radius = centerX * 0.8;

    var ticks = [1, 2, 3, 4];
    var tickDistance = radius / (ticks.length);
    const double tickLabelFontSize = 10;

    var ticksPaint = Paint()
      ..color = Colors.grey[300]
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..isAntiAlias = true;

    ticks.sublist(0, ticks.length).asMap().forEach((index, tick) {
      var tickRadius = tickDistance * (index + 1);

      canvas.drawCircle(centerOffset, tickRadius, ticksPaint);

      // TextPainter(
      //   text: TextSpan(
      //     text: tick.toString(),
      //     style: TextStyle(color: Colors.grey, fontSize: tickLabelFontSize),
      //   ),
      //   textDirection: TextDirection.ltr,
      // )
      //   ..layout(minWidth: 0, maxWidth: size.width)
      //   ..paint(
      //       canvas, Offset(centerX, centerY - tickRadius - tickLabelFontSize));
    });

    var features = ["사회성", "자아존중감", "창의성", "행복도", "과학적 사고"];
    var angle = (2 * pi) / features.length;
    const double featureLabelFontSize = 12;
    const double featureLabelFontWidth = 10;

    features.asMap().forEach((index, feature) {
      var xAngle = cos(angle * index - pi / 2);
      var yAngle = sin(angle * index - pi / 2);

      var featureOffset =
          Offset(centerX + radius * xAngle, centerY + radius * yAngle);
      var labelYOffset = yAngle < 0 ? -featureLabelFontSize : 0;
      var labelXOffset =
          xAngle < 0 ? -featureLabelFontWidth * feature.length : 0;

      TextPainter(
        text: TextSpan(
          text: feature,
          style: TextStyle(color: Colors.black, fontSize: featureLabelFontSize),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )
        ..layout(minWidth: 0, maxWidth: size.width)
        ..paint(
            canvas,
            Offset(featureOffset.dx + labelXOffset,
                featureOffset.dy + labelYOffset));
    });

    const graphColors = [Color(0xffbbbbbb), Colors.amber];
    var scale = radius / ticks.last;
    var data = [
      [2.0, 2.0, 2.0, 2.0, 2.0],
      scores
    ];
    data.asMap().forEach((index, graph) {
      var graphPaint = Paint()
        ..color = graphColors[index % graphColors.length].withOpacity(0.3)
        ..style = PaintingStyle.fill;

      var graphOutlinePaint = Paint()
        ..color = graphColors[index % graphColors.length]
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0
        ..isAntiAlias = true;

      // Start the graph on the initial point
      var scaledPoint = scale * graph[0];
      var path = Path();

      path.moveTo(centerX, centerY - scaledPoint);

      graph.sublist(1).asMap().forEach((index, point) {
        var xAngle = cos(angle * (index + 1) - pi / 2);
        var yAngle = sin(angle * (index + 1) - pi / 2);
        var scaledPoint = scale * point;

        path.lineTo(
            centerX + scaledPoint * xAngle, centerY + scaledPoint * yAngle);
      });

      path.close();
      canvas.drawPath(path, graphPaint);
      canvas.drawPath(path, graphOutlinePaint);
    });
  }

  @override
  bool shouldRepaint(RadarChartPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate.scores != scores;
  }
}