import "package:firebase_auth/firebase_auth.dart";
import "package:google_sign_in/google_sign_in.dart";

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<User?> signInWithGoogle() async {
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

  if (googleSignInAccount == null) {
    return null;
  }

  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final OAuthCredential credential = GoogleAuthProvider.credential(
    idToken: googleSignInAuthentication.idToken,
    accessToken: googleSignInAuthentication.accessToken,
  );

  final UserCredential authResult = await _auth.signInWithCredential(
    credential,
  );

  final User? user = authResult.user;

  assert(user != null);
  assert(!user!.isAnonymous);

  final User? currentUser = _auth.currentUser;
  assert(currentUser != null);
  assert(currentUser!.uid == user!.uid);

  return user;
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();
  await _auth.signOut();
}
