import 'package:flutter/material.dart';
import 'package:smartfiber/components/recents.dart';
import 'package:smartfiber/components/toolbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0 * 2, vertical: 8 * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Toolbar(),
            SizedBox(
              height: 8 * 4,
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Recents(),
            ))
          ],
        ),
      ),
    );
  }
}
