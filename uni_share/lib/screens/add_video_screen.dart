import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uni_share/constants.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: 
      InkWell(
        onTap: () {

        },
        child: Container(
          width: 190,
          height:50,
          decoration: BoxDecoration(color:buttonColor),
          child: const Center(
            child:Text(
              'Add Video',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),

            ),
          ),
        ),
      ),
    ));
  }
}
