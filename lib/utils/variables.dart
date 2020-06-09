import 'package:flutter/material.dart';

List<String> cognitionFields = [
  'sociality',
  'selfEsteem',
  'creativity',
  'happiness',
  'science'
];

String fieldToKorean(String field) {
  switch (field) {
    case 'sociality':
      return '사회성';
    case 'selfEsteem':
      return '자아존중감';
    case 'creativity':
      return '창의성';
    case 'happiness':
      return '행복도';
    case 'science':
      return '과학적사고';
    default:
      return field;
  }
}

String childTagToKorean(String childTag) {
  switch (childTag) {
    case 'CHILDINDEX0':
      return '첫째';
    case 'CHILDINDEX1':
      return '둘째';
    case 'CHILDINDEX2':
      return '셋째';
    case 'CHILDINDEX3':
      return '넷째';
    case 'CHILDINDEX4':
      return '다섯째';
    default:
      return '알수없음';
  }
}

final Map<String, Color> graphColors = {
  'sociality': Color(0xaaF8C89D),
  'selfEsteem': Color(0xaa1E90F9),
  'creativity': Color(0xaa5ECDB1),
  'happiness': Color(0xaa8685B3),
  'science': Color(0xaa4DD9E0)
};

final Map<String, List<List>> resultAnalysis = {
  "sociality": [
    ['문제해결', '정서표현', '질서의식', '자신감'],
    [3, 2, 2, 3],
    [2.7, 3.0, 2.5, 2.8],
    [1.5, 1.7, 1.4, 1.3]
  ],
  'selfEsteem': [
    ['인지적', '동료 수용', '신체적', '어머니 수용', '자가 수용'],
    [2, 2, 2, 2, 2],
    [3.86, 3.38, 3.42, 3.77, 3.40],
    [2.80, 1.82, 2.76, 1.98, 2.84]
  ],
  'creativity': [
    ['독창성', '호기심', '몰입성', '탈규범성', '독립성'],
    [2, 2, 2, 2, 2],
    [3.2, 3.5, 3.2, 3.0, 2.5],
    [2.7, 2.9, 2.7, 2.5, 1.8]
  ],
  'happiness': [
    ['몰입 및 영성', '사회관계', '인지 및 성취', '겅강 및 정서'],
    [3, 2, 2, 3],
    [3.2, 3.5, 3.2, 3.0],
    [2.7, 2.9, 2.7, 2.5]
  ],
  'science': [
    ['관찰하기', '분류하기', '측정하기', '예측하기'],
    [2, 1, 2, 1],
    [2.5, 2.7, 2.5, 2.7],
    [1.5, 1.6, 1.5, 1.6],
  ]
};
