package com.example.backend.controller

import com.example.backend.dto.AddCommentDto
import com.example.backend.dto.AddPostDto
import com.example.backend.dto.GetPostDto
import com.example.backend.dto.GetPostsDto
import com.example.backend.entity.CommentEntity
import com.example.backend.entity.PostEntity
import com.example.backend.repository.CommentRepository
import com.example.backend.repository.PostRepository
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import org.springframework.web.client.HttpClientErrorException.NotFound
import org.springframework.web.server.ResponseStatusException


// My creativity stopped working
@CrossOrigin()
@RestController
@RequestMapping("api")
class SomeController(val postRepo: PostRepository, val commentRepo: CommentRepository) {
    @GetMapping("posts")
    fun getPosts(): GetPostsDto{
        val posts = postRepo.findAll().map { it.id to it.title }.toMap()
        return GetPostsDto(posts)
    }

    @GetMapping("post/{id}")
    fun getPost(@PathVariable(name = "id") id: Long): GetPostDto{
        val post = postRepo.findById(id).orElseThrow{ResponseStatusException(HttpStatus.NOT_FOUND)}
        return GetPostDto(post.title, post.content, post.comments.map { it.content })
    }

    @PostMapping("post")
    fun createPost(@RequestBody post: AddPostDto){
        postRepo.save(PostEntity(title = post.title, content = post.contents, comments = emptySet()))
    }

    @PostMapping("comment")
    fun addComment(@RequestBody comment: AddCommentDto){
        val post = postRepo.findById(comment.post).orElseThrow{ResponseStatusException(HttpStatus.NOT_FOUND)}
        commentRepo.save(CommentEntity(content = comment.contents, post = post))
    }
}