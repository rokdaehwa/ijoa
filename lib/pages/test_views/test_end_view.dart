import 'package:flutter/material.dart';

class TestEndView extends StatefulWidget {
  final Function toNextPage;
  final Function setPreferences;

  TestEndView(this.toNextPage, this.setPreferences);
  @override
  _TestEndViewState createState() => _TestEndViewState();
}

class _TestEndViewState extends State<TestEndView>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    // notice: 왔다갔다하는 애니메이션임
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.forward();
    widget.setPreferences().then((v) {
      debugPrint('test end: $v');
      widget.toNextPage();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: FadeTransition(
      opacity: animation,
      child: Center(
        child: Icon(
          Icons.check,
          size: 100.0,
          color: Colors.grey,
        ),
      ),
    )));
  }
}
