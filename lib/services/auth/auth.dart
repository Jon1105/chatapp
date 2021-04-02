import 'package:chatapp/services/db/db.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _auth;

  Auth({FirebaseAuth? firebaseAuth})
      : this._auth = firebaseAuth ?? FirebaseAuth.instance;

  Stream<User?> get userChanges => this._auth.userChanges();

  Future<User?> signInWithEmail(String email, String password) async {
    UserCredential userCredential = await this
        ._auth
        .signInWithEmailAndPassword(email: email, password: password);

    return userCredential.user;
  }

  Future<User?> signUpWithEmail(
      String email, String password, String displayName) async {
    UserCredential userCredential = await this
        ._auth
        .createUserWithEmailAndPassword(email: email, password: password);

    await this.setUsername(displayName, user: userCredential.user);
    return userCredential.user;
  }

  Future<User?> signInAnonymously(String displayName) async {
    var userCredential = await _auth.signInAnonymously();
    User? user = userCredential.user;
    if (user == null) return null;
    await this.setUsername(displayName, user: userCredential.user);
    return userCredential.user;
  }

  Future<User?> linkEmail(User user, String email, String password) async {
    var credential =
        EmailAuthProvider.credential(email: email, password: password);
    var userCredential = await user.linkWithCredential(credential);
    return userCredential.user;
  }

  Future<void> signOut() => _auth.signOut();

  Future<void> setUsername(String username, {User? user}) async {
    user ??= _auth.currentUser;
    if (user == null) return Future.value();

    Db(user.uid).setUsername(username);
    return await user.updateProfile(displayName: username);
  }
}
