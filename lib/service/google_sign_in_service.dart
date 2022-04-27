import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseall/const.dart';
import 'package:google_sign_in/google_sign_in.dart';

String? email;
String? image;
String? name;

Future signInGoogle() async {
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication? googleSignInAuthentication =
      await googleSignInAccount!.authentication;
  final OAuthCredential authCredential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication?.accessToken,
      idToken: googleSignInAuthentication?.idToken);
  UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(authCredential);
  User? user = userCredential.user;

  name = user!.displayName;
  image = user.photoURL;
  email = user.email;
}

Future signOut() async {
  await googleSignIn.signOut();
}
