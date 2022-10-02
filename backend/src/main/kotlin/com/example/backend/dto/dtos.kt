package com.example.backend.dto

class AddPostDto(val title: String, val contents: String)
class AddCommentDto(val post: Long, val contents: String)

class GetPostsDto(val posts: Map<Long, String>)
class GetPostDto(val title: String, val contents: String, val comments: List<String>)