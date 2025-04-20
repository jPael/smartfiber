import 'package:flutter/material.dart';

class Password extends StatefulWidget {
  const Password({
    super.key,
    required this.controller,
    this.label = "",
    this.hint = "",
    this.startIcon,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final Icon? startIcon;

  final String? Function(String?)? validator;

  @override
  PasswordState createState() => PasswordState();
}

class PasswordState extends State<Password> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: !showPassword,
      decoration: InputDecoration(
          label: Text(widget.label),
          hintText: widget.hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8 * 2)),
          prefixIcon: widget.startIcon,
          contentPadding: const EdgeInsets.symmetric(vertical: 4 * 2, horizontal: 4 * 4),
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              icon:
                  Icon(showPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined))),
    );
  }
}
