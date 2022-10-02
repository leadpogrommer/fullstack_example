package com.example.backend.repository

import com.example.backend.entity.CommentEntity
import com.example.backend.entity.PostEntity
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query

interface CommentRepository: JpaRepository<CommentEntity, Long> {
    fun findAllByPostOrderById(post: PostEntity): List<CommentEntity>
}