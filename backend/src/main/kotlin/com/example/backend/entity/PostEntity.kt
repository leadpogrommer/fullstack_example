package com.example.backend.entity

//import org.hibernate.annotations.
import org.hibernate.annotations.Type
import javax.persistence.*


@Entity
@Table(name = "posts")
class PostEntity(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: Long = 0,

    @Column(name = "title")
    var title: String,

    @Column(name = "content")
    @Type(type="text")
    var content: String,

    @OneToMany(mappedBy = "post", targetEntity = CommentEntity::class)
    var comments: Set<CommentEntity>

)
