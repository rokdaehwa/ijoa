import 'dart:convert';
import 'dart:core';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:ijoa/decorations/concave_decoration.dart';
import 'package:ijoa/pages/child_account_page.dart';
import 'package:ijoa/pages/detail_page.dart';
import 'package:ijoa/pages/test_views/test_result_view.dart';
import 'package:ijoa/widgets/custom_app_bar.dart';
import 'package:ijoa/widgets/play_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ijoa/utils/variables.dart';
import 'package:ijoa/widgets/custom_bar_chart.dart';
import 'package:ijoa/widgets/custom_line_chart.dart';

import 'test_page.dart';

class ChildDetailPage extends StatefulWidget {
  final String childTag;

  const ChildDetailPage({Key key, this.childTag}) : super(key: key);
  @override
  _ChildDetailPageState createState() => _ChildDetailPageState();
}

class _ChildDetailPageState extends State<ChildDetailPage> {
  List<bool> _selections = [false, true];
  int _selectedIndex = 1;
  List<String> _testResultString = [];
  String _childInfo;

  // List<String> _testResultString;

  double _getAverage(String scoreString) {
    List _score = scoreString.split('/');
    var _sum = _score.map((e) => int.parse(e)).toList().reduce((a, b) => a + b);
    int _len = _score.length;
    return _sum / _len;
  }

  List<int> _scoreStringToList(String scoreString) {
    return scoreString.split('/').map((e) => int.parse(e)).toList();
  }

  @override
  void initState() {
    super.initState();
    debugPrint('child-detail-page: ${widget.childTag}');
    _startInit();
  }

