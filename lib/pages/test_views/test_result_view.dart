import 'package:flutter/material.dart';
import 'package:ijoa/decorations/concave_decoration.dart';
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
                trailingOnTap: () => Navigator.pop(context, DateTime.now().toString()),
                title: Text(
                  '결과 분석',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Text('${date ?? DateTime.now().toString().split(' ')[0]}'),
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

  double _getAverage(List<int> score) {
    // List _score = scoreString.split('/');
    var _sum = score.map((e) => e).toList().reduce((a, b) => a + b);
    int _len = score.length;
    return _sum / _len;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('----------------');
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8.0),
          child: Text(
            '${fieldToKorean(tag)}',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        _buildFiledAnalysis(),
        SizedBox(height: 36.0,),

      ],
    );
  }

  Widget _buildFiledAnalysis() {
    final List<List<dynamic>> _analysisInfo = resultAnalysis[tag];
    final List _subFields = _analysisInfo[0];
    final List _numQuestions = _analysisInfo[1];
    final List _scoreHigh = _analysisInfo[2];
    final List _scoreLow = _analysisInfo[3];

    final int _numFields = _subFields.length;
    int _flag = 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      margin: EdgeInsets.only(top: 4.0, bottom: 24.0),
      child: Container(
        // height: 300,
        decoration: ConcaveDecoration(
            depth: 4,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0))),
        padding: EdgeInsets.all(8.0),
        child: Column(
          children:
              List.generate(_numFields, (index) => index).map((int index) {
            List<int> _fieldScores = index == 0
                ? scores.sublist(0, _numQuestions[index])
                : scores.sublist(_flag, _flag + _numQuestions[index]);
            _flag += _numQuestions[index];
            debugPrint(
                '${_subFields[index]} - ${_scoreHigh[index]} ~ ${_scoreLow[index]}');
            double _avgScore = _getAverage(_fieldScores);
            String _grade = '알수없음';
            Color _gradeColor = Colors.grey;
            if (_avgScore >= _scoreHigh[index]) {
              _grade = '상';
              _gradeColor = Colors.green[400];
            } else if (_scoreHigh[index] >= _avgScore &&
                _avgScore > _scoreLow[index]) {
              _grade = '중';
              _gradeColor = Colors.yellow.shade700;
            } else if (_scoreLow[index] >= _avgScore) {
              _grade = '하';
              _gradeColor = Colors.red.shade700;
            }

            return ListTile(
              title: Text('${_subFields[index]}'),
              subtitle: Text('평균: ${_avgScore.toStringAsFixed(2)}점'),
              trailing: Text(
                _grade,
                style: TextStyle(
                  // color: _gradeColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
