import 'package:flutter/material.dart';
import 'package:smartfiber/components/recent_item.dart';

class Recents extends StatelessWidget {
  const Recents({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recents",
          style: TextStyle(fontSize: 8 * 3, fontWeight: FontWeight.w600),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: 8,
              itemBuilder: (context, index) => RecentItem(
                    index: index.toString(),
                    label: "Sample Image",
                    createdAt: DateTime.now().toString(),
                  )),
        )
      ],
    );
  }
}
