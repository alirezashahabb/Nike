import 'package:flutter/material.dart';

class BadgeeItem extends StatelessWidget {
  final int value;

  const BadgeeItem({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: value > 0,
      child: Container(
        width: 18,
        height: 18,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
        ),
        child: Text(value.toString(),
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            )),
      ),
    );
  }
}
