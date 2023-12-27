import 'package:flutter/material.dart';

class LoadingColumn extends StatelessWidget {
  final String msg;

  const LoadingColumn({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircularProgressIndicator(),
        const SizedBox(
          height: 10,
        ),
        Text(msg)
      ],
    );
  }
}
