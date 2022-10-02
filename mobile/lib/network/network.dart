

import 'dart:async';

import 'package:dio/dio.dart';

import '../dto/dto.dart';

class Network{
  static const _baseUrl = 'http://192.168.2.243:8080/api';
  final _dio = Dio();

  Future<GetPostsDto> getPosts() async {
    final body = await _dio.get('$_baseUrl/posts');
    return GetPostsDto.fromJson(body.data);
  }

  Future<GetPostDto> getPost(int id) async {
    final response = await _dio.get('$_baseUrl/post/$id');
    return GetPostDto.fromJson(response.data);
  }

  Future<void> addPost(String title, String content) async {
    await _dio.post('$_baseUrl/post', data: AddPostDto(title: title, contents: content).toJson());
  }

  Future<void> addComment(int post, String content) async {
    await _dio.post('$_baseUrl/comment', data: AddCommentDto(post, content));
  }
}