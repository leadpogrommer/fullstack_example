import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dto.g.dart';

@JsonSerializable()
class AddPostDto{
  final String title;
  final String contents;

  AddPostDto({
    required this.title,
    required this.contents
  });

  factory AddPostDto.fromJson(Map<String, dynamic> json) => _$AddPostDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddPostDtoToJson(this);
}

@JsonSerializable()
class AddCommentDto{
  final int post;
  final String contents;

  AddCommentDto(this.post, this.contents);


  factory AddCommentDto.fromJson(Map<String, dynamic> json) => _$AddCommentDtoFromJson(json);
  Map<String, dynamic> toJson() => _$AddCommentDtoToJson(this);
}

@JsonSerializable()
class GetPostsDto{
  final Map<int, String> posts;

  GetPostsDto(this.posts);

  factory GetPostsDto.fromJson(Map<String, dynamic> json) => _$GetPostsDtoFromJson(json);
  Map<String, dynamic> toJson() => _$GetPostsDtoToJson(this);
}

@JsonSerializable()
class GetPostDto{
  final String title;
  final String contents;
  final List<String> comments;

  GetPostDto(this.title, this.contents, this.comments);

  factory GetPostDto.fromJson(Map<String, dynamic> json) => _$GetPostDtoFromJson(json);
  Map<String, dynamic> toJson() => _$GetPostDtoToJson(this);
}