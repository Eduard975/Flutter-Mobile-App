// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'likes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Likes _$LikesFromJson(Map<String, dynamic> json) {
  return _Likes.fromJson(json);
}

/// @nodoc
mixin _$Likes {
  List<String>? get usersThatLiked => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LikesCopyWith<Likes> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LikesCopyWith<$Res> {
  factory $LikesCopyWith(Likes value, $Res Function(Likes) then) =
      _$LikesCopyWithImpl<$Res, Likes>;
  @useResult
  $Res call({List<String>? usersThatLiked});
}

/// @nodoc
class _$LikesCopyWithImpl<$Res, $Val extends Likes>
    implements $LikesCopyWith<$Res> {
  _$LikesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? usersThatLiked = freezed,
  }) {
    return _then(_value.copyWith(
      usersThatLiked: freezed == usersThatLiked
          ? _value.usersThatLiked
          : usersThatLiked // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LikesImplCopyWith<$Res> implements $LikesCopyWith<$Res> {
  factory _$$LikesImplCopyWith(
          _$LikesImpl value, $Res Function(_$LikesImpl) then) =
      __$$LikesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String>? usersThatLiked});
}

/// @nodoc
class __$$LikesImplCopyWithImpl<$Res>
    extends _$LikesCopyWithImpl<$Res, _$LikesImpl>
    implements _$$LikesImplCopyWith<$Res> {
  __$$LikesImplCopyWithImpl(
      _$LikesImpl _value, $Res Function(_$LikesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? usersThatLiked = freezed,
  }) {
    return _then(_$LikesImpl(
      usersThatLiked: freezed == usersThatLiked
          ? _value._usersThatLiked
          : usersThatLiked // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LikesImpl extends _Likes {
  const _$LikesImpl({required final List<String>? usersThatLiked})
      : _usersThatLiked = usersThatLiked,
        super._();

  factory _$LikesImpl.fromJson(Map<String, dynamic> json) =>
      _$$LikesImplFromJson(json);

  final List<String>? _usersThatLiked;
  @override
  List<String>? get usersThatLiked {
    final value = _usersThatLiked;
    if (value == null) return null;
    if (_usersThatLiked is EqualUnmodifiableListView) return _usersThatLiked;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Likes(usersThatLiked: $usersThatLiked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LikesImpl &&
            const DeepCollectionEquality()
                .equals(other._usersThatLiked, _usersThatLiked));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_usersThatLiked));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LikesImplCopyWith<_$LikesImpl> get copyWith =>
      __$$LikesImplCopyWithImpl<_$LikesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LikesImplToJson(
      this,
    );
  }
}

abstract class _Likes extends Likes {
  const factory _Likes({required final List<String>? usersThatLiked}) =
      _$LikesImpl;
  const _Likes._() : super._();

  factory _Likes.fromJson(Map<String, dynamic> json) = _$LikesImpl.fromJson;

  @override
  List<String>? get usersThatLiked;
  @override
  @JsonKey(ignore: true)
  _$$LikesImplCopyWith<_$LikesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
