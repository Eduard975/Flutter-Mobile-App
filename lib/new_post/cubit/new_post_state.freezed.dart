// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_post_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NewPostState {
  FormzSubmissionStatus get status => throw _privateConstructorUsedError;
  PostText get postText => throw _privateConstructorUsedError;
  PostImage get postImg => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  bool get isValid => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NewPostStateCopyWith<NewPostState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewPostStateCopyWith<$Res> {
  factory $NewPostStateCopyWith(
          NewPostState value, $Res Function(NewPostState) then) =
      _$NewPostStateCopyWithImpl<$Res, NewPostState>;
  @useResult
  $Res call(
      {FormzSubmissionStatus status,
      PostText postText,
      PostImage postImg,
      String errorMessage,
      bool isValid});
}

/// @nodoc
class _$NewPostStateCopyWithImpl<$Res, $Val extends NewPostState>
    implements $NewPostStateCopyWith<$Res> {
  _$NewPostStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? postText = null,
    Object? postImg = null,
    Object? errorMessage = null,
    Object? isValid = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FormzSubmissionStatus,
      postText: null == postText
          ? _value.postText
          : postText // ignore: cast_nullable_to_non_nullable
              as PostText,
      postImg: null == postImg
          ? _value.postImg
          : postImg // ignore: cast_nullable_to_non_nullable
              as PostImage,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      isValid: null == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NewPostStateImplCopyWith<$Res>
    implements $NewPostStateCopyWith<$Res> {
  factory _$$NewPostStateImplCopyWith(
          _$NewPostStateImpl value, $Res Function(_$NewPostStateImpl) then) =
      __$$NewPostStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {FormzSubmissionStatus status,
      PostText postText,
      PostImage postImg,
      String errorMessage,
      bool isValid});
}

/// @nodoc
class __$$NewPostStateImplCopyWithImpl<$Res>
    extends _$NewPostStateCopyWithImpl<$Res, _$NewPostStateImpl>
    implements _$$NewPostStateImplCopyWith<$Res> {
  __$$NewPostStateImplCopyWithImpl(
      _$NewPostStateImpl _value, $Res Function(_$NewPostStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? postText = null,
    Object? postImg = null,
    Object? errorMessage = null,
    Object? isValid = null,
  }) {
    return _then(_$NewPostStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FormzSubmissionStatus,
      postText: null == postText
          ? _value.postText
          : postText // ignore: cast_nullable_to_non_nullable
              as PostText,
      postImg: null == postImg
          ? _value.postImg
          : postImg // ignore: cast_nullable_to_non_nullable
              as PostImage,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      isValid: null == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$NewPostStateImpl implements _NewPostState {
  const _$NewPostStateImpl(
      {this.status = FormzSubmissionStatus.initial,
      this.postText = const PostText.pure(),
      this.postImg = const PostImage.pure(),
      this.errorMessage = '',
      this.isValid = false});

  @override
  @JsonKey()
  final FormzSubmissionStatus status;
  @override
  @JsonKey()
  final PostText postText;
  @override
  @JsonKey()
  final PostImage postImg;
  @override
  @JsonKey()
  final String errorMessage;
  @override
  @JsonKey()
  final bool isValid;

  @override
  String toString() {
    return 'NewPostState(status: $status, postText: $postText, postImg: $postImg, errorMessage: $errorMessage, isValid: $isValid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewPostStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.postText, postText) ||
                other.postText == postText) &&
            (identical(other.postImg, postImg) || other.postImg == postImg) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.isValid, isValid) || other.isValid == isValid));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, status, postText, postImg, errorMessage, isValid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NewPostStateImplCopyWith<_$NewPostStateImpl> get copyWith =>
      __$$NewPostStateImplCopyWithImpl<_$NewPostStateImpl>(this, _$identity);
}

abstract class _NewPostState implements NewPostState {
  const factory _NewPostState(
      {final FormzSubmissionStatus status,
      final PostText postText,
      final PostImage postImg,
      final String errorMessage,
      final bool isValid}) = _$NewPostStateImpl;

  @override
  FormzSubmissionStatus get status;
  @override
  PostText get postText;
  @override
  PostImage get postImg;
  @override
  String get errorMessage;
  @override
  bool get isValid;
  @override
  @JsonKey(ignore: true)
  _$$NewPostStateImplCopyWith<_$NewPostStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
