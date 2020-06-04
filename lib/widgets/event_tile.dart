import 'package:flutter/material.dart';
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
  Color _contextColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color:
            _isPlayed ? Colors.grey.shade300 : graphColors[widget.event.field],
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
                  playDatabase[widget.event.field][widget.event.playNumber],
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: _contextColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              GestureDetector(
                onTap: () {},
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
          Row(
            children: <Widget>[
              _customChip(widget.event.childTag),
              SizedBox(
                width: 8.0,
              ),
              _customChip(fieldToKorean(widget.event.field)),
            ],
          ),
          Expanded(
            child: Container(),
          ),
          GestureDetector(
            onTap: () {
              // TODO: database에 업데이트
              setState(() {
                _isPlayed = !_isPlayed;
              });
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
                    _isPlayed ? '완료함' : '완료하기',
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
