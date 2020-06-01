import 'package:flutter/material.dart';
import 'package:ijoa/pages/test_views/test_start_view.dart';

// test_views
import 'test_views/test_title_view.dart';
import 'test_views/test_questions_view.dart';
import 'test_views/test_end_view.dart';
import 'test_views/test_result_view.dart';

class TestPage extends StatefulWidget {
  // TOOD: use child key?
  final name;
  TestPage({this.name});
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

  void toNextPage() {
    debugPrint('to Next Page !!!');
    const _duration = const Duration(milliseconds: 300);
    const _curve = Curves.ease;
    pageController.nextPage(duration: _duration, curve: _curve);
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
        TestStartView(
          toNextPage,
        ),
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
        // TestEndView(toNextPage),
        TestResultView(
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
