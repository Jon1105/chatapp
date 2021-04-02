import 'package:flutter/material.dart';
import 'package:chatapp/screens/auth/authPage.dart';
import 'package:provider/provider.dart';
import 'package:chatapp/services/auth/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailSignUp extends StatefulWidget {
  final void Function(AuthMethod) authMethodSetter;
  EmailSignUp(this.authMethodSetter);

  @override
  _EmailSignUpState createState() => _EmailSignUpState();
}

class _EmailSignUpState extends State<EmailSignUp> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  String? errorText;

  @override
  Widget build(BuildContext context) {
    // not using Form() and TextFormField() as I want error messages to be able to set error messages from Auth() and not have to use 2 different systems to do so
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          decoration: textFieldDecoration('username'),
          controller: nameController,
        ),
        TextField(
          decoration: textFieldDecoration('email'),
          controller: emailController,
        ),
        TextField(
          decoration: textFieldDecoration('password'),
          controller: passwordController,
          obscureText: true,
        ),
        ElevatedButton(
          onPressed: () async {
            String name = nameController.text.trim();
            String email = emailController.text.trim();
            String password = passwordController.text;

            if (name.isEmpty)
              return setState(() => errorText = 'username is required');
            if (name.length < 3)
              return setState(
                  () => errorText = 'username should be at least 3 characters');

            if (email.isEmpty)
              return setState(() => errorText = 'email is required');
            if (email.contains(' ') || !email.contains('@'))
              return setState(() => errorText = 'invalid email');

            if (password.isEmpty)
              return setState(() => errorText = 'password is required');
            if (password.length < 5)
              return setState(
                  () => errorText = 'password should be at least 5 characters');

            try {
              await context.read<Auth>().signUpWithEmail(email, password, name);
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextButton(
                  onPressed: () => widget.authMethodSetter(AuthMethod.signIn),
                  child: Text('Sign in with email')),
            ),
            Expanded(
              child: TextButton(
                  onPressed: () =>
                      widget.authMethodSetter(AuthMethod.anonymous),
                  child: Text('Sign in without email')),
            ),
          ],
        )
      ],
    );
  }
}
