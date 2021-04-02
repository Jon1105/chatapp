import 'package:chatapp/screens/auth/anonymousLogin.dart';
import 'package:chatapp/screens/auth/authPage.dart';
import 'package:chatapp/screens/homePage.dart';
import 'package:chatapp/services/auth/auth.dart';
import 'package:chatapp/services/db/db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget(
      MaterialApp(
        title: 'Chat App',
        theme: ThemeData.dark(),
        home: AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return context.watch<User?>() == null ? AuthPage() : HomePage();
  }
}

class ProviderWidget extends StatelessWidget {
  final Widget child;
  ProviderWidget(this.child);
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider(create: (_) => Auth()),
          StreamProvider<User?>(
            create: (c) => c.read<Auth>().userChanges,
            initialData: null,
          ),
          Provider(
            create: (c) => Db(c.read<User?>()!.uid),
          )
        ],
        child: child,
      );
}
