import 'package:freezed_annotation/freezed_annotation.dart';

part 'likes.freezed.dart';
part 'likes.g.dart';

@freezed
class Likes with _$Likes {
  const factory Likes({
    required List<String> usersThatLiked,
  }) = _Likes;
  const Likes._();
  static const empty = Likes(
    usersThatLiked: [],
  );

  bool get isEmpty => this == empty;
  bool get isNotEmpty => this != empty;
  factory Likes.fromJson(Map<String, Object?> json) => _$LikesFromJson(json);
}
