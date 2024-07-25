import 'package:first_app/authentication/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_form.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
  });

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const ProfilePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userId = context.select(
      (AuthenticationBloc bloc) => bloc.state.user.name,
    );
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text("Profilul"),
        ),
        body: Container()
        // ProfileForm(
        //   userId: userId,
        // ),
        );
  }
}
