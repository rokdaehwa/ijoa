import 'package:flutter/material.dart';

class TestEndView extends StatefulWidget {
  final Function toNextPage;

  TestEndView(this.toNextPage);
  @override
  _TestEndViewState createState() => _TestEndViewState();
}

class _TestEndViewState extends State<TestEndView>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  Future _getTestInfo(milli) async {
    await Future.delayed(Duration(milliseconds: milli));
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    _getTestInfo(3000).then((value) {
      debugPrint('end page');
      widget.toNextPage();
    });

    // notice: 왔다갔다하는 애니메이션임
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.forward();
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
