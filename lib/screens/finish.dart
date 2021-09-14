import 'package:flutter/material.dart';
import 'package:gamehub/screens/login/finish.dart';
import 'package:gamehub/screens/login/questions.dart';
import 'package:gamehub/screens/login/second.dart';

class FinishAfter extends StatefulWidget {
  const FinishAfter({Key? key}) : super(key: key);

  @override
  _FinishAfterState createState() => _FinishAfterState();
}

class _FinishAfterState extends State<FinishAfter> {
  PageController controller = PageController(initialPage: 3);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Container(),
          Container(),
          Container(),
          FinishProfile(
            controller: controller,
          ),
          Second(pageController: controller),
          Questions(controller: controller)
        ],
      ),
    );
  }
}
