import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logafic/data_model/user_profile_model.dart';
import 'package:logafic/routing/router_names.dart';
import 'package:logafic/widgets/loading.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Rxn<User> firebaseUser = Rxn<User>();
  Rxn<UserProfile> firestoreUser = Rxn<UserProfile>();
  bool newUser = false;
  bool isRank = false;
  bool isAdmin = false;

  @override
  void onReady() {
    ever(firebaseUser, handleAuthChanged);
    firebaseUser.bindStream(user);
    super.onReady();
  }

  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  handleAuthChanged(_firebaseUser) {
    if (_firebaseUser?.uid != null) {
      firestoreUser.bindStream(streamFirestoreUser());
    }
    if (_firebaseUser == null) {
      Get.offAllNamed(FirstRoute);
    } else {
      if (newUser == false) {
        firebaseUser.value!.emailVerified
            ? Get.offAllNamed(HomeRoute)
            : Get.offAllNamed(VerifyScreenRoute);
      } else {
        firebaseUser.value!.emailVerified
            ? Get.offAllNamed(UserInformationRoute)
            : Get.offAllNamed(VerifyScreenRoute);
      }
    }
  }

  Future<bool?> get getVerify async => _auth.currentUser!.emailVerified;

  Future<User?> get getUser async => _auth.currentUser!;

  // Firebase user a realtime stream
  Stream<User?> get user => _auth.authStateChanges();

  Stream<UserProfile> streamFirestoreUser() {
    return _db
        .doc('/users/${firebaseUser.value!.uid}')
        .snapshots()
        .map((snapshot) => UserProfile.fromMap(snapshot.data()!));
  }

  Future<UserProfile> getFirestoreUser() {
    return _db
        .doc('/users/${firebaseUser.value!.uid}')
        .get()
        .then((snapshot) => UserProfile.fromMap(snapshot.data()!));
  }

  signInWithEmailAndPassword(BuildContext context) async {
    showLoadingIndicator();
    try {
      await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      emailController.clear();
      passwordController.clear();
      hideLoadingIndicator();
    } on FirebaseAuthException catch (err) {
      hideLoadingIndicator();
      Get.snackbar('Giriş hatası', '${err.toString()}',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  registerWithEmailAndPassword(BuildContext context) async {
    try {
      showLoadingIndicator();
      await _auth
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((result) async {
        result.user!.sendEmailVerification();
        hideLoadingIndicator();
      });
    } on FirebaseAuthException catch (err) {
      hideLoadingIndicator();
      Get.snackbar('Kayıt işleminde hata oluştu.', err.message!,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  void createUserFirestore(UserProfile user, User _firebaseUser) {
    _db
        .doc('/users/${_firebaseUser.uid}')
        .set(user.toJson())
        .whenComplete(() => Get.offAllNamed(HomeRoute));
  }

  Future<void> sendPasswordResetEmail(BuildContext context) async {
    showLoadingIndicator();
    try {
      await _auth.sendPasswordResetEmail(email: emailController.text);
      hideLoadingIndicator();
      Get.snackbar('Şifreme yenileme bağlantı'.tr,
          'Şifrenizi yenilemeniz için bağlantı email adresinize gönderildi.'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 5),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    } on FirebaseAuthException catch (err) {
      hideLoadingIndicator();
      Get.snackbar('Şifre yenileme hatası'.tr, err.message!,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  Future<void> signOut() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    return _auth.signOut();
  }
}
