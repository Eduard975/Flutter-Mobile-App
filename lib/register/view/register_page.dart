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
    var registrationRepository =
        RepositoryProvider.of<RegistrationRepository>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Inregistrare"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          lazy: false,
          create: (context) {
            return RegisterBloc(
              registrationRepository: registrationRepository,
            );
          },
          child: Builder(builder: (context) {
            return const RegisterForm();
          }),
        ),
      ),
    );
  }
}
