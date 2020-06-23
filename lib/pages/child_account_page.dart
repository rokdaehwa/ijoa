import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ijoa/widgets/custom_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChildAccountPage extends StatefulWidget {
  final String childTag;

  const ChildAccountPage({Key key, this.childTag}) : super(key: key);
  @override
  _ChildAccountPageState createState() => _ChildAccountPageState();
}

class _ChildAccountPageState extends State<ChildAccountPage> {
  String _childInfo;

  @override
  void initState() {
    super.initState();
    _startInit();
  }

  void _startInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _childInfo = prefs.getString(widget.childTag);
    });
  }

  Map<String, dynamic> _getChildInfo() {
    if (_childInfo == null) return {'birthday': ''};
    return jsonDecode(_childInfo);
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> _childInfoMap = _getChildInfo();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            NMAppBar(
              title: Text(
                '아이 정보',
                style: Theme.of(context).textTheme.headline4,
              ),
              trailingIcon: Icons.close,
              trailingTooltip: '닫기',
              trailingOnTap: () => Navigator.pop(context),
            ),
            Container(
              padding: EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('이름'),
                    trailing: Text(_childInfoMap['name'] ?? '이름'),
                  ),
                  ListTile(
                    title: Text('생일'),
                    trailing:
                        Text(_childInfoMap['birthday'].split(' ')[0] ?? '생일'),
                  ),
                  ListTile(
                    title: Text('구분'),
                    trailing: Text(_childInfoMap['gender'] ?? '구분'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
