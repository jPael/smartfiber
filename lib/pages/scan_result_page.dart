import 'package:flutter/material.dart';

class ScanResultPage extends StatelessWidget {
  const ScanResultPage({super.key, required this.tag});

  final String tag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan Result"),
      ),
      body: Center(
        child: Column(
          children: [
            Hero(
              tag: tag,
              child: Icon(
                Icons.image,
                size: 8 * 30,
              ),
            ),
            Text(
              "some image",
              style: TextStyle(fontSize: 8 * 2),
            )
          ],
        ),
      ),
    );
  }
}
