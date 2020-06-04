import 'package:flutter/material.dart';
import 'package:ijoa/utils/questions.dart';
import 'package:ijoa/utils/variables.dart';
import 'package:ijoa/widgets/nm_icon_button.dart';
import 'question_text.dart';

class TestQuestionsView extends StatefulWidget {
  final Function toNextPage;
  final Function(String, String) handleScore;
  final String tag;

  TestQuestionsView(this.handleScore, this.toNextPage, {this.tag});

  @override
  _TestQuestionsViewState createState() => _TestQuestionsViewState();
}

class _TestQuestionsViewState extends State<TestQuestionsView> {
  List<int> radioValues = List<int>.generate(10, (index) => -1);

  List<String> questions;

  int getProgress() {
    int count = 0;
    for (int i = 0; i < radioValues.length; i++) {
      if (radioValues[i] != -1) count++;
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.tag) {
      case 'sociality':
        questions = socialityQuestions;
        break;
      case 'selfEsteem':
        questions = selfEsteemQuestions;
        break;
      case 'creativity':
        questions = creativityQuestions;
        break;
      case 'happiness':
        questions = happinessQuestions;
        break;
      case 'science':
        questions = scienceQuestions;
        break;
      default:
    }
    bool _isCompleted = getProgress() == questions.length;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    fieldToKorean(widget.tag),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Tooltip(
                    message: '지금 종료하면 저장되지 않습니다.',
                    child: NMButton(
                      icon: Icons.close,
                      onTap: () => Navigator.pop(context),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                getProgress().toString() + "/" + questions.length.toString(),
                style:
                    TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
              ),
            ),
            SizedBox(
                height: 2,
                child: LinearProgressIndicator(
                  value: getProgress() / 10,
                  backgroundColor: Colors.grey[100],
                )),
            Expanded(
              child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(),
                  itemCount: questions.length + 1,
                  itemBuilder: (BuildContext context, int index) =>
                      (index == questions.length)
                          ? SizedBox(
                              height: 60.0,
                            )
                          : QuestionText(
                              index: index,
                              question: questions[index],
                              radioValue: radioValues[index],
                              handleRadioValue: (int value) {
                                setState(() {
                                  radioValues[index] = value;
                                });
                              })),
            ),
          ],
        ),
        floatingActionButton: Builder(
          builder: (BuildContext context) {
            return _isCompleted
                ? FloatingActionButton(
                    backgroundColor: Colors.amber,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black87,
                    ),
                    tooltip: '다음으로',
                    onPressed: () {
                      debugPrint('value: $radioValues');
                      widget.handleScore(
                          // '${radioValues[0]}/${radioValues[1]}/${radioValues[2]}/${radioValues[3]}/${radioValues[4]}/${radioValues[5]}/${radioValues[6]}/${radioValues[7]}/${radioValues[8]}/${radioValues[9]}',
                          radioValues.join('/'),
                          widget.tag);
                      widget.toNextPage();
                    })
                : FloatingActionButton(
                    backgroundColor: Colors.grey[300],
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey[400],
                    ),
                    tooltip: '답하지 않은 문항이 있습니다',
                    onPressed: () {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('답하지 않은 문항이 있습니다.'),
                        backgroundColor: Colors.redAccent
                      ));
                    },
                  );
          },
        ),
      ),
    );
  }
}
