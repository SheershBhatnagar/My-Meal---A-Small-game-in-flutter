
import 'package:flutter/material.dart';

import 'package:my_meal/theme/pallete.dart';

class MessagePage extends StatelessWidget {

  static route() => MaterialPageRoute(builder: (context) => const MessagePage());

  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Text(
          "GOOD JOB",
          style: TextStyle(
            color: Pallete.accentColor,
            fontFamily: "LilitaOne",
            fontSize: 48,
          ),
        ),
      ),
    );
  }
}

