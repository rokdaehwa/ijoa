import 'package:flutter/material.dart';
import 'package:ijoa/utils/variables.dart';
import 'package:ijoa/widgets/custom_app_bar.dart';
import 'package:ijoa/widgets/custom_radar_chart.dart';

class TestResultView extends StatelessWidget {
  final String childTag;
  final String date;
  final List<int> socialityScore;
  final List<int> selfEsteemScore;
  final List<int> creativityScore;
  final List<int> happinessScore;
  final List<int> scienceScore;

  TestResultView(
      {this.childTag,
      this.date,
      this.socialityScore,
      this.selfEsteemScore,
      this.creativityScore,
      this.happinessScore,
      this.scienceScore});

  double _getAverage(List<int> score) {
    // List _score = scoreString.split('/');
    var _sum = score.map((e) => e).toList().reduce((a, b) => a + b);
    int _len = score.length;
    return _sum / _len;
  }

  @override
  Widget build(BuildContext context) {
    List<double> _scores = [
      _getAverage(socialityScore),
      _getAverage(selfEsteemScore),
      _getAverage(creativityScore),
      _getAverage(happinessScore),
      _getAverage(scienceScore),
    ];
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              NMAppBar(
                trailingIcon: Icons.close,
                trailingTooltip: '닫기',
                trailingOnTap: () => Navigator.pop(context),
                title: Text(
                  '결과 분석',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Text('$date'),
              CustomPaint(
                size: Size(300, 300),
                painter: RadarChartPainter(scores: _scores),
              ),
              FieldAnalysis(scores: socialityScore, tag: 'sociality'),
              FieldAnalysis(scores: selfEsteemScore, tag: 'selfEsteem'),
              FieldAnalysis(scores: creativityScore, tag: 'creativity'),
              FieldAnalysis(scores: happinessScore, tag: 'happiness'),
              FieldAnalysis(scores: scienceScore, tag: 'science'),
            ],
          ),
        ),
      ),
    );
  }
}

class FieldAnalysis extends StatelessWidget {
  final String tag;
  final List<int> scores;

  const FieldAnalysis({Key key, this.tag, this.scores}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('$tag'),
        Text('$scores'),
        Text('${resultAnalysis[tag]}')
      ],
    );
  }
}
