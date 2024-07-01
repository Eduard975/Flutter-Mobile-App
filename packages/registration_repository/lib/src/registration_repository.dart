import 'dart:async';

enum RegistrationStatus { unknown, unregistered, registered }

class RegistrationRepository {
  final _controller = StreamController<RegistrationStatus>();

  Stream<RegistrationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield RegistrationStatus.unregistered;
    yield* _controller.stream;
  }

  Future<void> register({
    required String email,
    required String username,
    required String password,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(RegistrationStatus.registered),
    );
  }

  void dispose() => _controller.close();
}
