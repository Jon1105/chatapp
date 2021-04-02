import 'package:chatapp/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Db {
  final String uid;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Db(this.uid);

  Future<String> getUsername() async {
    var snap = await _db.collection('users').doc(this.uid).get();
    return snap.data()?['name'] ?? 'anonymous';
  }

  Future<void> setUsername(String username) async {
    return _db.collection('users').doc(this.uid).set({'name': username});
  }

  Stream<List<Message?>> publicMessages() {
    return _db
        .collection('publicMessages')
        .snapshots()
        .map((QuerySnapshot snap) {
      return snap.docs
          .map<Message?>((QueryDocumentSnapshot docSnap) =>
              Message.fromMap(docSnap.data(), docSnap.reference))
          .toList();
    });
  }

  Future<Message> sendPublicMessage(Message msg) async {
    var ref = await _db.collection('publicMessages').add(msg.toMap());
    msg.ref = ref;
    return msg;
  }
}
