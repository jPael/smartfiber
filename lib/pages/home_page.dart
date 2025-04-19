import 'package:flutter/material.dart';
import 'package:smartfiber/components/recents.dart';
import 'package:smartfiber/components/toolbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0 * 2, vertical: 8 * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Toolbar(),
            const SizedBox(
              height: 8 * 4,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Recents(),
            ))
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton.large(
      //   onPressed: () {},
      //   child: Icon(
      //     Icons.camera_rounded,
      //     color: Colors.white,
      //     size: 50,
      //   ),
      // ),
    );
  }
}
