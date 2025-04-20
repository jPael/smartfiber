import 'package:flutter/material.dart';
import 'package:smartfiber/components/password_strength_checklist/checklist.dart';

class PasswordStrengthChecklist extends StatefulWidget {
  const PasswordStrengthChecklist({
    super.key,
    required this.password,
    this.confirmPassword,
    required this.onChange,
  });

  final void Function(bool) onChange;
  final TextEditingController password;
  final TextEditingController? confirmPassword;

  @override
  PasswordStrengthChecklistState createState() => PasswordStrengthChecklistState();
}

class PasswordStrengthChecklistState extends State<PasswordStrengthChecklist> {
  Map<String, bool> passwordRequirements = {
    "minLength": false,
    "hasLowerCase": false,
    "hasUpperCase": false,
    "hasNumbers": false,
    "hasSymbols": false,
    "passwordsMatch": false,
  };

  @override
  void initState() {
    super.initState();
    widget.password.addListener(_validatePassword);
    widget.confirmPassword?.addListener(_validatePassword);
  }

  @override
  void dispose() {
    widget.password.removeListener(_validatePassword);
    widget.confirmPassword?.removeListener(_validatePassword);
    super.dispose();
  }

  void _validatePassword() {
    String password = widget.password.text;
    String confirmPassword = widget.confirmPassword?.text ?? "";

    setState(() {
      passwordRequirements["minLength"] = password.length >= 6;
      passwordRequirements["hasLowerCase"] = password.contains(RegExp(r'[a-z]'));
      passwordRequirements["hasUpperCase"] = password.contains(RegExp(r'[A-Z]'));
      passwordRequirements["hasNumbers"] = password.contains(RegExp(r'[0-9]'));
      passwordRequirements["hasSymbols"] = password.contains(RegExp(r'[_!@#\$%^&*(),.?":{}|<>]'));
      passwordRequirements["passwordsMatch"] =
          confirmPassword.isNotEmpty && password == confirmPassword;
    });

    // Notify the parent widget if all conditions are met
    bool allMet = passwordRequirements.values.every((element) => element);
    widget.onChange(allMet);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Checklist(meet: passwordRequirements["minLength"]!, label: "Minimum of 6 characters"),
        Checklist(
            meet: passwordRequirements["hasLowerCase"]!, label: "At least one lowercase letter"),
        Checklist(
            meet: passwordRequirements["hasUpperCase"]!, label: "At least one uppercase letter"),
        Checklist(meet: passwordRequirements["hasNumbers"]!, label: "At least one number"),
        Checklist(meet: passwordRequirements["hasSymbols"]!, label: "At least one symbol"),
        if (widget.confirmPassword != null)
          Checklist(meet: passwordRequirements["passwordsMatch"]!, label: "Passwords match"),
      ],
    );
  }
}
