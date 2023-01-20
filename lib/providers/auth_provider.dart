import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges().map((user) {
    ref.read(currentUserProvider.notifier).state = user;
    return user;
  });
});

final currentUserProvider = StateProvider<User?>((ref) {
  return null;
});

class AuthProvider {
  static Future<User?> registration(
      {required String email, required String password}) async {
    try {
      EasyLoading.show(status: "Registering...");
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      EasyLoading.dismiss();

      return userCredential.user;
    } catch (e) {
      EasyLoading.showError(e.toString());

      return null;
    }
  }

  static Future<User?> login(
      {required String email, required String password}) async {
    try {
      EasyLoading.show(status: "Logging In...");
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      EasyLoading.dismiss();

      return userCredential.user;
    } catch (e) {
      EasyLoading.showError(e.toString());

      return null;
    }
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}





/// Login or registration function -> User state is changing (User?)
/// we are checking this state using authStateStreamProvider -> Loginpage or Wrapper
/// To save the currentuser globally -> We created a stateProvider -> currentUserProvider -> User? 
/// 
/// Then we can use this state provider anywhere in the app to see that any user id logged in or not! And get the UID of the current User. 