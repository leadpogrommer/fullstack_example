// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddPostDto _$AddPostDtoFromJson(Map<String, dynamic> json) => AddPostDto(
      title: json['title'] as String,
      contents: json['contents'] as String,
    );

Map<String, dynamic> _$AddPostDtoToJson(AddPostDto instance) =>
    <String, dynamic>{
      'title': instance.title,
      'contents': instance.contents,
    };

AddCommentDto _$AddCommentDtoFromJson(Map<String, dynamic> json) =>
    AddCommentDto(
      json['post'] as int,
      json['contents'] as String,
    );

Map<String, dynamic> _$AddCommentDtoToJson(AddCommentDto instance) =>
    <String, dynamic>{
      'post': instance.post,
      'contents': instance.contents,
    };

GetPostsDto _$GetPostsDtoFromJson(Map<String, dynamic> json) => GetPostsDto(
      (json['posts'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(int.parse(k), e as String),
      ),
    );

Map<String, dynamic> _$GetPostsDtoToJson(GetPostsDto instance) =>
    <String, dynamic>{
      'posts': instance.posts.map((k, e) => MapEntry(k.toString(), e)),
    };

GetPostDto _$GetPostDtoFromJson(Map<String, dynamic> json) => GetPostDto(
      json['title'] as String,
      json['contents'] as String,
      (json['comments'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$GetPostDtoToJson(GetPostDto instance) =>
    <String, dynamic>{
      'title': instance.title,
      'contents': instance.contents,
      'comments': instance.comments,
    };
