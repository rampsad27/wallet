import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Emptyscreen extends StatelessWidget {
  const Emptyscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Empty Screen'),
      ),
    );
  }
}
