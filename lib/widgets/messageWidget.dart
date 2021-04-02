import 'package:chatapp/models/message.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatapp/services/db/db.dart';
import 'package:intl/intl.dart';

class MessageWidget extends StatefulWidget {
  final Message message;
  MessageWidget(this.message);

  @override
  _MessageWidgetState createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  String username = '...';

  @override
  void initState() {
    Db(widget.message.senderUid).getUsername().then((String value) {
      if (this.mounted) setState(() => username = value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool sender = context.watch<User?>()!.uid == widget.message.senderUid;
    var containerAlign = sender ? Alignment.centerRight : Alignment.centerLeft;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          if (sender) Expanded(child: Container()),
          Expanded(
            flex: 3,
            child: Container(
              alignment: containerAlign,
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: username + '  ',
                          style: Theme.of(context).textTheme.bodyText1),
                      TextSpan(
                          text: DateFormat.Hm().format(widget.message.time),
                          style: Theme.of(context).textTheme.caption)
                    ]),
                  ),
                  Text(widget.message.text),
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: sender
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorLight),
            ),
          ),
          if (!sender) Expanded(child: Container()),
        ],
      ),
    );
  }
}
