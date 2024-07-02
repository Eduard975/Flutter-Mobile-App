import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String email,
  }) = _User;
  const User._();
  static const empty = User(id: '', name: '', email: '');

  bool get isEmpty => this == empty;
  bool get isNotEmpty => this != empty;
  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
