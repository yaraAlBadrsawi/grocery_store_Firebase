// import 'package:fbtest3/screens/LoginScreen.dart';
// import 'package:fbtest3/services/FirebaseFireStoreHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/users_model.dart';
import 'FirebaseFireStoreHelper.dart';

class FirebaseAuthHelper {
  FirebaseAuthHelper._();
  static FirebaseAuthHelper firebaseAuthHelper = FirebaseAuthHelper._();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future register(Users users) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: users.email!, password: users.password!);

      //// print userCredential.user
      if(userCredential.user != null){
        print('user : ${userCredential.user}');
         FirebaseFireStoreHelper.fireStoreHelper
              .SaveUserData(users, userCredential.user!.uid);
    }} on FirebaseAuthException catch (e) {
      print(
          'register: Failed with error code: ${_getMessageFromErrorCode(e.code)}');
    } catch (e) {
      print('register: other error type: $e');
    }
  }

  Future<void> login(Users users) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: users.email!, password: users.password!);
    } on FirebaseAuthException catch (e) {
      print(
          'login: Failed with error code: ${_getMessageFromErrorCode(e.code)}');
    } catch (e) {
      print('login: other error: $e');
    }
  }

  Future<void> logout() async {
    await auth.signOut();
  }

  Future resetPassword(Users users) async {
    await auth.sendPasswordResetEmail(email: users.email!);
  }

  String _getMessageFromErrorCode(String code) {
    switch (code) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Email already used. Go to login page.";
        break;
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return "Wrong email/password combination.";
        break;
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return "No user found with this email.";
        break;
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return "User disabled.";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        return "Too many requests to log into this account.";
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        return "Server error, please try again later.";
        break;
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return "Email address is invalid.";
        break;
      default:
        return "Login failed. Please try again.";
        break;
    }
  }
}
