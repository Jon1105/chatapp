import 'package:chatapp/screens/auth/authPage.dart';
import 'package:chatapp/services/auth/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnonymousLogin extends StatefulWidget {
  final void Function(AuthMethod) authMethodSetter;
  AnonymousLogin(this.authMethodSetter);

  @override
  _AnonymousLoginState createState() => _AnonymousLoginState();
}

class _AnonymousLoginState extends State<AnonymousLogin> {
  final nameController = TextEditingController();

  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: nameController,
          decoration: textFieldDecoration('username'),
        ),
        ElevatedButton(
          onPressed: () async {
            String name = nameController.text.trim();

            if (name.isEmpty)
              return setState(() => errorText = 'username is required');
            if (name.length < 3)
              return setState(
                  () => errorText = 'username should be at least 3 characters');

            try {
              await context.read<Auth>().signInAnonymously(name);
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
                  onPressed: () => widget.authMethodSetter(AuthMethod.signIn),
                  child: Text('Sign in with email')),
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
