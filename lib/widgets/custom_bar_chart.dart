import 'package:flutter/material.dart';
import 'package:ijoa/utils/variables.dart';

class CustomBarChart extends StatelessWidget {
  final double barHeight;
  final double maxWidth;
  final String testResult;
  CustomBarChart({this.testResult, this.barHeight, this.maxWidth});
  @override
  Widget build(BuildContext context) {
    List _result = testResult.split('/');
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _result.sublist(1).asMap().keys.map((index) {
                double _ratio = double.parse(_result[index + 1]) / 4;
                String _field = cognitionFields[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${fieldToKorean(_field)} - ${_result[index + 1]}점',
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
