import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfiber/pages/splash_page.dart';
import 'package:smartfiber/provider/camera_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => CameraProvider())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF14BC23),
          secondary: const Color(0xFFFFC000),
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
    );
  }
}
