import 'package:flutter/material.dart';
import 'package:chatapp/screens/auth/authPage.dart';
import 'package:provider/provider.dart';
import 'package:chatapp/services/auth/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailLogin extends StatefulWidget {
  final void Function(AuthMethod) authMethodSetter;
  EmailLogin(this.authMethodSetter);

  @override
  _EmailLoginState createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          decoration: textFieldDecoration('email'),
          controller: emailController,
        ),
        TextField(
          decoration: textFieldDecoration('password'),
          obscureText: true,
          controller: passwordController,
        ),
        ElevatedButton(
          onPressed: () async {
            String email = emailController.text.trim();
            String password = passwordController.text;

            try {
              await context.read<Auth>().signInWithEmail(email, password);
            } on FirebaseAuthException catch (e) {
              return setState(() => errorText = e.code);
            }
          },
          child: Text('SUBMIT'),
        ),
        if (errorText != null && errorText!.isNotEmpty)
          Text(
            errorText!,
            style: TextStyle(color: Theme.of(context).errorColor),
          ),
        Row(
          children: [
            Expanded(
              child: TextButton(
                  onPressed: () =>
                      widget.authMethodSetter(AuthMethod.anonymous),
                  child: Text('Sign in without email')),
            ),
            Expanded(
              child: TextButton(
                  onPressed: () => widget.authMethodSetter(AuthMethod.signUp),
                  child: Text('Sign up with email')),
            ),
          ],
        )
      ],
    );
  }
}
