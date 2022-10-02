package com.example.backend.entity

import org.hibernate.annotations.Type
import javax.persistence.*


@Entity(name = "comments")
class CommentEntity (
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: Long = 0,


    @Column(name = "content")
    @Type(type = "text")
    var content: String,

    @ManyToOne()
    @JoinColumn(name = "post")
    var post: PostEntity,
    )