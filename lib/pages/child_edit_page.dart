import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChildEditPage extends StatefulWidget {
  final String childTag;

  const ChildEditPage({Key key, this.childTag}) : super(key: key);
  @override
  _ChildEditPageState createState() => _ChildEditPageState();
}

class _ChildEditPageState extends State<ChildEditPage> {
  String _childInfo;

  @override
  void initState() {
    super.initState();
    _startInit();
  }

  void _startInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _childInfo = prefs.getString(widget.childTag) ?? 'No Child Info';
    });
    debugPrint('childInfo edit: $_childInfo');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('_childInfo: $_childInfo'),
      ),
    );
  }
}
