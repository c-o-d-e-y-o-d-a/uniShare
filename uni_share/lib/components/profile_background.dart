import 'package:flutter/material.dart';
import 'dart:math' as math;

class ProfileBackground extends StatelessWidget {
  const ProfileBackground({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: -50,
            child: Transform.rotate(
              angle: math.pi / 4,
              child: Container(
                height: size.height * 0.60,
                width: size.height * 0.60,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Color.fromARGB(255, 211, 220, 130)),
                  borderRadius: BorderRadius.circular(152.0),
                ),
              ),
            ),
          ),
          Positioned(
            top: -90,
            child: Transform.rotate(
              angle: math.pi / 4,
              child: Container(
                height: size.height * 0.60,
                width: size.height * 0.60,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Color.fromARGB(255, 252, 245, 144)),
                  borderRadius: BorderRadius.circular(152.0),
                ),
              ),
            ),
          ),
          Positioned(
            top: -130,
            child: Transform.rotate(
              angle: math.pi / 4,
              child: Container(
                height: size.height * 0.60,
                width: size.height * 0.60,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 244, 142),
                  borderRadius: BorderRadius.circular(152.0),
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
