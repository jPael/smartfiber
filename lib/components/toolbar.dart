import 'package:flutter/material.dart';
import 'package:smartfiber/components/toolbar_button.dart';

class Toolbar extends StatelessWidget {
  const Toolbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 8 * 2,
      runSpacing: 8 * 2,
      children: [
        ToolbarButton(
          label: "Scan",
          icon: Icons.camera_rounded,
          ontap: () {},
        ),
        ToolbarButton(
          label: "Import Image",
          icon: Icons.image,
          ontap: () {},
        ),
        ToolbarButton(
          label: "About us",
          icon: Icons.info,
          ontap: () {},
        ),
        ToolbarButton(
          label: "Model info",
          icon: Icons.account_tree_rounded,
          ontap: () {},
        ),
        ToolbarButton(
          label: "Accuracy",
          icon: Icons.check_circle_outline_rounded,
          ontap: () {},
        ),
      ],
    );
  }
}
