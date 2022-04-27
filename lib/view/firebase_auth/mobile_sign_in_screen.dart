import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseall/common/text_field.dart';
import 'package:firebaseall/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/text.dart';
import '../../const.dart';

String? verifyId;

class MobileScreen extends StatefulWidget {
  MobileScreen({Key? key}) : super(key: key);

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  final TextEditingController _mobile = TextEditingController();

  Future sendOtp() async {
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: '+91' + _mobile.text,
      codeSent: (String verificationId, int? forceResendingToken) {
        setState(() {
          verifyId = verificationId;
        });
      },
      verificationFailed: (FirebaseAuthException error) {
        Get.snackbar('Failed', '$error');
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
        print('Done');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TsField(
                hintText: 'EnterNumber',
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter Number';
                  }
                },
                controller: _mobile,
                hide: false,
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () async {
                  await sendOtp().whenComplete(
                    () => Get.to(
                      () => OtpScreen(),
                    ),
                  );
                },
                child: Ts(
                  text: 'Send Otp',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OtpScreen extends StatelessWidget {
  OtpScreen({Key? key}) : super(key: key);
  final TextEditingController _otp = TextEditingController();

  Future enterOtp() async {
    PhoneAuthCredential phoneAuthProvider = await PhoneAuthProvider.credential(
        verificationId: verifyId!, smsCode: _otp.text);
    if (phoneAuthProvider == null) {
      Get.snackbar('Empty', 'Enter OTP');
    } else {
      collectionReference
          .doc(firebaseAuth.currentUser?.uid)
          .set(
            {'number': _otp.text},
          )
          .then(
            (value) => storage.write('email', _otp.text),
          )
          .whenComplete(
            () => Get.off(
              () => const HomeScreen(),
            ),
          );
    }
    firebaseAuth.signInWithCredential(phoneAuthProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TsField(
                align: TextAlign.center,
                hintText: 'EnterOtp',
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter OTP';
                  }
                },
                controller: _otp,
                hide: false,
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () async {
                  await enterOtp();
                },
                child: Ts(
                  text: 'Send Otp',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
