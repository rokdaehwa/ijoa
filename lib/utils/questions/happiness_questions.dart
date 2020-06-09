// 몰입 및 영성 - 3문제
import '../questions.dart';

final List<String> _field1 = [
  '어떤 활동을 할 때 깊이 몰입한다.',
  '좋아하는 일을 할 때 잘 집중한다.',
  '다른 흥미 있는 일들이 있어도 자신이 하던 일에 잘 집중한다.',
  '한 번 시작한 일은 그것이 완성될 때 까지 계속한다.',
  '그림에 대한 자신의 경험과 느낌을 이야기로 표현한다.',
  '동화 또는 이야기에 쉽게 감흥한다.',
  '부모, 교사 혹은 또래 친구 등 주변 사람의 변화된 모습 (옷, 신발. 머리 스타일) 등에 대해 이야기한다.',
  '음악 감상 활동 후 느낌을 몸이나 언어로 표현할 수 있다.',
  '다른 유아들이 모르고 지나치는 것의 아름다움을 발견한다.'
];

// 사회관계 - 2문제
final List<String> _field2 = [
  '친구들에게 인기가 있다.',
  '친구들을 잘 도와준다.',
  '친한 친구가 있다.',
  '친구들과의 놀이를 즐겁게 이끌어 간다.',
  '사람에 대한 애정적 표현을 잘 한다.',
  '집에서 선생님의 이야기를 많이 한다.',
  '선생님과 부모님께 사랑받고 있다고 생각하느냐는 질문에 주저 없이 그렇다고 대답한다.'
];

// 인지 및 성취 - 2문제
final List<String> _field3 = [
  '어려운 퍼즐을 잘 맞춘다.',
  '책을 혼자 읽을 수 있다.',
  '발표를 잘 한다.',
  '수를 세거나 다루는 것에 거부감을 느끼지 않는다.',
  '주어진 과제에 대한 문제해결능력이 있다.'
];

// 건강 및 정서 - 3문제
final List<String> _field4 = [
  '문제가 발생할 때 친사회적인 방법으로 해결한다.',
  '몸이 건강하다.',
  '정신이 건강하다.',
  '체력이 강하다.',
  '건강한 생활을 한다.',
  '정서가 안정적이다.',
  '다른 사람의 기분을 잘 알아차린다.',
  '친구가 놀릴 때 무조건 화내지 않고 적절히 대응한다.',
  '보호자가 바쁘다고 하면 자신의 요구사항을 지연시킨다.'
];

List<String> getHappinessQuestions() {
  List<String> _happinessQuestions = [];
  _happinessQuestions.addAll(getRandomQuestions(3, _field1));
  _happinessQuestions.addAll(getRandomQuestions(2, _field2));
  _happinessQuestions.addAll(getRandomQuestions(2, _field3));
  _happinessQuestions.addAll(getRandomQuestions(3, _field4));
  return _happinessQuestions;
}
