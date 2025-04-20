import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartfiber/models/recent.dart';

class RecentItem extends StatelessWidget {
  const RecentItem({
    super.key,
    required this.data,
  });
  final Recent data;

  @override
  Widget build(BuildContext context) {
    final String heroTag = "hero-tag-${data.createdAt}";

    return GestureDetector(
      // onTap: () => _gotoDetailsPage(context, heroTag),
      child: Card(
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
                    "${data.localName} | ${data.grade} ",
                    overflow: TextOverflow.fade,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8 * 2.5),
                  ),
                  Text(
                    DateFormat("MMMM dd, yyyy").format(data.formattedDate),
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

  // void _gotoDetailsPage(BuildContext context, String tag) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute<void>(
  //       builder: (BuildContext context) => ScanResultPage(tag: tag),
  //     ),
  //   );
  // }
}
