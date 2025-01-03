import 'package:flutter/material.dart';

class ToolbarButton extends StatelessWidget {
  const ToolbarButton(
      {super.key,
      required this.label,
      required this.icon,
      required this.ontap});

  final String label;
  final IconData icon;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    final double buttonSize = MediaQuery.of(context).size.width / 7;
    return GestureDetector(
      onTap: ontap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.0,
                color: Theme.of(context).colorScheme.tertiary,
              ),
              borderRadius: BorderRadius.circular(8 * 3),
            ),
            child: Container(
              width: buttonSize,
              height: buttonSize,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(8 * 2)),
              child: Center(
                child: Icon(
                  icon,
                  size: buttonSize / 1.5,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8 / 2,
          ),
          Text(
            label,
            style: TextStyle(fontSize: 8 * 2, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
