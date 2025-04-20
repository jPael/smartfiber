import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  const DatePicker(
      {super.key,
      this.selectedDate,
      required this.firstDate,
      required this.lastDate,
      this.label = "",
      this.hint = "",
      required this.onChange,
      this.validator,
      required this.readonly});

  final DateTime? selectedDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final String label;
  final String hint;
  final void Function(DateTime) onChange;
  final String? Function(String?)? validator;
  final bool readonly;

  @override
  DatePickerState createState() => DatePickerState();
}

class DatePickerState extends State<DatePicker> {
  late TextEditingController dateController;

  @override
  void initState() {
    super.initState();
    dateController = TextEditingController(
      text:
          widget.selectedDate != null ? DateFormat("MMMM d, y").format(widget.selectedDate!) : null,
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    if (widget.readonly) return;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.selectedDate,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
    );

    if (picked != null && picked != widget.selectedDate) {
      setState(() {
        dateController.text = DateFormat("MMMM d, y").format(picked);
      });
      widget.onChange(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextFormField(
        readOnly: true,
        validator: widget.validator,
        controller: dateController,
        decoration: InputDecoration(
          label: Text(widget.label),
          hintText: widget.hint,
          prefixIcon: Icon(Icons.date_range_outlined, color: Theme.of(context).colorScheme.primary),
          suffixIcon: IconButton(
            onPressed: () => _selectDate(context),
            icon: Icon(Icons.edit_outlined, color: Theme.of(context).colorScheme.primary),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}
