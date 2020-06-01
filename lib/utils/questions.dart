import 'package:flutter/material.dart';
import 'package:ijoa/utils/questions/creativity_questions.dart';
import 'package:ijoa/utils/questions/happiness_questions.dart';
import 'package:ijoa/utils/questions/self_esteem_questions.dart';
import 'package:ijoa/utils/questions/sociality_questions.dart';

final List<String> socialityQuestions = getSocialityQuestions();
final List<String> selfEsteemQuestions = getSelfEsteemQuestions();
final List<String> creativityQuestions = getCreativityQuestions();
final List<String> happinessQuestions = getHappinessQuestions();
final List<String> scienceQuestions = getSocialityQuestions();

List<String> getRandomQuestions(int n, List<String> questions) {
  List<int> _randomSeed =
      List<int>.generate(questions.length, (index) => index);
  _randomSeed.shuffle();
  debugPrint('seed: $_randomSeed');
  List<String> _randomQuestions = [];
  for (int i = 0; i < n; i++) {
    _randomQuestions.add(questions[i]);
  }
  return _randomQuestions;
}