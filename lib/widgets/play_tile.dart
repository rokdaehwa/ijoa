import 'package:flutter/material.dart';
import 'package:ijoa/pages/detail_page.dart';
import 'package:ijoa/utils/plays.dart';
import 'package:ijoa/utils/variables.dart';

class PlayTile extends StatelessWidget {
  final String field;
  final int playIndex;

  const PlayTile({Key key, this.field, this.playIndex}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> _playInfo = getPlayInfo(field, playIndex);
    return Container(
      width: 150,
      // height: 150,
      child: Card(
        color: graphColors[field],
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(_playInfo['subField']),
            ),
            ListTile(
              title: Text('${_playInfo['week'] + 1}주차'),
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
    Map<String, dynamic> _playInfo = getPlayInfo(field, playIndex);
    return Card(
      child: ListTile(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(
                      title: _playInfo['subField'],
                      url: _playInfo['url'],
                    ))),
        title: Text(_playInfo['subField']),
        subtitle: Text('${_playInfo['week'] + 1}주차'),
      ),
    );
  }
}
