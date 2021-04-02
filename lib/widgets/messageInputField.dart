import 'package:flutter/material.dart';

class MessageInputField extends TextField {
  MessageInputField({
    TextEditingController? controller,
    int? maxLines,
    TextInputType? keyboardType,
    InputDecoration? decoration,
  }) : super(
            controller: controller,
            maxLines: maxLines ?? null,
            keyboardType: keyboardType ?? TextInputType.multiline,
            decoration:
                decoration ?? InputDecoration(hintText: 'Type a message'));
}
