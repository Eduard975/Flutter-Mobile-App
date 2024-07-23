import 'dart:math';

import 'package:authentication_repository/authentification_repository.dart';
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
    var status = context.select(
      (AuthenticationBloc bloc) => bloc.state.status,
    );
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.symmetric(
            vertical: DeviceRepository.deviceHeight(context) * 0.05,
            horizontal: DeviceRepository.deviceWidth(context) * 0.05,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {},
                style: ElevatedButton.styleFrom(
                  alignment: Alignment.centerLeft,
                ),
                child: SizedBox(
                  width: 62,
                  height: 20,
                  child: Center(
                      child: Text(
                          '${userId.substring(0, min(userId.length, 8))}${min(userId.length, 8) < 8 ? "" : "..."}')),
                ),
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
                child: const SizedBox(
                  width: 62,
                  height: 20,
                  child: Center(child: Text('Logout')),
                ),
              ),
            ],
          ),
        ),
      ),
      body: postFeed(context, userId, status),
    );
  }

  Widget postFeed(
    BuildContext context,
    String userId,
    AuthenticationStatus status,
  ) {
    if (status.name == 'authenticated') {
      return Container(
        padding: EdgeInsets.symmetric(
          vertical: DeviceRepository.deviceHeight(context) * 0.02,
          horizontal: DeviceRepository.deviceWidth(context) * 0.05,
        ),
        child: PostFeedWidget(
          userId: userId,
        ),
      );
    } else {
      return Container();
    }
  }
}
