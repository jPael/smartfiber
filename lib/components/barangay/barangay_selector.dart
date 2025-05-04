import 'package:flutter/material.dart';
import 'package:smartfiber/services/laravel/user_services.dart';
// import 'package:smartfiber/services/laravel/barangay_services.dart';

class BarangaySelector extends StatefulWidget {
  const BarangaySelector({
    super.key,
    required this.onChange,
  });

  final Function(String? value) onChange;

  @override
  BarangaySelectorState createState() => BarangaySelectorState();
}

class BarangaySelectorState extends State<BarangaySelector> {
  String defaultValue = "";
  bool fetchingBarangay = false;
  List<String> barangays = [];

  Future<void> _fetchBarangay() async {
    setState(() {
      fetchingBarangay = true;
    });

    // await Future.delayed(Duration(seconds: 3));
    final fetchedBarangays = await fetchAllBarangays();

    setState(() {
      defaultValue = fetchedBarangays.first;
      widget.onChange(defaultValue);
      barangays = fetchedBarangays;
    });

    setState(() {
      fetchingBarangay = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _fetchBarangay();
  }

  @override
  Widget build(BuildContext context) {
    return fetchingBarangay
        ? const Row(
            spacing: 4 * 2,
            children: [
              SizedBox.square(
                dimension: 4 * 6,
                child: CircularProgressIndicator(),
              ),
              Text("Fetching barangay")
            ],
          )
        : DropdownButtonFormField(
            menuMaxHeight: MediaQuery.of(context).size.height * 0.6,
            decoration: InputDecoration(
              labelText: "Barangay",
              hintText: "Select your barangay",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8 * 2),
              ),
            ),
            value: defaultValue,
            onChanged: (value) {
              widget.onChange(value as String);
              setState(() {
                defaultValue = value;
              });
            },
            items: barangays.map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(),
            validator: (value) {
              if (value == null) {
                return "Please select your barangay";
              }
              return null;
            },
          );
  }
}
