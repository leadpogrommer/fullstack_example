package com.example.backend.repository

import com.example.backend.entity.PostEntity
import org.springframework.data.jpa.repository.JpaRepository

interface PostRepository: JpaRepository<PostEntity, Long> {}