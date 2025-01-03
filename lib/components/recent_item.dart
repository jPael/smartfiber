import 'package:flutter/material.dart';
import 'package:smartfiber/pages/scan_result_page.dart';

class RecentItem extends StatelessWidget {
  const RecentItem(
      {super.key,
      required this.label,
      required this.createdAt,
      required this.index});

  final String index;
  final String label;
  final String createdAt;

  @override
  Widget build(BuildContext context) {
    final String heroTag = "hero-tag-$index";

    return GestureDetector(
      onTap: () => _gotoDetailsPage(context, heroTag),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Theme.of(context).colorScheme.tertiary)),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Hero(
              tag: heroTag,
              child: Icon(
                Icons.image,
                size: 8 * 10,
              ),
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
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 8 * 2.5),
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
      ),
    );
  }

  void _gotoDetailsPage(BuildContext context, String tag) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => ScanResultPage(tag: tag),
      ),
    );
  }
}
