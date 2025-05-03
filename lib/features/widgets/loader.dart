import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 35, horizontal: 25),
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }
}
