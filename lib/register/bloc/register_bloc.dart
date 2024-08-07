import 'package:bloc/bloc.dart';
import 'package:registration_repository/registration_repository.dart';
import 'package:formz/formz.dart';
import 'package:equatable/equatable.dart';
import 'package:first_app/register/register.dart';
import 'package:first_app/models/models.dart';
import 'dart:developer' as developer;
part 'register_event.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({
    required RegistrationRepository registrationRepository,
  })  : _registrationRepository = registrationRepository,
        super(const RegisterState()) {
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterUsernameChanged>(_onUsernameChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterSubmitted>(_onSubmitted);
  }

  final RegistrationRepository _registrationRepository;

  void _onEmailChanged(
    RegisterEmailChanged event,
    Emitter<RegisterState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email, state.username, state.password]),
      ),
    );
    developer.log(
      '''
      My param:$email\n
      Email: ${state.email}\n
      Username:${state.username}\n
      Password:${state.password}''',
      name: 'LOG email change',
    );
  }

  void _onUsernameChanged(
    RegisterUsernameChanged event,
    Emitter<RegisterState> emit,
  ) {
    final username = Username.dirty(event.username);
    emit(
      state.copyWith(
        username: username,
        isValid: Formz.validate([state.email, username, state.password]),
      ),
    );
    developer.log(
      '''
      My param:$username\n
      Email: ${state.email}\n
      Username:${state.username}\n
      Password:${state.password}''',
      name: 'LOG username change',
    );
  }

  void _onPasswordChanged(
    RegisterPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([state.email, state.username, password]),
      ),
    );
    developer.log(
      '''
      My param:$password\n
      Email: ${state.email}\n
      Username:${state.username}\n
      Password:${state.password}''',
      name: 'LOG pass change',
    );
  }

  Future<void> _onSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    developer.log(
      '''
          State: ${state.isValid}
          Email: ${state.email}\n
          Username:${state.username}\n
          Password:${state.password}''',
      name: 'LOG submit values',
    );
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _registrationRepository.register(
          email: state.email.value,
          name: state.username.value,
          password: state.password.value,
        );

        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } on RegisterWithEmailAndPasswordFailure catch (e) {
        emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
          errMsg: e.message,
        ));
      }
    }
  }
}