  void _startInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _testResultString =
          prefs.getStringList('${widget.childTag}RESULTS') ?? [];
      _childInfo = prefs.getString(widget.childTag) ?? 'child-datail-page';
    });
    debugPrint('childInfo: $_childInfo');
  }

  Map<String, dynamic> _getChildInfo() {
    if (_childInfo == null) return {};
    return jsonDecode(_childInfo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              NMAppBar(
                  leadingIcon: Icons.arrow_back_ios,
                  leadingTooltip: '뒤로 가기',
                  leadingOnTap: () => Navigator.pop(context),
                  trailingIcon: Icons.account_circle,
                  trailingTooltip: '정보 수정하기',
                  trailingOnTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChildAccountPage(
                                  childTag: widget.childTag,
                                )),
                      ),
                  title: RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.headline4,
                          children: [
                        TextSpan(
                          text: '${childTagToKorean(widget.childTag)}, ',
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextSpan(text: '${_getChildInfo()['name'] ?? '이름'}'
                            // style: TextStyle(color: Colors.yellow.shade800),
                            ),
                      ]))),
              Container(
                decoration: ConcaveDecoration(
                    depth: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)))),
                padding: EdgeInsets.only(top: 8),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '검사 결과',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          Container(
                            decoration: ConcaveDecoration(
                                depth: 4,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(4.0)))),
                            height: 30,
                            child: ToggleButtons(
                              isSelected: _selections,
                              renderBorder: false,
                              /* selected */
                              selectedColor: Colors.black,
                              selectedBorderColor: Colors.transparent,
                              // fillColor: Colors.amber[100],
                              /* not selected */
                              color: Colors.black12,
                              children: <Widget>[
                                Tooltip(
                                    message: '변화 보기',
                                    child: Icon(Icons.show_chart)),
                                Tooltip(
                                    message: '개별 보기',
                                    child: Icon(Icons.short_text))
                              ],
                              onPressed: (int index) {
                                List<bool> _reset = [false, false];
                                setState(() {
                                  _selectedIndex = index;
                                  _selections = _reset;
                                  _selections[index] = true;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 12),
                      height: 250,
                      child: _selectedIndex == 0
                          ? _getLineChart()
                          : _getBarGraph(),
                    ),
                  ],
                ),
              ),
              Divider(),
              _buildTitle(title: '해야할 놀이들'),
              Container(
                  height: 160,
                  margin: EdgeInsets.only(bottom: 12),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(left: 8, bottom: 2),
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return PlayTile(
                          field: cognitionFields[index],
                          playIndex:
                              _getChildInfo()[cognitionFields[index]] ?? 0,
                        );
                      })),
              Divider(),
              _buildTitle(title: '진행했던 놀이들'),
              Container(
                  height: 240,
                  margin: EdgeInsets.only(bottom: 16),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      _buildPlayedDone('sociality'),
                      _buildPlayedDone('selfEsteem'),
                      _buildPlayedDone('creativity'),
                      _buildPlayedDone('happiness'),
                      _buildPlayedDone('science'),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle({String title}) {
    return Container(
      margin: EdgeInsets.only(left: 8, bottom: 12, top: 16),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }

  Widget _getLineChart() {
    List<String> _resultList = _testResultString;
    List<double> _points1 = [];
    List<double> _points2 = [];
    List<double> _points3 = [];
    List<double> _points4 = [];
    List<double> _points5 = [];
    for (int i = 0; i < _resultList.length; i++) {
      List<String> _scores = _resultList[i].split(';');
      debugPrint('_scores: ${_scores.length}');
      _points1.add(_getAverage(_scores[1]));
      _points2.add(_getAverage(_scores[2]));
      _points3.add(_getAverage(_scores[3]));
      _points4.add(_getAverage(_scores[4]));
      _points5.add(_getAverage(_scores[5]));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: _testResultString.isNotEmpty
              ? CustomPaint(
                  size: Size(double.infinity, double.infinity),
                  painter: LineChartPainter(
                    points1: _points1,
                    points2: _points2,
                    points3: _points3,
                    points4: _points4,
                    points5: _points5,
                  ))
              : Center(
                  child: Text('검사 결과 없음'),
                ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: cognitionFields
                .map((e) => Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(left: 8, right: 4),
                              color: graphColors[e],
                              height: 2,
                              width: 15),
                          Text(
                            fieldToKorean(e),
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _getBarGraph() {
    List<String> _resultList = _testResultString;
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Container(
          height: 230,
          margin: EdgeInsets.only(bottom: 12),
          child: ListView.builder(
              // reverse: true,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 8, bottom: 2),
              itemCount: _resultList.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0)
                  return Container(
                      width: 160,
                      height: 210,
                      margin: EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TestPage(
                                      childTag: widget.childTag,
                                    )),
                          );
                          _startInit();
                        },
                        child: Card(
                          child: Center(
                              child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(4.0),
                            strokeCap: StrokeCap.round,
                            dashPattern: [4, 4],
                            strokeWidth: 2,
                            color: Colors.grey.shade400,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              child: Container(
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.add,
                                        color: Colors.grey.shade600,
                                      ),
                                      Text(
                                        '테스트 추가',
                                        style: TextStyle(
                                            // color: Colors.white,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )),
                        ),
                      ));
                int _i = _resultList.length - index;
                debugPrint('index is $_i');
                return Container(
                  width: 160,
                  child: GestureDetector(
                    onTap: () {
                      debugPrint('result detail!');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TestResultView(
                                  childTag: widget.childTag,
                                  date: _resultList[_i].split(';')[0],
                                  socialityScore: _scoreStringToList(
                                      _resultList[_i].split(';')[1]),
                                  selfEsteemScore: _scoreStringToList(
                                      _resultList[_i].split(';')[2]),
                                  creativityScore: _scoreStringToList(
                                      _resultList[_i].split(';')[3]),
                                  happinessScore: _scoreStringToList(
                                      _resultList[_i].split(';')[4]),
                                  scienceScore: _scoreStringToList(
                                      _resultList[_i].split(';')[5]),
                                )),
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.only(right: 8),
                      child: Center(
                        child: Container(
                            height: 210,
                            child: CustomBarChart(
                              testResult: _resultList[_i],
                              barHeight: 12.0,
                              maxWidth: 144,
                            )),
                      ),
                    ),
                  ),
                );
              })),
    );
  }

  Widget _buildPlayedDone(String tag) {
    return Container(
      width: 160,
      padding: const EdgeInsets.only(left: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(fieldToKorean(tag)),
          (_getChildInfo()[tag] == 0)
              ? Text(
                  '\n아직 없어요',
                  style: TextStyle(color: Colors.grey),
                )
              : Expanded(
                  child: Container(
                    // width: 160.0,
                    child: ListView.builder(
                      itemCount: _getChildInfo()[tag],
                      itemBuilder: (BuildContext context, int index) {
                        return PlayedTile(
                          field: tag,
                          playIndex: index,
                        );
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
