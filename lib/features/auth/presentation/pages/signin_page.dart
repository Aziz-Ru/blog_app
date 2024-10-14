import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
  static route() => MaterialPageRoute(builder: (context) => const SignInPage());

  @override
  State<SignInPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome back to',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'BlogCutter',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              AuthField(
                hintText: 'Email',
                controller: emailController,
              ),
              const SizedBox(height: 15),
              AuthField(
                hintText: 'Password',
                controller: passwordController,
                isObscureText: true,
              ),
              const SizedBox(height: 15),
              AuthGradientButton(buttonText: 'Sign In', onPressed: () {}),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, SignupPage.route());
                },
                child: RichText(
                  text: TextSpan(
                      text: 'Don\'t have an account? ',
                      style: Theme.of(context).textTheme.titleMedium,
                      children: [
                        TextSpan(
                            text: ' Sign Up',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppPallete.gradient2))
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
