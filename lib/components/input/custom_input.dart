import 'package:flutter/material.dart';
import 'package:smartfiber/components/input/datepicker.dart';
import 'package:smartfiber/components/input/inline_input.dart';
import 'package:smartfiber/components/input/password.dart';

class CustomInput {
  static Widget text(
      {required BuildContext context,
      bool readonly = false,
      String label = "",
      String hint = "",
      Widget? startIcon,
      String? Function(String?)? validator,
      TextEditingController? controller,
      minLines = 1,
      maxLines = 8,
      String? suffixText,
      Widget? suffixWidget}) {
    assert(maxLines >= minLines, 'maxLines must be greater than or equal to minLines');

    return TextFormField(
      readOnly: readonly,
      validator: validator,
      controller: controller,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
          suffix: suffixWidget,
          suffixText: suffixText,
          label: Text(label),
          hintText: hint,
          contentPadding: const EdgeInsets.symmetric(vertical: 4 * 2, horizontal: 4 * 4),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8 * 2)),
          prefixIcon: startIcon),
    );
  }

  static Widget password(
      {required BuildContext context,
      required TextEditingController controller,
      String label = "",
      String hint = "",
      String? Function(String?)? validator,
      Icon? startIcon}) {
    return Password(
        validator: validator,
        controller: controller,
        label: label,
        hint: hint,
        startIcon: startIcon);
  }

  static Widget inline(
      {String? label,
      TextEditingController? controller,
      String? suffixText,
      String? hint,
      bool? isNormal,
      Widget? customInput}) {
    return InlineInput(
      controller: controller,
      label: label,
      suffixText: suffixText,
      hint: hint,
      isNormal: isNormal,
      customInput: customInput,
    );
  }

  static Widget timepicker(
      {required BuildContext context,
      TimeOfDay? selectedTime,
      String label = "",
      String hint = "",
      required void Function(TimeOfDay) onChange}) {
    selectedTime ??= TimeOfDay.now();

    return GestureDetector(
      onTap: () async {
        final TimeOfDay? picked =
            await showTimePicker(context: context, initialTime: selectedTime ?? TimeOfDay.now());

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

  static Widget datepicker(
      {required BuildContext context,
      DateTime? selectedDate,
      DateTime? firstDate,
      DateTime? lastDate,
      String label = "",
      String hint = "",
      bool readonly = false,
      required void Function(DateTime) onChange,
      String? Function(String?)? validator}) {
    firstDate ??= DateTime(1900);
    lastDate ??= DateTime(3000);

    return DatePicker(
      selectedDate: selectedDate,
      firstDate: firstDate,
      lastDate: lastDate,
      onChange: onChange,
      label: label,
      hint: hint,
      validator: validator,
      readonly: readonly,
    );
  }
}
