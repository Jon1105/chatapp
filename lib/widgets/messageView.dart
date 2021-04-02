import 'package:flutter/material.dart';
import 'package:chatapp/models/message.dart';
import 'package:chatapp/widgets/messageWidget.dart';

class MessageView extends StatelessWidget {
  final List<Message?> _messages;
  final ScrollController? controller;
  MessageView(this._messages, {this.controller});
  @override
  Widget build(BuildContext context) {
    List<Message> messages = [];
    _messages.forEach((msg) {
      if (msg != null) messages.add(msg);
    });
    messages.sort((a, b) => a.time.compareTo(b.time));

    return ListView.separated(
      itemCount: messages.length,
      itemBuilder: (c, i) => MessageWidget(messages[i]),
      separatorBuilder: (_, __) => SizedBox(
        height: 10,
      ),
      controller: controller,
    );
  }
}
