import 'package:ap2/View/screens/auth/signup_screen.dart';
import 'package:ap2/View/widgets/text_input_field.dart';
import 'package:ap2/constants.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Tiktok Clone',
              style: TextStyle(
                  fontSize: 15,
                  color: kButtonColor,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Login',
              style: TextStyle(
                  fontSize: 35,
                  color: kButtonColor,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 25),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: TextInputField(
                  controller: _emailController,
                  labelText: "Email",
                  icon: Icons.email_rounded),
            ),
            SizedBox(height: 25),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: TextInputField(
                  controller: _passwordController,
                  labelText: "Password",
                  isObscure: true,
                  icon: Icons.lock_rounded),
            ),
            SizedBox(height: 30),
            Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 50,
              decoration: BoxDecoration(
                color: kButtonColor,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              child: InkWell(
                  onTap: () => authController.loginUser(_emailController.text.trim(), _passwordController.text.trim()),
                  child: const Center(
                      child: Text(
                    'Login',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ))),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(fontSize: 20),
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                        SignUpScreen()
                      ));
                    }, //TODO: HERE
                    child: Text(
                      "Register",
                      style: TextStyle(fontSize: 20, color: kButtonColor),
                    ))
              ],
            ),
            const SizedBox(height: 20),
            Text(
                      "by MIRsquared",
                      style: TextStyle(fontSize: 12, color: kButtonColor),
                    )
          ],
        ),
      ),
    );
  }
}
