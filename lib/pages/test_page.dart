import 'package:flutter/material.dart';
import 'package:ijoa/pages/test_views/test_start_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

// test_views
import 'test_views/test_title_view.dart';
import 'test_views/test_questions_view.dart';
import 'test_views/test_end_view.dart';
import 'test_views/test_result_view.dart';

class TestPage extends StatefulWidget {
  final childTag;
  TestPage({this.childTag});
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  String socialityScore;
  String selfEsteemScore;
  String creativityScore;
  String happinessScore;
  String scienceScore;

  void handleScore(result, String tag) {
    switch (tag) {
      case 'sociality':
        setState(() {
          socialityScore = result;
        });
        break;
      case 'selfEsteem':
        setState(() {
          selfEsteemScore = result;
        });
        break;
      case 'creativity':
        setState(() {
          creativityScore = result;
        });
        break;
      case 'happiness':
        setState(() {
          happinessScore = result;
        });
        break;
      case 'science':
        setState(() {
          scienceScore = result;
        });
        break;
      default:
    }
  }

  String _getResult() {
    String _day = DateTime.now().toString().split(' ')[0];

    return [
      _day,
      socialityScore,
      selfEsteemScore,
      creativityScore,
      happinessScore,
      scienceScore
    ].join(';');
  }

  void toNextPage() {
    debugPrint('to Next Page !!!');
    const _duration = const Duration(milliseconds: 300);
    const _curve = Curves.ease;
    pageController.nextPage(duration: _duration, curve: _curve);
  }

  Future setPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> _childResults =
        prefs.getStringList('${widget.childTag}RESULTS') ?? [];
    List<String> _childrenMetadata =
        prefs.getStringList('CHILDRENMETADATA') ?? [];
    
    List<String> _newList = List<String>();
    _newList.addAll(_childResults);
    _newList.add(_getResult());
    debugPrint('_getResult: ${_getResult()}');
    prefs.setStringList('${widget.childTag}RESULTS', _newList);

    int _childIndex = int.parse(widget.childTag[widget.childTag.length - 1]);
    List<String> _childMetadata = _childrenMetadata[_childIndex].split('/');
    _childMetadata[1] =
        '${_getAverage(socialityScore)},${_getAverage(selfEsteemScore)},${_getAverage(creativityScore)},${_getAverage(happinessScore)},${_getAverage(scienceScore)}';
    _childMetadata[2] = DateTime.now().toString().split(' ')[0];
    _childrenMetadata[_childIndex] = _childMetadata.join('/');
    prefs.setStringList('CHILDRENMETADATA', _childrenMetadata);
    return '$_childrenMetadata';
  }

  Future setMetadata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> _childrenMetadata =
        prefs.getStringList('CHILDRENMETADATA') ?? [];
    int _childIndex = int.parse(widget.childTag[widget.childTag.length - 1]);
    List<String> _childMetadata = _childrenMetadata[_childIndex].split('/');
    _childMetadata[1] =
        '${_getAverage(socialityScore)},${_getAverage(selfEsteemScore)},${_getAverage(creativityScore)},${_getAverage(happinessScore)},${_getAverage(scienceScore)}';
    _childMetadata[2] = DateTime.now().toString().split(' ')[0];
    _childrenMetadata[_childIndex] = _childMetadata.join('/');
    prefs.setStringList('CHILDRENMETADATA', _childrenMetadata);
    return '$_childrenMetadata';
  }

  String _getAverage(String scoreString) {
    List _score = scoreString.split('/');
    var _sum = _score.map((e) => int.parse(e)).toList().reduce((a, b) => a + b);
    int _len = _score.length;
    return (_sum / _len).toStringAsFixed(2);
  }

  List<int> _scoreStringToList(String scoreString) {
    if (scoreString == null) return [];
    List<String> _score = scoreString.split('/');
    return _score.map((e) => int.parse(e)).toList();
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  Widget build(BuildContext context) {
    debugPrint('socialityScore: $socialityScore');
    debugPrint('selfEsteemScore: $selfEsteemScore');
    debugPrint('creativityScore: $creativityScore');
    debugPrint('happinessScore: $happinessScore');
    debugPrint('scienceScore: $scienceScore');

    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: pageController,
      children: <Widget>[
        TestStartView(toNextPage),
        TestTitleView(toNextPage, '사회성'),
        TestQuestionsView(
          handleScore,
          toNextPage,
          tag: 'sociality',
        ),
        TestTitleView(toNextPage, '자아존중감'),
        TestQuestionsView(
          handleScore,
          toNextPage,
          tag: 'selfEsteem',
        ),
        TestTitleView(toNextPage, '창의성'),
        TestQuestionsView(
          handleScore,
          toNextPage,
          tag: 'creativity',
        ),
        TestTitleView(toNextPage, '행복도'),
        TestQuestionsView(
          handleScore,
          toNextPage,
          tag: 'happiness',
        ),
        TestTitleView(toNextPage, '과학적 사고'),
        TestQuestionsView(
          handleScore,
          toNextPage,
          tag: 'science',
        ),
        // TODO: end page animation
        TestEndView(toNextPage, setPreferences),
        TestResultView(
          childTag: widget.childTag,
          socialityScore: _scoreStringToList(socialityScore),
          selfEsteemScore: _scoreStringToList(selfEsteemScore),
          creativityScore: _scoreStringToList(creativityScore),
          happinessScore: _scoreStringToList(happinessScore),
          scienceScore: _scoreStringToList(scienceScore),
        ),
      ],
    );
  }
}
