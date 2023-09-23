
import 'package:flutter/material.dart';

import 'package:my_meal/theme/pallete.dart';

class CircleButton extends StatelessWidget {

  final double height;
  final double width;
  final Icon icon;
  final VoidCallback callBack;

  const CircleButton({
    required this.height,
    required this.width,
    required this.icon,
    required this.callBack,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Pallete.accentColor,
      ),
      child: IconButton(
        onPressed: () {
          callBack();
        },
        icon: icon,
      ),
    );
  }
}
