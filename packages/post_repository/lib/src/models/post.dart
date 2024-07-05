import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

class newPostFailure implements Exception {
  final String message;

  const newPostFailure([
    this.message = 'O eroare necunoscuta a avut loc!',
  ]);

  factory newPostFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-post':
        return const newPostFailure(
          'Postarea trebuie sa contina macar o imagine sau niste caractere.',
        );
      case 'char-limit-exceeded':
        return const newPostFailure(
          'Poti folosi maxim 200 de caractere in postare.',
        );
      case 'network-error':
        return const newPostFailure(
          'O eroare de conexiune a prevenit postarea.',
        );
      default:
        return const newPostFailure();
    }
  }
}

@freezed
class Post with _$Post {
  const factory Post({
    required String postId,
    @Default('') String postText,
    @Default('') String postImage,
    required String posterId,
  }) = _Post;
  const Post._();
  static const empty = Post(
    postId: '',
    postText: '',
    postImage: '',
    posterId: '',
  );

  bool get isEmpty => this == empty;
  bool get isNotEmpty => this != empty;
  factory Post.fromJson(Map<String, Object?> json) => _$PostFromJson(json);
}
