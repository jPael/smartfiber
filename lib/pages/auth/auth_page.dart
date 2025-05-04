
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartfiber/pages/auth/login_page.dart';
import 'package:smartfiber/pages/splash_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        final user = snapshot.data;

        if (user == null) {
          return const SplashPage();
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return _loadingScreen();
        }

        if (!snapshot.hasData) {
          return const LoginPage();
        }

        return const LoginPage();

        // return FutureBuilder<Map<String, dynamic>?>(
        //   future: getUserByUID(user.uid),
        //   builder: (context, userSnapshot) {
        //     if (userSnapshot.connectionState == ConnectionState.waiting) {
        //       return _loadingScreen();
        //     } else if (userSnapshot.hasError) {
        //       return Center(
        //         child: Text("Error: ${userSnapshot.error}"),
        //       );
        //     } else if (userSnapshot.hasData) {
        //       final data = userSnapshot.data!;
        //       final UserType role = getUserEnumFromUserTypeString(data[UserFields.userType]);
        //       log(data[UserFields.token].toString());

        //       WidgetsBinding.instance.addPostFrameCallback((_) {
        //         context.read<current_user.User>().setUser(data);
        //       });

        //       return role == UserType.mother ? const mother.HomeLayoutPage() : const midwife.HomeLayoutPage();
        //     } else {
        //       return const LandingPage();
        //     }
        //   },
        // );
      },
    );
  }

  Widget _loadingScreen() {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "CareNest",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            Text(
              "Please wait...",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 8),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
