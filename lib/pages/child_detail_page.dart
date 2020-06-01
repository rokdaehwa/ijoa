import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:ijoa/decorations/concave_decoration.dart';
import 'package:ijoa/pages/detail_page.dart';
import 'package:ijoa/widgets/custom_app_bar.dart';
import 'package:ijoa/widgets/nm_icon_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ijoa/utils/variables.dart';
import 'package:ijoa/widgets/custom_bar_chart.dart';
import 'package:ijoa/widgets/custom_line_chart.dart';

import 'test_page.dart';

class ChildDetailPage extends StatefulWidget {
  final String childTag;
  ChildDetailPage({this.childTag});
  @override
  _ChildDetailPageState createState() => _ChildDetailPageState();
}

class _ChildDetailPageState extends State<ChildDetailPage> {
  List<bool> _selections = [true, false];
  int _selectedIndex = 0;
  final String _testResultString =
      '2020-05-24/2.4/1.2/1.1/3.5/2.7;2020-05-25/3.2/1.1/3.5/2.8/2.7;2020-05-26/1.3/3.5/2.8/3.1/3.5;';

  @override
  void initState() {
    super.initState();
    _startInit();
  }

  void _startInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _infoFromJson = prefs.getString('childFirst') ?? 'No info';
    debugPrint('detail: $_infoFromJson');
    // debugPrint('detail - decoded: ${jsonDecode(_infoFromJson)['firstName']}');
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
                trailingIcon: Icons.add,
                trailingTooltip: '테스트 하기',
                trailingOnTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TestPage()),
                ),
                title: RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.headline4,
                          children: [
                        TextSpan(
                          text: '첫째, ',
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextSpan(
                          text: widget.childTag,
                          // style: TextStyle(color: Colors.yellow.shade800),
                        ),
                      ]))
              ),
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
                            '변화 그래프',
                            style: Theme.of(context).textTheme.headline5,
                            // style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                        return Container(
                          width: 130,
                          child: Card(
                              margin: EdgeInsets.only(right: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Expanded(
                                      child: Center(
                                          child: Text(
                                              '${fieldToKorean(cognitionFields[index])}\n놀이 $index'))),
                                  FlatButton(
                                    child: Text('자세히'),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailPage(
                                                  title: '놀이 자세히',
                                                  url:
                                                      'https://www.notion.so/pavilionai/2-d4aa5017272f4d17bd6630baeecabb6a',
                                                )),
                                      );
                                    },
                                    textColor: Colors.grey,
                                  )
                                ],
                              )),
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
    List<String> _resultList = _testResultString.split(';');
    List<double> _points1 = [];
    List<double> _points2 = [];
    List<double> _points3 = [];
    List<double> _points4 = [];
    List<double> _points5 = [];
    for (int i = 0; i < _resultList.length - 1; i++) {
      List<String> _scores = _resultList[i].split('/');
      _points1.add(double.parse(_scores[1]));
      _points2.add(double.parse(_scores[2]));
      _points3.add(double.parse(_scores[3]));
      _points4.add(double.parse(_scores[4]));
      _points5.add(double.parse(_scores[5]));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: CustomPaint(
              size: Size(double.infinity, double.infinity),
              painter: LineChartPainter(
                points1: _points1,
                points2: _points2,
                points3: _points3,
                points4: _points4,
                points5: _points5,
              )),
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
    List<String> _resultList = _testResultString.split(';');
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              height: 230,
              margin: EdgeInsets.only(bottom: 12),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 8, bottom: 2),
                  itemCount: _resultList.length - 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: 160,
                      child: Card(
                        margin: EdgeInsets.only(right: 8),
                        child: Center(
                          child: Container(
                              height: 210,
                              child: CustomBarChart(
                                testResult: _resultList[index],
                                barHeight: 12.0,
                                maxWidth: 144,
                              )),
                        ),
                      ),
                    );
                  })),
        ],
      ),
    );
  }

  Widget _buildPlayedDone(String tag) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: <Widget>[
          Text(tag),
          Expanded(
            child: Container(
              width: 160.0,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      dense: true,
                      title: Text('놀이 이름'),
                      subtitle: Text(tag),
                    ),
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
