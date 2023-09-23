
import 'package:flutter/material.dart';

import 'package:my_meal/screens/capture_page.dart';
import 'package:my_meal/theme/pallete.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          Navigator.push(context, CapturePage.route());
        },
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: const EdgeInsets.only(
              bottom: 100,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Pallete.accentColor,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                )
              ]
            ),
            child: const Text(
              "Share your meal",
              style: TextStyle(
                color: Pallete.primaryColor,
                fontFamily: "Andika",
                fontSize: 25,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
