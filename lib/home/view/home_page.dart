import 'package:first_app/authentication/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  double deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: deviceHeight(context) * 0.05,
          right: deviceWidth(context) * 0.05,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Builder(
                  builder: (context) {
                    final userId = context.select(
                      (AuthenticationBloc bloc) => bloc.state.user.name,
                    );
                    return Text('Welcome $userId!');
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(12),
                ),
                ElevatedButton(
                  child: const Text('Logout'),
                  onPressed: () {
                    context
                        .read<AuthenticationBloc>()
                        .add(AuthenticationLogoutRequested());
                  },
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
