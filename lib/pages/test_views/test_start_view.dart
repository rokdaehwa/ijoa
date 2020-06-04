import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ijoa/decorations/concave_decoration.dart';
import 'package:ijoa/decorations/nm_box.dart';
import 'package:ijoa/pages/info_page.dart';
import 'package:ijoa/widgets/custom_app_bar.dart';
import 'package:ijoa/widgets/nm_icon_button.dart';

class TestStartView extends StatelessWidget {
  final Function toNextPage;
  TestStartView(this.toNextPage);

  static Map<String, List<String>> yes = {
    "2020-05-24": ["event 1"],
    "2020-05-25": ["event 2-1", "event 2-2"],
    "2020-05-26": ["event 3"],
    "2020-05-27": ["event 4-1", "event 4-2", "event 4-3"],
  };

  // final yes2 = jsonEncode(yes);

  @override
  Widget build(BuildContext context) {
    // debugPrint('yes: ${jsonDecode(yes2)["2020-05-24"]}');
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            NMAppBar(
              leadingIcon: Icons.arrow_back_ios,
              leadingTooltip: '뒤로 가기',
              leadingOnTap: () => Navigator.pop(context),
              trailingIcon: Icons.help_outline,
              trailingTooltip: '테스트 하기',
              trailingOnTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InfoPage()),
              ),
              title: Text(
                  '아동 인지 검사',
                  style: Theme.of(context).textTheme.headline4,
                ),
            ),
            Expanded(child: _buildInfo()),
            Expanded(
              child: Center(
                child: GestureDetector(
                  onTap: () => toNextPage(),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 36.0),
                    decoration: nMbox,
                    child: Text(
                      '시작하기',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  Widget _buildInfo() {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('검사 개요 및 주의사항'),
          SizedBox(
            height: 8,
          ),
          Container(
            decoration: ConcaveDecoration(
                depth: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0))),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('검사는 약 10~15분 정도 소요됩니다. '),
                  Text('다섯 분야의 검사를 진행할 예정입니다. '),
                  Text('각 분야당 10문제(마지막 분야는 8문제)가 나옵니다. '),
                  Text('문제풀이에 집중할 수 있는 환경이 갖추어져 있는지 확인하시고, 아이와 소통해주세요. '),
                  Text('준비가 다 되셨다면, 아래 버튼을 눌러 검사를 시작하세요. '),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
