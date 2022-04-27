import 'package:flutter/material.dart';

import '../common/text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Ts(
            text: 'LogOut',
          ),
        ),
      ),
    );
  }
}
