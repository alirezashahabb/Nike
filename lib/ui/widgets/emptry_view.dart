import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  final String title;
  final Widget callBack;
  final Widget image;
  const EmptyView(
      {super.key,
      required this.title,
      required this.callBack,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        image,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ),
        callBack,
      ],
    );
  }
}
