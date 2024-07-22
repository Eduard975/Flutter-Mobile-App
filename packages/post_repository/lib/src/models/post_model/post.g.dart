// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
      postId: json['postId'] as String,
      postText: json['postText'] as String? ?? '',
      postImage: json['postImage'] as String? ?? '',
      postDate: json['postDate'] as String? ?? '',
      replyTo: json['replyTo'] as String? ?? null,
      likedBy: json['likedBy'] as String? ?? null,
      posterId: json['posterId'] as String,
    );

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'postText': instance.postText,
      'postImage': instance.postImage,
      'postDate': instance.postDate,
      'replyTo': instance.replyTo,
      'likedBy': instance.likedBy,
      'posterId': instance.posterId,
    };
