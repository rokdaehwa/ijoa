import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ijoa/models/event.dart';
import 'package:ijoa/pages/child_detail_page.dart';
import 'package:ijoa/pages/detail_page.dart';
import 'package:ijoa/utils/plays.dart';
import 'package:ijoa/utils/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventTile extends StatefulWidget {
  final int index;
  final String event;

  const EventTile({Key key, this.event, this.index}) : super(key: key);

  @override
  _EventTileState createState() => _EventTileState();
}

class _EventTileState extends State<EventTile> {
  bool _isPlayed = false;
  Color _contextColor = Colors.white;
  String _childInfo;

  @override
  void initState() {
    super.initState();
    debugPrint('len: ${widget.event.split('/').length}');
    _startInit();
    setState(() {
      _isPlayed = widget.event.split('/').length == 5;
    });
  }

  void _startInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _childInfo = prefs.getString(widget.event.split('/')[0]) ?? '';
    });
    debugPrint('childInfo: $_childInfo');
  }

  Map<String, dynamic> _getChildInfo() {
    if (_childInfo == null) return {};
    return jsonDecode(_childInfo);
  }

  void _setPlay() {
    if (_isPlayed)
      _setUnComplete();
    else
      _setComplete();
  }

  void _setComplete() async {
    String _date = DateTime.now().toString().split(' ')[0];
    List _eventInfo = widget.event.split('/');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    List<String> _eventsToday = _prefs.getStringList(_date) ?? [];
    String _eventCompleted =
        _eventsToday[widget.index].split('/').sublist(0, 3).join('/') +
            '/${DateTime.now()}';
    _eventsToday[widget.index] = _eventCompleted;
    debugPrint('complete? $_eventsToday');
    _prefs.setStringList(_date, _eventsToday);

    String _childInfoStirng = _prefs.getString(widget.event.split('/')[0]);
    Map<String, dynamic> _childInfoMap = jsonDecode(_childInfoStirng);
    _childInfoMap[_eventInfo[1]] += 1;
    _prefs.setString(widget.event.split('/')[0], jsonEncode(_childInfoMap));
    debugPrint('${jsonEncode(_childInfoMap)}');
    setState(() {
      _isPlayed = true;
    });
  }

  void _setUnComplete() async {
    String _date = DateTime.now().toString().split(' ')[0];
    List _eventInfo = widget.event.split('/');

    SharedPreferences _prefs = await SharedPreferences.getInstance();
    List<String> _eventsToday = _prefs.getStringList(_date) ?? [];
    String _eventCompleted =
        _eventsToday[widget.index].split('/').sublist(0, 3).join('/');
    _eventsToday[widget.index] = _eventCompleted;
    debugPrint('un-complete? $_eventsToday');
    _prefs.setStringList(_date, _eventsToday);

    String _childInfoStirng = _prefs.getString(widget.event.split('/')[0]);
    Map<String, dynamic> _childInfoMap = jsonDecode(_childInfoStirng);
    _childInfoMap[_eventInfo[1]] -= 1;
    _prefs.setString(widget.event.split('/')[0], jsonEncode(_childInfoMap));
    debugPrint('${jsonEncode(_childInfoMap)}');

    setState(() {
      _isPlayed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List _eventInfo = widget.event.split('/');
    debugPrint('tile info: $_eventInfo');
    String _field = _eventInfo[1];
    int _index = int.parse(_eventInfo[2]);
    Map<String, dynamic> _playInfo = getPlayInfo(_field, _index);
    return Container(
      width: 210,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: _isPlayed ? Colors.grey.shade300 : graphColors[_eventInfo[1]],
        borderRadius: BorderRadius.circular(32.0),
      ),
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Text(
                  _playInfo['subField'],
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: _contextColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailPage(
                              title: _playInfo['subField'],
                              url: _playInfo['url'],
                            ))),
                child: Container(
                  width: 24.0,
                  height: 24.0,
                  child: Center(
                    child: Icon(
                      Icons.more_vert,
                      size: 20.0,
                      color: _contextColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12.0,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                // _customChip(_eventInfo[0]),
                GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ChildDetailPage(
                                  childTag: _eventInfo[0],
                                ))),
                    child: _customChip(_getChildInfo()['name'] ?? '')),
                SizedBox(
                  width: 8.0,
                ),
                _customChip(fieldToKorean(_eventInfo[1])),
              ],
            ),
          ),
          Expanded(
            child: Container(),
          ),
          GestureDetector(
            onTap: () {
              _setPlay();
            },
            child: Container(
              height: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: _contextColor),
                // color: _contextColor.withOpacity(0.5)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Icon(Icons.check_box_outline_blank),
                  Text(
                    _isPlayed ? '취소' : '완료하기',
                    style: TextStyle(
                      color: _contextColor,
                      fontSize: 16.0,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _customChip(String label) {
    return Container(
      height: 30.0,
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
              color: _contextColor, letterSpacing: 1.0, fontSize: 12.0),
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: _contextColor.withOpacity(0.3)),
    );
  }
}
