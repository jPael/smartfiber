import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText({super.key, this.content});

  final List<Widget>? content;

  static const double titleFontSize = 28; // 4 * 7
  static const double bodyFontSize = 24; // 4 * 6

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (content != null && content!.isNotEmpty)
              ...content!.asMap().entries.map((entry) {
                final index = entry.key;
                final widget = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      widget,
                      if (index != content!.length - 1)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Icon(Icons.keyboard_double_arrow_down),
                        ),
                    ],
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }

  static Widget page({
    required BuildContext context,
    String? title,
    required List<Widget> children,
    bool centerTitle = false,
  }) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * .75,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  mainAxisAlignment:
                      centerTitle ? MainAxisAlignment.center : MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ...children.map((child) => Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: child,
                )),
          ],
        ),
      ),
    );
  }

  static Widget image(String imageSource) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: constraints.maxWidth,
              maxHeight: constraints.maxHeight * 0.5,
            ),
            child: Image.asset(
              imageSource,
              fit: BoxFit.contain,
              width: double.infinity,
            ),
          );
        },
      ),
    );
  }

  static Text paragraph(List<TextSpan> content) {
    return Text.rich(
      TextSpan(children: content),
      textAlign: TextAlign.start,
    );
  }

  static TextSpan newLine() {
    return const TextSpan(text: "\n");
  }

  static TextSpan bold(String content) {
    return TextSpan(
      text: content,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: bodyFontSize,
      ),
    );
  }

  static TextSpan text(String content) {
    return TextSpan(
      text: content,
      style: const TextStyle(
        fontSize: bodyFontSize,
      ),
    );
  }

  static TextSpan numberized(List<String> content) {
    List<InlineSpan> textContent = [];

    for (var i = 0; i < content.length; i++) {
      textContent.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.top,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 24,
                  child: Text(
                    "${i + 1}.",
                    style: const TextStyle(
                      fontSize: bodyFontSize,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    content[i],
                    style: const TextStyle(
                      fontSize: bodyFontSize,
                      color: Colors.black,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return TextSpan(
      children: textContent,
      style: const TextStyle(fontSize: bodyFontSize),
    );
  }
}
