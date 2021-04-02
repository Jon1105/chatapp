import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String text;
  String senderUid;
  List<String> seenByUids;
  bool edited;
  DocumentReference? ref;
  DateTime time;

  Message(
      {required this.text,
      required this.senderUid,
      required this.ref,
      DateTime? time,
      this.edited = false,
      this.seenByUids = const []})
      : this.time = time ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      "text": this.text,
      "senderUid": this.senderUid,
      "seenByUids": this.seenByUids,
      "edited": this.edited,
      "time": Timestamp.fromDate(this.time)
    };
  }

  static Message? fromMap(Map<String, dynamic>? map, DocumentReference ref) {
    String? text = map?['text'];
    String? senderUid = map?['senderUid'];
    if (text == null || senderUid == null) return null;

    dynamic mapSeenByUids = map?['seenByUids'];
    List<String> seenByUids;
    if (mapSeenByUids is List<String>)
      seenByUids = mapSeenByUids;
    else
      seenByUids = [];

    var mapTime = map?['time'];
    Timestamp ntime = mapTime is Timestamp ? mapTime : Timestamp.now();

    return Message(
        text: text,
        senderUid: senderUid,
        ref: ref,
        edited: map?['edited'] ?? false,
        seenByUids: seenByUids,
        time: ntime.toDate());
  }
}
