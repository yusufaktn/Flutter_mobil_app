import 'package:flutter/material.dart';

class Addprd extends StatelessWidget {
  const Addprd({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(items: [BottomNavigationBarItem(icon: Icon(Icons.add))],),


    );
  }
}
