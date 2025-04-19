import 'package:flutter/material.dart';

class CameraScanningAnimationOverlay extends StatefulWidget {
  const CameraScanningAnimationOverlay({super.key});

  @override
  State<CameraScanningAnimationOverlay> createState() => _CameraScanningAnimationOverlayState();
}

class _CameraScanningAnimationOverlayState extends State<CameraScanningAnimationOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..repeat(reverse: true);

    _animation = Tween<double>(begin: -200.0, end: 200.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Stack(children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.1)),
          ),
        ),
        Align(alignment: Alignment.center, child: scanLines()),
        Align(
            alignment: Alignment.center,
            child: Text(
              "Analyzing, please wait...",
              style: TextStyle(fontSize: 8 * 4, color: Colors.white, fontWeight: FontWeight.w500),
            ))
      ]),
    );
  }

  Widget scanLines() {
    return AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _animation.value),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 2,
              decoration: BoxDecoration(
                color: HSLColor.fromColor(Theme.of(context).colorScheme.primary)
                    .withLightness(0.6)
                    .withSaturation(1)
                    .toColor(),
                boxShadow: [
                  BoxShadow(
                    color: HSLColor.fromColor(Theme.of(context).colorScheme.primary)
                        .withLightness(0.6)
                        .withSaturation(1)
                        .toColor(),
                    blurRadius: 20,
                    spreadRadius: 1,
                    offset: Offset(0, 0),
                  ),
                  BoxShadow(
                    color: HSLColor.fromColor(Theme.of(context).colorScheme.primary)
                        .withLightness(0.6)
                        .withSaturation(1)
                        .toColor(),
                    blurRadius: 40,
                    spreadRadius: 5,
                    offset: Offset(0, 0),
                  ),
                  BoxShadow(
                    color: HSLColor.fromColor(Theme.of(context).colorScheme.primary)
                        .withLightness(0.6)
                        .withSaturation(1)
                        .toColor(),
                    blurRadius: 60,
                    spreadRadius: 10,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
