import 'package:flutter/material.dart';

class PlayTile extends StatelessWidget {
  final String field;
  final int playIndex;

  const PlayTile({Key key, this.field, this.playIndex}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      // height: 150,
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(field),
            ),
            ListTile(
              title: Text('$playIndex'),
            )
          ],
        ),
      ),
    );
  }
}

class PlayedTile extends StatelessWidget {
  final String field;
  final int playIndex;

  const PlayedTile({Key key, this.field, this.playIndex}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(field),
        subtitle: Text('index: $playIndex'),
      ),
    );
  }
}
