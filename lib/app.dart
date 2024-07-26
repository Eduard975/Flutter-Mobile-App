import 'package:first_app/new_post/view/new_post_page.dart';
import 'package:first_app/profile/view/profile_page.dart';
import 'package:first_app/register/view/register_page.dart';
import 'package:flutter/material.dart';

import 'package:authentication_repository/authentification_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_app/authentication/authentication.dart';
import 'package:first_app/home/home.dart';

import 'package:first_app/login/login.dart';
import 'package:first_app/splash/splash.dart';
import 'package:post_repository/post_repository.dart';
import 'package:registration_repository/registration_repository.dart';

import 'package:device_repository/device_repository.dart';
import 'package:user_repository/user_repository.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthenticationRepository _authenticationRepository;
  late final RegistrationRepository _registrationRepository;
  late final PostRepository _postRepository;
  late final DeviceRepository _deviceRepository;
  late final UserRepository _userRepository;

  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthenticationRepository();
    _registrationRepository = RegistrationRepository();
    _postRepository = PostRepository();
    _deviceRepository = DeviceRepository();
    _userRepository = UserRepository();
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authenticationRepository),
        RepositoryProvider.value(value: _registrationRepository),
        RepositoryProvider.value(value: _userRepository),
        RepositoryProvider.value(value: _postRepository),
        RepositoryProvider.value(value: _deviceRepository),
      ],
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: _authenticationRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      routes: {
        '/': (context) => const SplashPage(),
        '/home': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/new_post': (context) => const NewPostPage(),
      },
      initialRoute: '/',
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushNamedAndRemoveUntil('/home', (route) => false);
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushNamedAndRemoveUntil('/login', (route) => false);
                break;
              case AuthenticationStatus.unknown:
                break;
            }
          },
          child: child,
        );
      },
    );
  }
}
