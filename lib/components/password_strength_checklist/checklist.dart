import 'package:flutter/material.dart';

class Checklist extends StatelessWidget {
  const Checklist({super.key, required this.meet, required this.label});

  final String label;
  final bool meet;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        meet ? checkIcon() : wrongIcon(),
        Text(
          label,
          style: TextStyle(
              color: meet ? null : Colors.red,
              decoration: meet ? null : TextDecoration.underline,
              decorationColor: meet ? null : Colors.red),
        )
      ],
    );
  }

  Widget checkIcon() {
    return const Icon(
      Icons.check,
      color: Colors.greenAccent,
    );
  }

  Widget wrongIcon() {
    return const Icon(
      Icons.close,
      color: Colors.redAccent,
    );
  }
}
