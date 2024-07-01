import 'package:first_app/register/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registration_repository/registration_repository.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const RegisterPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return RegisterBloc(
              registrationRepository:
                  RepositoryProvider.of<RegistrationRepository>(context),
            );
          },
          child: const RegisterForm(),
        ),
      ),
    );
  }
}
