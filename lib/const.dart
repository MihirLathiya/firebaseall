import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
CollectionReference collectionReference = firebaseFirestore.collection('User');

FirebaseAuth firebaseAuth = FirebaseAuth.instance;

GoogleSignIn googleSignIn = GoogleSignIn();

GetStorage storage = GetStorage();
