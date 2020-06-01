import '../questions.dart';

// 인지적 - 2문제
final List<String> _field1 = [
  '그림조각을 잘 맞춘다.',
  '숫자놀이를 잘한다.',
  '수를 잘 센다.',
  '글자를 안다.',
  '색깔의 이름을 안다.'
];

// 동료 수용 - 2문제
final List<String> _field2 = [
  '만들기를 잘 한다.',
  '함께 놀 친구가 있다.',
  '친구들이 게임 혹은 놀이에 넣어준다.',
  '친구들이 장난감을 나눠 준다.',
  '놀이터에서 놀 친구가 많다.',
  '친구들이 옆에 앉으려고 한다.',
  '친구들과 사이좋게 논다.'
];

// 신체적 - 2문제
final List<String> _field3 = [
  '혼자 그네를 잘 탄다.',
  '한 발로 뛰기를 잘 한다.',
  '옷의 단추를 잘 끼운다.',
  '계단 오르기를 잘 한다.',
  '빨리 달리기를 잘한다.'
];

// 어머니 수용 - 2문제
final List<String> _field4 = [
  '가위로 오리기를 잘 한다.',
  '친구를 집에 놀러 오게 할 수 있다.',
  '어머니와 이야기를 나누는 것을 좋아한다.',
  '어머니와 함께 노는 것을 좋아한다.',
  '어머니가 예쁘다고 쓰다듬어 주신다.',
  '어머니가 맛있는 음식을 만들어주신다.',
  '어머니가 안아 주신다.'
];

// 자가 수용 - 2문제
final List<String> _field5 = [
  '무슨일이든 하고싶고 재미있으며 자신이 있다.',
  '장난감 치우기 등을 할 수 있는 일은 스스로 한다.',
  '나는 내가 좋고 나를 사랑한다.',
  '마음에 드는 일을 하면 기분이 좋다.',
  '나는 밝고 명랑하고 자주 웃는다.',
  '나는 “할 수 있어요”, “하고 싶어요”의 말을 자주 쓴다.'
];

List<String> getSelfEsteemQuestions() {
  List<String> _selfEsteemQuestions = [];
  _selfEsteemQuestions.addAll(getRandomQuestions(2, _field1));
  _selfEsteemQuestions.addAll(getRandomQuestions(2, _field2));
  _selfEsteemQuestions.addAll(getRandomQuestions(2, _field3));
  _selfEsteemQuestions.addAll(getRandomQuestions(2, _field4));
  _selfEsteemQuestions.addAll(getRandomQuestions(2, _field5));
  return _selfEsteemQuestions;
}
