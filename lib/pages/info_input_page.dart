import 'package:flutter/material.dart';
import 'package:ijoa/pages/info_input_views/children_input_view.dart';
import 'package:ijoa/pages/info_input_views/user_input_view.dart';

class InfoInputPage extends StatefulWidget {
  final int initialPage;

  const InfoInputPage({Key key, this.initialPage}) : super(key: key);
  @override
  _InfoInputPageState createState() => _InfoInputPageState();
}

class _InfoInputPageState extends State<InfoInputPage> {
  PageController pageController;

  void toNextPage() {
    debugPrint('info next page');
    const _duration = const Duration(milliseconds: 300);
    const _curve = Curves.ease;
    pageController.nextPage(duration: _duration, curve: _curve);
  }

  @override
  void initState() {
    // TODO: implement initState
    pageController = PageController(
      initialPage: widget.initialPage,
      keepPage: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return null;
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: PageView(
                    controller: pageController,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      UserInputView(
                        toNextPage: toNextPage,
                      ),
                      ChildrenInputView(initialPage: 0,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
