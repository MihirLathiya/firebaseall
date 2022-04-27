import 'package:firebaseall/common/text.dart';
import 'package:firebaseall/const.dart';
import 'package:firebaseall/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../service/google_sign_in_service.dart';

class GoogleSignInService extends StatelessWidget {
  const GoogleSignInService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () async {
            await signInGoogle().then(
              (value) => storage.write('email', email),
            );
            collectionReference.doc(firebaseAuth.currentUser?.uid).set(
                {'email': email, 'name': name, 'image': image}).whenComplete(
              () => Get.off(
                () => const HomeScreen(),
              ),
            );
          },
          child: Ts(
            text: 'Google SignIn',
          ),
        ),
      ),
    );
  }
}
