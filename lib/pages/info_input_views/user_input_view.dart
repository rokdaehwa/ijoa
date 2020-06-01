import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:ijoa/decorations/concave_decoration.dart';
import 'package:ijoa/pages/info_page.dart';
import 'package:ijoa/widgets/custom_app_bar.dart';
import 'package:ijoa/widgets/nm_text_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInputView extends StatefulWidget {
  final Function toNextPage;

  const UserInputView({Key key, this.toNextPage}) : super(key: key);

  @override
  _UserInputViewState createState() => _UserInputViewState();
}

class _UserInputViewState extends State<UserInputView> {
  final List<String> _list = ['엄마', '아빠', '기타'];
  List<bool> _selections = [false, false, false];

  String _name;
  DateTime _selectedDate;
  String _momOrDad;

  Text _getPickerString(DateTime date) {
    if (date == null)
      return Text("생년월일을 선택해주세요",
          style: TextStyle(color: Colors.grey, fontSize: 16.0));
    return Text(
      '$date'.split(' ')[0],
      style: TextStyle(fontSize: 16.0, color: Colors.black87),
    );
  }

  bool _isComplete() {
    return _name != null && _selectedDate != null && _momOrDad != null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          NMAppBar(
            title: Text(
              '정보를 입력하세요',
              style: Theme.of(context).textTheme.headline4,
            ),
            trailingIcon: Icons.help_outline,
            trailingTooltip: '아동 인지에 대해 알아보세요!',
            trailingOnTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => InfoPage())),
          ),
          SizedBox(
            height: 12.0,
          ),
          Text(
            '본인(예. 학부모님)의 정보를 입력해주세요.',
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(
            height: 8.0,
          ),
          _nmWrapper(
              child: TextField(
            decoration: InputDecoration(
                labelText: '이름 (혹은 별명)',
                labelStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
                // floatingLabelBehavior: FloatingLabelBehavior.never,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0)),
            onChanged: (value) {
              setState(() {
                _name = value;
              });
            },
          )),
          _nmWrapper(
              child: Row(
            children: <Widget>[
              FlatButton(
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(1940, 1, 1),
                        maxTime: DateTime(2010, 12, 31), onConfirm: (date) {
                      setState(() {
                        _selectedDate = date;
                      });
                      print('confirm $date');
                    },
                        currentTime: _selectedDate ?? DateTime(1940, 1, 1),
                        locale: LocaleType.ko);
                  },
                  child: _getPickerString(_selectedDate)),
            ],
          )),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    '선택해주세요',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Container(
                  decoration: ConcaveDecoration(
                      depth: 8,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0))),
                  child: ToggleButtons(
                    isSelected: _selections,
                    renderBorder: false,
                    /* selected */
                    selectedColor: Colors.black,
                    selectedBorderColor: Colors.transparent,
                    borderRadius: BorderRadius.circular(4.0),
                    /* not selected */
                    color: Colors.black26,
                    children: _list
                        .map((e) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 22.0),
                              child: Text(e),
                            ))
                        .toList(),
                    onPressed: (int index) {
                      List<bool> _reset = [false, false, false];
                      setState(() {
                        _momOrDad = _list[index];
                        _selections = _reset;
                        _selections[index] = true;
                      });
                      debugPrint('_momOrDad: $_momOrDad');
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 48.0,
          ),
          NMTextButton(
              text: '아이정보 입력하기',
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                Map<String, dynamic> _userInfo = {
                  'name': _name,
                  'birthday': '$_selectedDate'.split(' ')[0],
                  'momOrDad': _momOrDad,
                };
                prefs.setString('USER', jsonEncode(_userInfo));
                widget.toNextPage();
              },
              disabled: !_isComplete())
        ],
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
}
