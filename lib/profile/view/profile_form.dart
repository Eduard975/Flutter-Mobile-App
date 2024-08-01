import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';

// import 'dart:developer' as developer;

class ProfileForm extends StatelessWidget {
  final User user;
  const ProfileForm({
    required this.user,
    super.key,
  });
  //TODO: Add options for users to edit their profile
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state.status == FormzSubmissionStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('N-am putut modifica datele'),
              ),
            );
        } else if (state.status == FormzSubmissionStatus.success) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Te-ai editat 10/10'),
              ),
            );
        }
      },
      child: Container(
        alignment: Alignment.center,
        constraints: const BoxConstraints(
          minHeight: 130,
          maxHeight: 350,
        ),
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 225, 229, 252),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Flex(
          direction: Axis.vertical,
          verticalDirection: VerticalDirection.down,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 24.0),
            FutureBuilder(
              future: getImageUrl(user.photoUrl),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Icon(Icons.error);
                } else {
                  return displayProfileImage(snapshot.data!);
                }
              },
            ),
            const SizedBox(height: 16.0),
            Text(user.name),
            const Text('Descriere type beat')
          ],
        ),
      ),
    );
  }

  Future<String?> getImageUrl(String? photoUrl) async {
    if (photoUrl == null) {
      await FirebaseStorage.instance
          .ref()
          .child('ProfileImages/defaultUserPhoto.png')
          .getDownloadURL()
          .then(
        (urlFirebase) {
          photoUrl = urlFirebase;
        },
      );
    }
    return photoUrl;
  }

  Widget displayProfileImage(String photoUrl) {
    return ClipOval(
      child: Image.network(
        photoUrl,
        height: 200.0,
        width: 200.0,
        fit: BoxFit.cover,
      ),
    );
  }
}
