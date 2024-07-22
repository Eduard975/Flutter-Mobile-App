import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  const factory Post({
    required String postId,
    @Default('') String postText,
    @Default('') String postImage,
    @Default('') String postDate,
    @Default(null) String? replyTo,
    @Default(null) String? likedBy,
    required String posterId,
  }) = _Post;
  const Post._();
  static const empty = Post(
    postId: '',
    postText: '',
    postImage: '',
    postDate: '',
    replyTo: null,
    likedBy: null,
    posterId: '',
  );

  bool get isEmpty => this == empty;
  bool get isNotEmpty => this != empty;
  factory Post.fromJson(Map<String, Object?> json) => _$PostFromJson(json);
}
