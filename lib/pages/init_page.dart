import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ijoa/models/user.dart';
import 'package:ijoa/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'info_input_page.dart';

class InitPage extends StatefulWidget {
  @override
  _InitPageState createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  @override
  void initState() {
    super.initState();
    _startHandler();
  }

  void _startHandler() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _user = prefs.getString('USER');
    List<String> _eventsToday =
        prefs.getStringList('${DateTime.now().toString().split(' ')[0]}');

    List<String> _childrenMetadata = prefs.getStringList('CHILDRENMETADATA');
    if (_user == null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => InfoInputPage(
                    initialPage: 0,
                  )));
    } else if (_user != null && _childrenMetadata == null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => InfoInputPage(
                    initialPage: 1,
                  )));
    } else {
      debugPrint('init: $_user');
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    user: User.fromJson(jsonDecode(_user)),
                    eventsToday: _eventsToday ?? [],
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 100,
          width: 100,
        ),
      ),
    );
  }
}
