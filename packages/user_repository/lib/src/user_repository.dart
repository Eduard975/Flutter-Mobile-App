import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
//import 'dart:developer' as developer;

import 'package:user_repository/user_repository.dart';

class UserRepository {
  UserRepository();

  Future<void> updateUserProfile({
    required User user,
    String? newProfileImg,
    String? newUserDescription,
    String? newUsername,
  }) async {
    try {
      User userToModify = User.empty;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.id)
          .get()
          .then((userSnapshot) => {
                if (userSnapshot.data() == null)
                  {
                    throw Exception('Utilizatorul nu exista'),
                  },
                userToModify = User.fromJson(userSnapshot.data()!),
              });

      String? imgUrl;
      if (newProfileImg != null) {
        imgUrl = 'ProfileImages/${user.id}.png';
        await FirebaseStorage.instance
            .ref()
            .child(imgUrl)
            .putFile(File(newProfileImg));
      }

      if (newUsername == null) {
        throw Exception('Username nou invalids');
      }

      userToModify = userToModify.copyWith(
        photoUrl: imgUrl,
        description: newUserDescription,
        name: newUsername,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.id)
          .set(userToModify.toJson());
    } catch (e) {
      throw e;
    }
  }
}
