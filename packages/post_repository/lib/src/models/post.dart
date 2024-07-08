import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  const factory Post({
    required String postId,
    @Default('') String postText,
    @Default('') String postImage,
    required String posterId,
    @Default('') String errMsg,
  }) = _Post;
  const Post._();
  static const empty = Post(
    postId: '',
    postText: '',
    postImage: '',
    posterId: '',
    errMsg: '',
  );

  bool get isEmpty => this == empty;
  bool get isNotEmpty => this != empty;
  factory Post.fromJson(Map<String, Object?> json) => _$PostFromJson(json);
}
