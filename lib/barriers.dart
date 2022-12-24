import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final size;
  MyBarrier({this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.green,
          border: Border.all(width: 7, color: Colors.green.shade800),
          borderRadius: BorderRadius.circular(15)),
      width: 80,
      height: size,
    );
  }
}
