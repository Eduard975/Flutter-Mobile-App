// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Post _$PostFromJson(Map<String, dynamic> json) {
  return _Post.fromJson(json);
}

/// @nodoc
mixin _$Post {
  String get postId => throw _privateConstructorUsedError;
  String get postText => throw _privateConstructorUsedError;
  String get postImage => throw _privateConstructorUsedError;
  String get postDate => throw _privateConstructorUsedError;
  String? get replyTo => throw _privateConstructorUsedError;
  String? get likedBy => throw _privateConstructorUsedError;
  String get posterId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostCopyWith<Post> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostCopyWith<$Res> {
  factory $PostCopyWith(Post value, $Res Function(Post) then) =
      _$PostCopyWithImpl<$Res, Post>;
  @useResult
  $Res call(
      {String postId,
      String postText,
      String postImage,
      String postDate,
      String? replyTo,
      String? likedBy,
      String posterId});
}

/// @nodoc
class _$PostCopyWithImpl<$Res, $Val extends Post>
    implements $PostCopyWith<$Res> {
  _$PostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
    Object? postText = null,
    Object? postImage = null,
    Object? postDate = null,
    Object? replyTo = freezed,
    Object? likedBy = freezed,
    Object? posterId = null,
  }) {
    return _then(_value.copyWith(
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      postText: null == postText
          ? _value.postText
          : postText // ignore: cast_nullable_to_non_nullable
              as String,
      postImage: null == postImage
          ? _value.postImage
          : postImage // ignore: cast_nullable_to_non_nullable
              as String,
      postDate: null == postDate
          ? _value.postDate
          : postDate // ignore: cast_nullable_to_non_nullable
              as String,
      replyTo: freezed == replyTo
          ? _value.replyTo
          : replyTo // ignore: cast_nullable_to_non_nullable
              as String?,
      likedBy: freezed == likedBy
          ? _value.likedBy
          : likedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      posterId: null == posterId
          ? _value.posterId
          : posterId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostImplCopyWith<$Res> implements $PostCopyWith<$Res> {
  factory _$$PostImplCopyWith(
          _$PostImpl value, $Res Function(_$PostImpl) then) =
      __$$PostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String postId,
      String postText,
      String postImage,
      String postDate,
      String? replyTo,
      String? likedBy,
      String posterId});
}

/// @nodoc
class __$$PostImplCopyWithImpl<$Res>
    extends _$PostCopyWithImpl<$Res, _$PostImpl>
    implements _$$PostImplCopyWith<$Res> {
  __$$PostImplCopyWithImpl(_$PostImpl _value, $Res Function(_$PostImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
    Object? postText = null,
    Object? postImage = null,
    Object? postDate = null,
    Object? replyTo = freezed,
    Object? likedBy = freezed,
    Object? posterId = null,
  }) {
    return _then(_$PostImpl(
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      postText: null == postText
          ? _value.postText
          : postText // ignore: cast_nullable_to_non_nullable
              as String,
      postImage: null == postImage
          ? _value.postImage
          : postImage // ignore: cast_nullable_to_non_nullable
              as String,
      postDate: null == postDate
          ? _value.postDate
          : postDate // ignore: cast_nullable_to_non_nullable
              as String,
      replyTo: freezed == replyTo
          ? _value.replyTo
          : replyTo // ignore: cast_nullable_to_non_nullable
              as String?,
      likedBy: freezed == likedBy
          ? _value.likedBy
          : likedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      posterId: null == posterId
          ? _value.posterId
          : posterId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostImpl extends _Post {
  const _$PostImpl(
      {required this.postId,
      this.postText = '',
      this.postImage = '',
      this.postDate = '',
      this.replyTo = null,
      this.likedBy = null,
      required this.posterId})
      : super._();

  factory _$PostImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostImplFromJson(json);

  @override
  final String postId;
  @override
  @JsonKey()
  final String postText;
  @override
  @JsonKey()
  final String postImage;
  @override
  @JsonKey()
  final String postDate;
  @override
  @JsonKey()
  final String? replyTo;
  @override
  @JsonKey()
  final String? likedBy;
  @override
  final String posterId;

  @override
  String toString() {
    return 'Post(postId: $postId, postText: $postText, postImage: $postImage, postDate: $postDate, replyTo: $replyTo, likedBy: $likedBy, posterId: $posterId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostImpl &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.postText, postText) ||
                other.postText == postText) &&
            (identical(other.postImage, postImage) ||
                other.postImage == postImage) &&
            (identical(other.postDate, postDate) ||
                other.postDate == postDate) &&
            (identical(other.replyTo, replyTo) || other.replyTo == replyTo) &&
            (identical(other.likedBy, likedBy) || other.likedBy == likedBy) &&
            (identical(other.posterId, posterId) ||
                other.posterId == posterId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, postId, postText, postImage,
      postDate, replyTo, likedBy, posterId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostImplCopyWith<_$PostImpl> get copyWith =>
      __$$PostImplCopyWithImpl<_$PostImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostImplToJson(
      this,
    );
  }
}

abstract class _Post extends Post {
  const factory _Post(
      {required final String postId,
      final String postText,
      final String postImage,
      final String postDate,
      final String? replyTo,
      final String? likedBy,
      required final String posterId}) = _$PostImpl;
  const _Post._() : super._();

  factory _Post.fromJson(Map<String, dynamic> json) = _$PostImpl.fromJson;

  @override
  String get postId;
  @override
  String get postText;
  @override
  String get postImage;
  @override
  String get postDate;
  @override
  String? get replyTo;
  @override
  String? get likedBy;
  @override
  String get posterId;
  @override
  @JsonKey(ignore: true)
  _$$PostImplCopyWith<_$PostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
