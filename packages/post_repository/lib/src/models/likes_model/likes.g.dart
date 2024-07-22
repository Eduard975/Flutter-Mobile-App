// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'likes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LikesImpl _$$LikesImplFromJson(Map<String, dynamic> json) => _$LikesImpl(
      usersThatLiked: (json['usersThatLiked'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$LikesImplToJson(_$LikesImpl instance) =>
    <String, dynamic>{
      'usersThatLiked': instance.usersThatLiked,
    };
