import 'package:app/services/auth/auth_service.dart';
import 'package:app/components/my_button.dart';
import 'package:app/components/my_textfield.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  void register(BuildContext context) async {
    final authService = AuthService();
    if (_passwordController.text == _confirmPasswordController.text) {
      try {
        await authService.signUpWithEmailPassword(
          _usernameController.text,
          _emailController.text,
          _passwordController.text,
        );
      } catch (e) {
        showDialog(
          context: context, 
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    } else {
      showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          title: Text("Passwords do not match!"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.message, 
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(height: 50),

            Text(
              "Let's create an account for you",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16
              ),
            ),

            const SizedBox(height: 25),

            MyTextfield(
              hintText: "Username",
              obscureText: false,
              controller: _usernameController,
            ),
            
            const SizedBox(height: 10),

            MyTextfield(
              hintText: "Email",
              obscureText: false,
              controller: _emailController,
            ),

            const SizedBox(height: 10),

            MyTextfield(
              hintText: "Password",
              obscureText: true,
              controller: _passwordController,
            ),

            const SizedBox(height: 10),

            MyTextfield(
              hintText: "Confirm password",
              obscureText: true,
              controller: _confirmPasswordController,
            ),

            const SizedBox(height: 25),

            MyButton(
              text: "Register",
              onTap: register,
            ),

            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ) 
    );
  }
}