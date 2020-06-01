import '../questions.dart';

// 독창성 - 2문제
final List<String> _field1 = [
  '친숙한 재료를 이용하여 자신만의 작품을 만들어 낸다.',
  '글이나, 그림, 음악, 동작 등으로 자신의 생각을 표현하는 것을 좋아한다.',
  '여러 가지 형식과 방법으로 표현해보려고 하는 편이다.',
  '다른 친구들에 비해 새롭고 신선한 주제를 정하여 대화를 한다.',
  '개성이 강한 주제로 대화하는 것을 좋아한다.',
  '상상해서 이야기나 농담을 만들어낸다.',
  '자신이 만들어 낸 작품이나 물건 등을 좋아한다.',
  '기존의 물건이나 재료를 그대로 사용하기 보다는 새롭게 바꾸거나 쓰임새를 다르게 사용한다.'
];

// 호기심 - 2문제
final List<String> _field2 = [
  '자주 ‘왜? 그것은 왜 그럴까?’ 라는 질문을 한다.',
  '질문을 많이 한다.',
  '주변에 일어나는 일에 대해 관심이 많다.',
  '친구들이 당연하게 보는 것도 그냥 지나치지 않고 의문을 갖는다.',
  '새로운 교육 활동을 좋아한다.',
  '어떤 일을 새롭게 하는 것을 좋아한다.',
  '여러 가지 물건에 대해 호기심이 많다.',
  '주변에 색다른 점이나 일상적이 않은 것들이 일어나면 꼭 지적한다.',
  '사물을 자세히 관찰한다.'
];

// 몰입 - 2문제
final List<String> _field3 = [
  '주의 집중 시간이 또래에 비해 길다.',
  '종종 생각을 깊이 한다.',
  '충동적이지 않고 깊이 생각하고 행동한다.',
  '한 가지 놀이를 지속하는 시간이 길다.',
  '어떤 사물에 대해 흥미가 생기면 오랫동안 관심을 갖는다.',
  '어떤 일을 할 때, 푹 빠져드는 경향이 강하다.',
  '주어진 과제에 대해 문제를 해결할 때 까지 그것에 몰입한다.'
];

// 탈규범성 - 2문제
final List<String> _field4 = [
  '위험한 행동을 한다.',
  '모험적인 놀이를 자주한다. (예: 맘껏 모래놀이를 한다.)',
  '장난치기를 좋아한다.',
  '선생님이나 부모님께 묻기보다는 먼저 행동을 하는 편이다.',
  '획일적인 일과나 교육 활동을 싫어한다.',
  '자신이 좋아하는 일에 두려움 없이 한다.'
];

// 독립성 - 2문제
final List<String> _field5 = [
  '자기가 하고 싶은 활동만 하려고 한다.',
  '자기 주장이 강하고 고집이 세다',
  '좋아하고 싫어하는 것의 구분이 뚜렷하다.'
];

List<String> getCreativityQuestions() {
  List<String> _creativityQuestions = [];
  _creativityQuestions.addAll(getRandomQuestions(2, _field1));
  _creativityQuestions.addAll(getRandomQuestions(2, _field2));
  _creativityQuestions.addAll(getRandomQuestions(2, _field3));
  _creativityQuestions.addAll(getRandomQuestions(2, _field4));
  _creativityQuestions.addAll(getRandomQuestions(2, _field5));
  return _creativityQuestions;
}
