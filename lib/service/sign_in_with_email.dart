import 'package:firebaseall/const.dart';

class EmailAuth {
  static Future<bool?> emailSignUp(String? email, String? password) async {
    await firebaseAuth
        .createUserWithEmailAndPassword(email: email!, password: password!)
        .catchError(
      (onError) {
        print('====>>>$onError');
      },
    );
    return true;
  }

  static Future<bool?> emailLogIn(String? email, String? password) async {
    await firebaseAuth
        .signInWithEmailAndPassword(email: email!, password: password!)
        .catchError(
      (onError) {
        print('====>>>$onError');
      },
    );
    return true;
  }

  static Future emailLogOut() async {
    await firebaseAuth.signOut();
  }
}
