import 'package:flutter/material.dart';

class PlayDetailPage extends StatelessWidget {
  final String field;
  final int playIndex;

  const PlayDetailPage({Key key, this.field, this.playIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(field),
    );
  }
}