import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ijoa/decorations/concave_decoration.dart';
import 'package:ijoa/utils/plays.dart';
import 'package:ijoa/utils/variables.dart';
import 'package:ijoa/widgets/custom_app_bar.dart';
import 'package:ijoa/widgets/nm_text_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPlayPage extends StatefulWidget {
  final String childTag;

  const AddPlayPage({Key key, this.childTag}) : super(key: key);
  @override
  _AddPlayPageState createState() => _AddPlayPageState();
}

class _AddPlayPageState extends State<AddPlayPage> {
  static List<String> _children = ['name'];
  static int _childIndex = 0;

  String _selectedChild;
  String _selectedField;

  @override
  void initState() {
    super.initState();
    _startInit();
  }

  void _startInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> _result = prefs.getStringList('CHILDRENMETADATA');
    setState(() {
      _children = _result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            NMAppBar(
              title: Text(
                '오늘의 놀이 추가',
                style: Theme.of(context).textTheme.headline4,
              ),
              trailingIcon: Icons.close,
              trailingOnTap: () => Navigator.pop(context),
              trailingTooltip: '닫기',
            ),
            SizedBox(
              height: 12.0,
            ),
            Text(
              '오늘은 ${DateTime.now().toString().split(' ')[0]} 입니다',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: 8.0,
            ),
            _nmWrapper(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: <Widget>[
                  Text(
                    '누구와 놀까요?',
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  _buildChildSelector(),
                ],
              ),
            )),
            (_selectedChild == null)
                ? Container()
                : _nmWrapper(
                    child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          '놀이할 분야',
                          style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        _buildFieldSelector(),
                      ],
                    ),
                  )),
            // _buildSubFieldSelector()
            Expanded(child: Container()),
            NMTextButton(
              disabled: _selectedField == null,
              text: '추가하기',
              onTap: () async {
                debugPrint('${DateTime.now().toString().split(' ')[0]}');
                SharedPreferences _prefs =
                    await SharedPreferences.getInstance();
                String _childInfoStirng =
                    _prefs.getString('CHILDINDEX$_childIndex');
                Map<String, dynamic> _childInfoMap =
                    jsonDecode(_childInfoStirng);
                // int _subFieldIndex = _childInfoMap[_selectedField] % 6;
                // int _weekIndex = _childInfoMap[_selectedField] ~/ 6;
                String _event =
                    'CHILDINDEX$_childIndex/$_selectedField/${_childInfoMap[_selectedField]}';
                List<String> _eventsToday = _prefs.getStringList(
                        '${DateTime.now().toString().split(' ')[0]}') ??
                    [];
                List<String> _newEvents = List<String>();
                _newEvents.addAll(_eventsToday);
                _newEvents.add(_event);
                debugPrint('${jsonEncode(_childInfoMap)}');
                _prefs.setString(
                    'CHILDINDEX$_childIndex', jsonEncode(_childInfoMap));
                _prefs.setStringList(
                    '${DateTime.now().toString().split(' ')[0]}', _newEvents);
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 60)
          ],
        ),
      ),
    );
  }

  Widget _nmWrapper({Widget child}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: ConcaveDecoration(
            depth: 8,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0))),
        child: child,
      ),
    );
  }

  Widget _buildChildSelector() {
    return DropdownButton<String>(
      hint: Text('선택하세요'),
      value: _selectedChild,
      icon: Icon(Icons.arrow_drop_down),
      onChanged: (String newValue) {
        setState(() {
          _selectedChild = newValue;
        });
      },
      items: _children
          .asMap()
          .map((index, value) {
            String _childName = value.split('/')[0] ?? 'name';
            debugPrint('child selector value!: $value');
            return MapEntry(
                index,
                DropdownMenuItem(
                  child: Text(_childName),
                  value: value,
                  onTap: () {
                    setState(() {
                      _childIndex = index;
                    });
                  },
                ));
          })
          .values
          .toList(),
    );
  }

  Widget _buildFieldSelector() {
    return DropdownButton<String>(
      hint: Text('선택하세요'),
      value: _selectedField,
      icon: Icon(Icons.arrow_drop_down),
      onChanged: (String newValue) {
        setState(() {
          _selectedField = newValue;
        });
      },
      items: cognitionFields
          .asMap()
          .map((index, value) {
            return MapEntry(
                index,
                DropdownMenuItem(
                  child: Text(fieldToKorean(value)),
                  value: value,
                ));
          })
          .values
          .toList(),
    );
  }
}
