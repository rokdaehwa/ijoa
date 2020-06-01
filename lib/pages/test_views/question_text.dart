import 'package:flutter/material.dart';
import 'package:ijoa/decorations/concave_decoration.dart';

class QuestionText extends StatefulWidget {
  final int index;
  final int radioValue;
  final Function handleRadioValue;
  final String question;
  QuestionText(
      {Key key,
      @required this.index,
      @required this.question,
      @required this.radioValue,
      @required this.handleRadioValue});

  @override
  _QuestionTextState createState() => _QuestionTextState();
}

class _QuestionTextState extends State<QuestionText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: ConcaveDecoration(
            depth: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Column(
            children: <Widget>[
              Text('${widget.index + 1}번. ${widget.question}'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Radio(
                        value: 4,
                        groupValue: widget.radioValue,
                        onChanged: widget.handleRadioValue),
                    Radio(
                        value: 3,
                        groupValue: widget.radioValue,
                        onChanged: widget.handleRadioValue),
                    Radio(
                        value: 2,
                        groupValue: widget.radioValue,
                        onChanged: widget.handleRadioValue),
                    Radio(
                        value: 1,
                        groupValue: widget.radioValue,
                        onChanged: widget.handleRadioValue),
                    Radio(
                        value: 0,
                        groupValue: widget.radioValue,
                        onChanged: widget.handleRadioValue),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('매우 그렇다'),
                  Text('전혀 아니다'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
