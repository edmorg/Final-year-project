import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../base_response.dart';
import '../../models/authentication_entity.dart';

class AuthenticationRepository {
  Future<BaseResponse<String>> signInWithEmail({required LoginRequestData data}) async {
    try {
      final auth = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: data.email,
        password: data.password,
      );
      if (auth.user != null) {
        return BaseResponse.success(auth.user!.uid);
      } else {
        return BaseResponse.error(message: 'Sign in failed');
      }
    } on FirebaseException catch (err) {
      return BaseResponse.error(message: err.message);
    } catch (err) {
      return BaseResponse.error(message: err.toString());
    }
  }

  Future<BaseResponse<String>> registerWithEmail({required RegistrationRequestData data}) async {
    try {
      final auth = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: data.email,
        password: data.password,
      );
      if (auth.user != null) {
        FirebaseFirestore.instance.collection('users').doc(auth.user!.uid).set(
              data.toJson()..addAll({'user_id': auth.user?.uid}),
            );
        return BaseResponse.success(auth.user!.uid);
      } else {
        return BaseResponse.error(message: 'Registration failed');
      }
    } on FirebaseException catch (err) {
      return BaseResponse.error(message: err.message);
    } catch (err) {
      return BaseResponse.error(message: err.toString());
    }
  }

  Future<BaseResponse<String>> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return BaseResponse.success('User signed out successfully');
    } on FirebaseException catch (err) {
      return BaseResponse.error(message: err.message ?? "Couldn't sign out user");
    } catch (err) {
      return BaseResponse.error(message: "Couldn't sign out user");
    }
  }

  Future<BaseResponse<String>> forgotPassword({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return BaseResponse.success('User signed out successfully');
    } on FirebaseException catch (err) {
      return BaseResponse.error(message: err.message ?? "Couldn't send email");
    } catch (err) {
      return BaseResponse.error(message: "Couldn't send email");
    }
  }
}
