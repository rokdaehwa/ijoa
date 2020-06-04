import 'package:flutter/material.dart';
import 'package:ijoa/utils/variables.dart';

class CustomBarChart extends StatelessWidget {
  final double barHeight;
  final double maxWidth;
  final String testResult;
  double _getAverage(String scoreString) {
    List _score = scoreString.split('/');
    var _sum = _score.map((e) => int.parse(e)).toList().reduce((a, b) => a + b);
    int _len = _score.length;
    return _sum / _len;
  }

  CustomBarChart({this.testResult, this.barHeight, this.maxWidth});
  @override
  Widget build(BuildContext context) {
    List _result = testResult.split(';');
    List<double> _scores = _result.sublist(1).map((e) => _getAverage(e)).toList();
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _scores.asMap().keys.map((index) {
                double _ratio = _scores[index] / 4;
                String _field = cognitionFields[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${fieldToKorean(_field)} - ${_scores[index]}점',
                      style: TextStyle(fontSize: 9),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: barHeight / 3),
                      width: maxWidth * _ratio,
                      height: barHeight,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(barHeight)),
                          // color: Colors.amber.withOpacity(0.2 + _ratio * 0.8),
                          color: graphColors[_field]
                              .withOpacity(0.1 + _ratio * 0.9)),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
          Text(
            '${_result[0]}',
            style: TextStyle(color: Colors.grey, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
