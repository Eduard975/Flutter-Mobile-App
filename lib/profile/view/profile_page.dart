import 'package:first_app/authentication/bloc/authentication_bloc.dart';
import 'package:first_app/profile/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

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
    final user = context.select(
      (AuthenticationBloc bloc) => bloc.state.user,
    );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Profilul"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          lazy: false,
          create: (context) => ProfileCubit(context.read<UserRepository>()),
          child: ProfileForm(
            user: user,
          ),
        ),
      ),
    );
  }
}
