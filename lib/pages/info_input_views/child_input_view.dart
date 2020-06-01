import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:ijoa/decorations/concave_decoration.dart';
import 'package:ijoa/widgets/nm_text_button.dart';

class ChildInputView extends StatefulWidget {
  final int index;
  final Function handleMetadata;
  final Function toNextPage;

  const ChildInputView(
      {Key key, this.index, this.handleMetadata, this.toNextPage})
      : super(key: key);

  @override
  _ChildInputViewState createState() => _ChildInputViewState();
}

class _ChildInputViewState extends State<ChildInputView> {
  final List<String> _list = [' 딸 ', '아들', '기타'];
  List<bool> _selections = [false, false, false];

  String _name;
  DateTime _selectedDate;
  String _gender;

  bool _isCompleted() {
    return _name != null && _selectedDate != null && _gender != null;
  }

  Text _getPickerString(DateTime date) {
    if (date == null)
      return Text("생년월일을 선택해주세요",
          style: TextStyle(color: Colors.grey, fontSize: 16.0));
    return Text(
      '$date'.split(' ')[0],
      style: TextStyle(fontSize: 16.0, color: Colors.black87),
    );
  }

  void _getMetadata() {
    List _metadata = [_name, _selectedDate, _gender];
    widget.handleMetadata(_metadata);
  }

  String _getKoreanChild(int index) {
    switch (index) {
      case 0:
        return '첫째';
      case 1:
        return '둘째';
      case 2:
        return '셋째';
      case 3:
        return '넷째';
      case 4:
        return '다섯째';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _nmWrapper(
              child: TextField(
            decoration: InputDecoration(
                labelText: '${_getKoreanChild(widget.index)} 이름 (혹은 별명)',
                labelStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
                // floatingLabelBehavior: FloatingLabelBehavior.never,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0)),
            onChanged: (String value) {
              debugPrint(value);
              setState(() {
                _name = value;
              });
              widget.handleMetadata([_name, _selectedDate, _gender]);
            },
          )),
          _nmWrapper(
              child: Row(
            children: <Widget>[
              FlatButton(
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2000, 1, 1),
                        maxTime: DateTime.now(), onConfirm: (date) {
                      setState(() {
                        _selectedDate = date;
                      });
                      widget.handleMetadata([_name, _selectedDate, _gender]);
                      print('confirm $date');
                    },
                        currentTime: _selectedDate ?? DateTime(2000, 1, 1),
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
                        _gender = _list[index];
                        _selections = _reset;
                        _selections[index] = true;
                      });
                      widget.handleMetadata([_name, _selectedDate, _gender]);
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 36.0),
          Text(
            '모든 아이에 대해 입력을 완료 하셨다면,',
            style: TextStyle(color: Colors.grey, fontSize: 12.0),
          ),
          Text(
            '오른쪽 상단의 체크 버튼을 누르세요',
            style: TextStyle(color: Colors.grey, fontSize: 12.0),
          ),
          SizedBox(height: 16.0),
          Center(
            child: widget.index == 4
                ? Text('최대 5명까지 입력할 수 있습니다')
                : NMTextButton(
                    text: '${_getKoreanChild(widget.index + 1)} 추가하기',
                    onTap: () => widget.toNextPage(),
                    disabled: !_isCompleted()),
          )
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
