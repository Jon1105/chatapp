import 'package:chatapp/widgets/messageInputField.dart';
import 'package:chatapp/widgets/messageView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatapp/services/db/db.dart';
import 'package:chatapp/models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PublicRoomPage extends StatefulWidget {
  @override
  _PublicRoomPageState createState() => _PublicRoomPageState();
}

class _PublicRoomPageState extends State<PublicRoomPage> {
  final textController = TextEditingController();
  final scrollController = ScrollController();

  bool sending = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Public Room'),
      ),
      body: Column(
        children: [
          Flexible(
            child: StreamBuilder<List<Message?>>(
              stream: context.read<Db>().publicMessages(),
              builder: (c, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else if (snapshot.hasData) {
                  return MessageView(snapshot.data!,
                      controller: scrollController);
                } else
                  return Center(
                    child: CircularProgressIndicator(),
                  );
              },
            ),
          ),
          Row(
            children: [
              Flexible(
                child: Container(
                  child: MessageInputField(
                    controller: textController,
                  ),
                  padding: EdgeInsets.fromLTRB(16, 0, 8, 8),
                ),
              ),
              IconButton(
                  icon: Icon(Icons.send),
                  onPressed: sending
                      ? null
                      : () {
                          if (this.mounted) setState(() => sending = true);
                          sendMessage(context).then((_) {
                            textController.clear();
                            scrollController.animateTo(
                                scrollController.position.maxScrollExtent,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.ease);
                            if (this.mounted) setState(() => sending = false);
                          });
                        })
            ],
          ),
        ],
      ),
    );
  }

  Future<void> sendMessage(BuildContext c, {String? text}) async {
    String _text = (text ?? textController.text).trimRight();
    if (_text.isEmpty) return;
    c.read<Db>().sendPublicMessage(
        Message(text: _text, senderUid: c.read<User?>()!.uid, ref: null));
  }
}
