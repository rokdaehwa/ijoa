import 'package:flutter/material.dart';
import 'package:ijoa/decorations/concave_decoration.dart';
import 'package:ijoa/models/event.dart';
import 'package:ijoa/utils/plays.dart';
import 'package:ijoa/utils/variables.dart';

class EventTile extends StatefulWidget {
  final Event event;

  const EventTile({Key key, this.event}) : super(key: key);

  @override
  _EventTileState createState() => _EventTileState();
}

class _EventTileState extends State<EventTile> {
  bool _isPlayed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: ConcaveDecoration(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          depth: 8),
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          // IconButton(
          //   icon: Icon(
          //     Icons.help,
          //     color: Colors.grey.shade400,
          //     size: 20.0,
          //   ),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => DetailPage(
          //               title: '놀이 자세히',
          //               url:
          //                   'https://www.notion.so/pavilionai/2-d4aa5017272f4d17bd6630baeecabb6a')),
          //     );
          //   },
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Chip(
                    label: Text('${widget.event.weekNumber}주차'),
                    labelStyle: TextStyle(fontSize: 12.0, color: Colors.grey),
                    visualDensity: VisualDensity.compact,
                    backgroundColor: Colors.grey.shade200,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0)),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Chip(
                    label: Text(fieldToKorean(widget.event.field)),
                    labelStyle: TextStyle(fontSize: 12.0, color: Colors.grey),
                    visualDensity: VisualDensity.compact,
                    backgroundColor: Colors.grey.shade200,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0)),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(title: Text(widget.event.childTag), dense: true,),
                  CheckboxListTile(
                    title: Text(playDatabase[widget.event.field][widget.event.playNumber]),
                    subtitle: Text(widget.event.subField),
                    value: _isPlayed,
                    onChanged: (isChecked) {
                      debugPrint('$isChecked');
                      setState(() {
                        _isPlayed = isChecked;
                      });
                      // TODO: 리스트 체크하면 DB 업데이트 하기
                      // widget.event.isPlayed = isChecked;
                    },
                  ),
                  // Text(
                  //   _playList[index],
                  //   style: TextStyle(
                  //       fontSize: 20.0, fontWeight: FontWeight.bold),
                  // ),
                  // Text(
                  //   '(협응적 조형활동)',
                  //   style: TextStyle(fontSize: 12.0, color: Colors.grey),
                  // ),
                ],
              ),
            ),
          ),

          // Divider(height: 0.0),
          Center(
            child: FlatButton(
              color: Colors.yellow.shade800,
              child: Text(
                '자세히 알아보기',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
            ),
          )
        ],
      ),
    );
  }
}
