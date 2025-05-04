import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartfiber/components/button/custom_button.dart';
import 'package:smartfiber/pages/auth/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    final curve = CurvedAnimation(
      parent: _controller,
      curve: const Cubic(0.39, 0.57, 0.56, 1), // Choose any curve you like
    );

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(curve);

    Future.delayed(const Duration(seconds: 1), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        forceMaterialTransparency: true,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/splash_screen_bg.jpg"), fit: BoxFit.cover)),
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: Padding(
            padding: const EdgeInsets.only(top: 15 * 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Welcome to SmartFiber",
                  style: TextStyle(fontSize: 4 * 8, fontWeight: FontWeight.w900),
                ),
                const Text(
                  "Powered by AI Detection",
                  style: TextStyle(fontSize: 4 * 5, fontStyle: FontStyle.italic),
                ),
                const SizedBox(
                  height: 8 * 8,
                ),
                Image.asset(
                  "assets/images/smartfiber_logo.png",
                  width: MediaQuery.of(context).size.width * 0.75,
                ),
                // const SizedBox(
                //   height: 8 * 2,
                // ),
                // Text(
                //   "SmartFiber",
                //   style: TextStyle(
                //       fontSize: 8 * 5,
                //       fontWeight: FontWeight.w600,
                //       color: Theme.of(context).colorScheme.secondary),
                // ),
                const SizedBox(
                  height: 8 * 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0 * 4),
                        child: CustomButton(
                          type: CustomButtonType.secondary,
                          onPress: () => Navigator.push(
                              context, MaterialPageRoute(builder: (context) => const LoginPage())),
                          label: "Let's Start",
                          labelStyle: const TextStyle(
                              fontSize: 4 * 6, color: Colors.white, fontWeight: FontWeight.bold),
                          customButtonStyle: ButtonStyle(
                            iconColor: WidgetStateProperty.all(Colors.white),
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
                            padding: WidgetStateProperty.all(
                                const EdgeInsets.symmetric(horizontal: 8.0 * 4, vertical: 8.0 * 2)),
                          ),
                        ),
                      ),
                    ),
                  ],
                )

                // GestureDetector(
                //   onTap: () => Navigator.push(
                //       context, MaterialPageRoute(builder: (context) => const HomePage())),
                //   child: Text(
                //     "Get started",
                //     style: TextStyle(
                //         color: Theme.of(context).colorScheme.secondary,
                //         fontSize: 8 * 3,
                //         decoration: TextDecoration.underline,
                //         decorationColor: Theme.of(context).colorScheme.secondary,
                //         fontWeight: FontWeight.w600),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
