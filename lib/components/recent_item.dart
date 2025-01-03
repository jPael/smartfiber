import 'package:flutter/material.dart';

class RecentItem extends StatelessWidget {
  const RecentItem({super.key, required this.label, required this.createdAt});

  final String label;
  final String createdAt;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Theme.of(context).colorScheme.tertiary)),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Icon(
            Icons.image,
            size: 8 * 10,
          ),
          const SizedBox(
            width: 8 * 2,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  overflow: TextOverflow.fade,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 8 * 2.5),
                ),
                Text(
                  createdAt,
                  style: TextStyle(fontSize: 8 * 1.5),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
