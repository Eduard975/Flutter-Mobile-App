// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
      postId: json['postId'] as String,
      postText: json['postText'] as String? ?? '',
      postImage: json['postImage'] as String? ?? '',
      posterId: json['posterId'] as String,
      errMsg: json['errMsg'] as String? ?? '',
    );

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'postText': instance.postText,
      'postImage': instance.postImage,
      'posterId': instance.posterId,
      'errMsg': instance.errMsg,
    };
