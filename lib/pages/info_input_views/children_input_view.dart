import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ijoa/pages/init_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ijoa/pages/info_input_views/child_input_view.dart';
import 'package:ijoa/widgets/custom_app_bar.dart';

class ChildrenInputView extends StatefulWidget {
  final int initialPage;

  const ChildrenInputView({Key key, this.initialPage}) : super(key: key);

  @override
  _ChildrenInputViewState createState() => _ChildrenInputViewState();
}

class _ChildrenInputViewState extends State<ChildrenInputView> {
  List<List> childrenMetadata = List<List>.generate(5, (index) => []);

  void toPrevPage() {
    debugPrint('children next page');
    const _duration = const Duration(milliseconds: 300);
    const _curve = Curves.ease;
    pageController.previousPage(duration: _duration, curve: _curve);
  }

  void toNextPage() {
    debugPrint('children next page');
    const _duration = const Duration(milliseconds: 300);
    const _curve = Curves.ease;
    pageController.nextPage(duration: _duration, curve: _curve);
  }

  void _setPreferences(int numChild) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> _childrenMetadata = [];
    for (int i = 0; i < numChild; i++) {
      List _metadata = childrenMetadata[i];
      String _dataString =
          _metadata[0].toString() + '/아직 없습니다/아직 없습니다';
      Map<String, dynamic> _json = {
        'name': _metadata[0].toString(),
        'birthday': _metadata[1].toString(),
        'gender': _metadata[2].toString(),
        'sociality': 0,
        'selfEsteem': 0,
        'creativity': 0,
        'happiness': 0,
        'science': 0,
      };
      debugPrint('_dataString: $_dataString');
      _childrenMetadata.add(_dataString);
      prefs.setString('CHILDINDEX$i', jsonEncode(_json));
    }
    prefs.setStringList('CHILDRENMETADATA', _childrenMetadata);
  }

  // void _

  PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController =
        PageController(initialPage: widget.initialPage, keepPage: true);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NMAppBar(
          title: Text(
            '아이들의 정보를 입력하세요',
            style: Theme.of(context).textTheme.headline4,
          ),
          trailingIcon: Icons.done_all,
          trailingTooltip: '입력 완료',
          trailingOnTap: () async {
            debugPrint('입력 완료: ${pageController.page.round()}');
            int numChild = 0;
            for (int i = 0; i < childrenMetadata.length; i++) {
              debugPrint('child$i: ${childrenMetadata[i]}');
              if (childrenMetadata[i].length != 0) numChild++;
            }
            debugPrint('numChild: $numChild');
            if (childrenMetadata[pageController.page.round()].contains(null)) {
              debugPrint('Null detected!');
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('답하지 않은 문항이 있습니다.'),
                  action: SnackBarAction(
                    label: (numChild == 1) ? '' : '닫고 저장하기',
                    onPressed: () async {
                      // TODO: shared_preferences에 저장하고 home 화면으로 넘기는 아주 중요한 함수
                      if (numChild <= 1) return;
                      _setPreferences(numChild - 1);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => InitPage()));
                    },
                    textColor: Colors.white,
                  ),
                  backgroundColor: Colors.redAccent));
            } else {
              // TODO: shared_preferences에 저장하고 home 화면으로 넘기는 아주 중요한 함수
              if (numChild <= 0) return;
              _setPreferences(numChild);
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => InitPage()));
            }
          },
        ),
        SizedBox(
          height: 12.0,
        ),
        Text(
          '아이들의 정보를 입력해주세요. (최대 5명)',
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(
          height: 8.0,
        ),
        Expanded(
          child: PageView(
            controller: pageController,
            physics: NeverScrollableScrollPhysics(),
            children: List.generate(5, (index) => index).map((i) {
              return ChildInputView(
                index: i,
                handleMetadata: (List metadata) {
                  debugPrint('metadata from child: $metadata');
                  setState(() {
                    childrenMetadata[i] = metadata;
                  });
                },
                toNextPage: toNextPage,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
