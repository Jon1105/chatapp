import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthManagerPage extends StatefulWidget {
  @override
  _AuthManagerPageState createState() => _AuthManagerPageState();
}

class _AuthManagerPageState extends State<AuthManagerPage> {
  @override
  Widget build(BuildContext context) {
    User user = context.watch<User?>()!;
    return Container();
  }
}
