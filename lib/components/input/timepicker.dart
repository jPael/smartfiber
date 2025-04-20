import 'package:flutter/material.dart';

class Timepicker extends StatelessWidget {
  const Timepicker(
      {super.key,
      required this.onChange,
      required this.selectedTime,
      this.label = "",
      this.hint = ""});

  final Function(TimeOfDay) onChange;
  final TimeOfDay selectedTime;
  final String label;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final TimeOfDay? picked = await showTimePicker(context: context, initialTime: selectedTime);

        if (picked != null && picked != selectedTime) {
          onChange(picked);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          alignLabelWithHint: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8 * 2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(selectedTime.format(context)),
            const Icon(Icons.access_time),
          ],
        ),
      ),
    );
  }
}
