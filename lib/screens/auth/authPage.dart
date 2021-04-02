import 'package:chatapp/screens/auth/anonymousLogin.dart';
import 'package:chatapp/screens/auth/emailSignUp.dart';
import 'package:chatapp/screens/auth/emailLogin.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  var authMethod = AuthMethod.anonymous;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authenticate to Chat App'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: () {
          switch (authMethod) {
            case AuthMethod.anonymous:
              return AnonymousLogin(setAuthMethod);
            case AuthMethod.signIn:
              return EmailLogin(setAuthMethod);
            case AuthMethod.signUp:
              return EmailSignUp(setAuthMethod);
          }
        }(),
      ),
    );
  }

  void setAuthMethod(AuthMethod authM) {
    if (authM != this.authMethod)
      setState(() {
        this.authMethod = authM;
      });
  }
}

enum AuthMethod { anonymous, signIn, signUp }

InputDecoration textFieldDecoration(String? hintText) {
  return InputDecoration(
    hintText: capitalize(hintText),
  );
}

String? capitalize(String? s) {
  if (s == null) return null;
  return s[0].toUpperCase() + s.substring(1).toLowerCase();
}
