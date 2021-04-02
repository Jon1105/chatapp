import 'package:chatapp/screens/publicRoomPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatapp/services/auth/auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => context.read<Auth>().signOut())
        ],
      ),
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => PublicRoomPage())),
              child: Text('Open Public Room'))
        ],
      )),
    );
  }
}
