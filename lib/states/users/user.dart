import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../base_response.dart';
import '../../database/shared_preference.dart';
import '../../models/user.dart';

class UserRepository {
  Future<BaseResponse<SkillHunterUserInfo>> fetchUserInfo() async {
    try {
      final firebaseUser = await FirebaseFirestore.instance
          .collection('users')
          .where(
            'user_id',
            isEqualTo: LocalPreference.userID,
          )
          .get();

      final user = SkillHunterUserInfo.fromJson(firebaseUser.docs.first.data());
      return BaseResponse.success(user);
    } on FirebaseException catch (err) {
      return BaseResponse.error(message: err.message);
    } catch (err) {
      return BaseResponse.error(message: err.toString());
    }
  }

  Future<BaseResponse<SkillHunterUserInfo>> updateUser({
    required SkillHunterUserInfo user,
    XFile? profileImage,
  }) async {
    try {
      FirebaseFirestore.instance.collection('users').doc(LocalPreference.userID).update(
            user.toJson(),
          );
      if (profileImage != null) {
        await uploadImage(file: profileImage, reference: 'profile_image_url');
      }

      final firebaseUser = await FirebaseFirestore.instance
          .collection('users')
          .where('user_id', isEqualTo: LocalPreference.userID)
          .get();
      final updatedUser = SkillHunterUserInfo.fromJson(firebaseUser.docs.first.data());
      return BaseResponse.success(updatedUser);
    } on FirebaseException catch (err) {
      return BaseResponse.error(message: err.message);
    } catch (err) {
      return BaseResponse.error(message: err.toString());
    }
  }

  Future<void> uploadImage({required XFile file, required String reference}) async {
    final fileUpload = await FirebaseStorage.instance
        .ref()
        .child('users')
        .child('/$reference/${LocalPreference.userID}.${file.path.split('.').last}')
        .putFile(File(file.path));
    if (fileUpload.state == TaskState.success) {
      final imageDownloadUrl = await fileUpload.ref.getDownloadURL();
      FirebaseFirestore.instance.collection('users').doc(LocalPreference.userID).update(
        {reference: imageDownloadUrl},
      );
    }
  }
}
