import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfiber/components/recent_item.dart';
import 'package:smartfiber/models/laravel_id.dart';
import 'package:smartfiber/models/recent.dart';
import 'package:smartfiber/services/laravel/user_services.dart';

class Recents extends StatefulWidget {
  const Recents({super.key});

  @override
  State<Recents> createState() => _RecentsState();
}

class _RecentsState extends State<Recents> {
  List<Recent> data = [];
  bool isLoading = true;

  Future<void> fetchRecents() async {
    final LaravelId laravel = context.read<LaravelId>();

    final d = await fetchRecentByUserId(laravel.id!);

    setState(() {
      data = d;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchRecents();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recents",
          style: TextStyle(fontSize: 8 * 3, fontWeight: FontWeight.w600),
        ),
        Expanded(
          child: isLoading
              ? const Center(
                  child: SizedBox.square(
                    dimension: 8 * 4,
                    child: CircularProgressIndicator(),
                  ),
                )
              : data.isEmpty
                  ? const Center(
                      child: Text("No recents"),
                    )
                  : ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) => RecentItem(
                            data: data[index],
                          )),
        )
      ],
    );
  }
}
