import 'package:device_repository/device_repository.dart';
import 'package:first_app/authentication/authentication.dart';
import 'package:first_app/post_feed/post_feed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:post_repository/post_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    final userId = context.select(
      (AuthenticationBloc bloc) => bloc.state.user.name,
    );
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.symmetric(
            vertical: DeviceRepository.deviceHeight(context) * 0.05,
            horizontal: DeviceRepository.deviceWidth(context) * 0.05,
          ),
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () async {},
                style: ElevatedButton.styleFrom(
                  alignment: Alignment.centerLeft,
                ),
                child: Text(userId),
              ),
              IconButton(
                key: const Key('newPageForm_continue_elevatedButton'),
                onPressed: () => Navigator.pushNamed(context, '/new_post'),
                icon: const Icon(Icons.add_box_outlined),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  alignment: Alignment.centerRight,
                ),
                onPressed: () {
                  context
                      .read<AuthenticationBloc>()
                      .add(AuthenticationLogoutRequested());
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: DeviceRepository.deviceHeight(context) * 0.05,
          horizontal: DeviceRepository.deviceWidth(context) * 0.05,
        ),
        child: PostFeedWidget(
          userId: userId,
        ),
      ),
    );
  }
}
