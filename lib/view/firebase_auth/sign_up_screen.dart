import 'dart:io';
import 'dart:math';

import 'package:firebaseall/common/image_upload.dart';
import 'package:firebaseall/common/text.dart';
import 'package:firebaseall/common/text_field.dart';
import 'package:firebaseall/const.dart';
import 'package:firebaseall/controller/image_controller.dart';
import 'package:firebaseall/service/sign_in_with_email.dart';
import 'package:firebaseall/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // const SignInScreen({Key? key}) : super(key: key);
  final picker = ImagePicker();
  File? image;

  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();

  final TextEditingController _username = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future setImage() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(
        () {
          image = File(pickedImage.path);
        },
      );
    }
  }

  ImageController imageController = Get.put(ImageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setImage();
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    color: Colors.grey.shade300,
                    child: image == null
                        ? const Icon(Icons.camera_alt)
                        : Image.file(
                            image!,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TsField(
                  hintText: 'Email',
                  validator: (value) {},
                  controller: _email,
                  hide: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                TsField(
                  hintText: 'UserName',
                  validator: (value) {},
                  controller: _username,
                  hide: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                TsField(
                  hintText: 'Password',
                  validator: (value) {},
                  controller: _password,
                  hide: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      String? imageUrl = await uploaddImage(
                          image!, '${Random().nextInt(1000)}');
                      bool? status = await EmailAuth.emailSignUp(
                          _email.text, _password.text);
                      if (status == true) {
                        storage.write('email', _email.text);
                        collectionReference
                            .doc(firebaseAuth.currentUser?.uid)
                            .set(
                          {
                            'emailId': _email.text,
                            'password': _password.text,
                            'username': _username.text,
                            'image': imageUrl
                          },
                        ).whenComplete(
                          () => Get.off(
                            () => const HomeScreen(),
                          ),
                        );
                      }
                    },
                    child: Ts(
                      text: 'SignUp',
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
