import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartfiber/models/recent.dart';
import 'package:smartfiber/services/laravel/api_url_base.dart';

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
              child: data.path != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          height: 8 * 8,
                          width: 8 * 8,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                          clipBehavior: Clip.antiAlias,
                          child: Image.network(
                            LaravelPaths.imageUrl(data.path!),
                            fit: BoxFit.cover,
                          )),
                    )
                  : const Icon(
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
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8 * 2.5),
                  ),
                  Text(
                    DateFormat("MMMM dd, yyyy").format(data.formattedDate),
                    style: const TextStyle(fontSize: 8 * 1.5),
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
