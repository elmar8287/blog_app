elik = User.create(name: "Test user", photo: "image.jpg", bio: "Thi is  bio about Test user")

elik_post = Post.create(title: "Elik`s post", text: "This is first post and here is nothing importante", author: elik)

elik_comment = Comment.create(text: "Very nice post. Good job", author: elik, post: elik_post)

p "Recorded"
