import 'package:flutter/material.dart';

class AppbarDesing extends StatelessWidget {
  final String text1;
  final double space;
  const AppbarDesing({required this.text1, required this.space, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: space),
      child: Text(
        text1,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
