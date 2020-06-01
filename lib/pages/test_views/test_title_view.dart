import 'package:flutter/material.dart';

class TestTitleView extends StatefulWidget {
  final Function toNextPage;
  final String titleText;
  TestTitleView(this.toNextPage, this.titleText);
  @override
  _TestTitleViewState createState() => _TestTitleViewState();
}

class _TestTitleViewState extends State<TestTitleView> {
  // TODO: make it false
  bool _visible = true;

  Future _getTestInfo(milli) async {
    await Future.delayed(Duration(milliseconds: milli));
  }

  @override
  void initState() {
    super.initState();
    // TODO: custom animation (use FadeTransition?)
    _getTestInfo(3000).then((value) => widget.toNextPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity: _visible ? 1.0 : 0.0,
          duration: Duration(milliseconds: 500),
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget.titleText,
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
