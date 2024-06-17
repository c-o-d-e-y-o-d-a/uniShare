import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Stat extends StatelessWidget {
  const Stat({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style:
              Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
        ),
        Text(
          NumberFormat.decimalPattern().format(value),
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(fontWeight: FontWeight.w700, color: Colors.black),
        ),
      ],
    );
  }
}
