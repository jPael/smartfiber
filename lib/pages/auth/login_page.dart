import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfiber/components/button/custom_button.dart';
import 'package:smartfiber/components/form/custom_form.dart';
import 'package:smartfiber/components/input/custom_input.dart';
import 'package:smartfiber/models/laravel_id.dart';
import 'package:smartfiber/pages/auth/register/register_page.dart';
import 'package:smartfiber/pages/home_layout_page.dart';
import 'package:smartfiber/pages/home_page.dart';
import 'package:smartfiber/services/laravel/user_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

// final

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool loggingIn = false;

  void handleSignin() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      loggingIn = true;
    });

    try {
      final int? result =
          await loginAccount(username: usernameController.text, password: passwordController.text);

      if (!mounted) return;

      if (result != null) {
        final laravelId = context.read<LaravelId>();
        laravelId.setId(result);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeLayoutPage()));
      } else {
        // Handle login failure (show error message, etc.)
      }
    } finally {
      if (mounted) {
        setState(() {
          loggingIn = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8 * 5),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Welcome back!",
                  style: TextStyle(fontSize: 8 * 6),
                ),
                const SizedBox(
                  height: 8 * 2,
                ),
                // Image.asset(
                //   "lib/assets/images/mother_signin_hero.png",
                //   scale: 1.8,
                // ),
                const SizedBox(
                  height: 8 * 3,
                ),
                Form(
                    key: formKey,
                    child: CustomForm(
                      actionMainAxisAlignment: MainAxisAlignment.center,
                      actions: [
                        Expanded(
                            child: CustomButton.large(
                                isLoading: loggingIn,
                                context: context,
                                label: "Sign in",
                                onPressed: handleSignin)),
                      ],
                      children: [
                        CustomInput.text(
                            context: context,
                            controller: usernameController,
                            label: "Username",
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return "Username is required";
                              }

                              return null;
                            },
                            startIcon: const Icon(Icons.email_outlined)),
                        const SizedBox(
                          height: 8 * 2,
                        ),
                        CustomInput.password(
                          context: context,
                          controller: passwordController,
                          label: "Password",
                          startIcon: const Icon(Icons.password_outlined),
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return "Password is required";
                            }
                            return null;
                          },
                        ),
                      ],
                    )),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     CustomButton.link(context: context, label: "Forgot password", onPressed: () {}),
                //     const SizedBox(
                //       height: 8 * 2,
                //     ),
                //   ],
                // ),
                const SizedBox(
                  height: 8 * 3,
                ),
                const SizedBox(
                  height: 8 * 2,
                ),
                Text("Don't have an account?"),
                CustomButton.ghost(
                    context: context,
                    label: "Register",
                    onPressed: () => Navigator.push(
                        context, MaterialPageRoute(builder: (context) => RegisterPage()))),
                // CustomButton.social(
                //   context: context,
                //   label: "Sign in with Google",
                //   onPressed: () {},
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
