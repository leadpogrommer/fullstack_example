import 'package:flutter/material.dart';
import 'package:mobile/dto/dto.dart';
import 'package:mobile/network/network.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

final network = Network();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PostsPage(),
    );
  }
}

class PostsPage extends StatefulWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  List<MapEntry<int, String>> posts = [];

  final _refreshController = RefreshController(initialRefresh: true);

  void _onRefresh() async {
    final data = await network.getPosts();
    setState(() {
      posts = data.posts.entries.toList();
    });
    _refreshController.refreshCompleted();
  }

  void _createPost() async {
    final titleController = TextEditingController();
    final contentController = TextEditingController();

    final result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Create post"),
          content: Column(
            children: [
              TextField(
                controller: titleController,
              ),
              TextField(
                controller: contentController,
                keyboardType: TextInputType.multiline,
              )
            ],
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(AddPostDto(
                    title: titleController.text,
                    contents: contentController.text,
                  ));
                },
                child: const Text("Запостить хуйню!"))
          ],
        );
      },
    );
    if (result is AddPostDto) {
      await network.addPost(result.title, result.contents);
      _refreshController.requestRefresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _createPost,
      ),
      body: SmartRefresher(
        enablePullDown: true,
        controller: _refreshController,
        onRefresh: _onRefresh,
        header: const WaterDropMaterialHeader(),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(posts[index].value),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PostPage(postId: posts[index].key))),
            );
          },
          itemCount: posts.length,
        ),
      ),
    );
  }
}

class PostPage extends StatefulWidget {
  final int postId;

  const PostPage({Key? key, required this.postId}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final _refreshController = RefreshController(initialRefresh: true);
  GetPostDto? data = null;

  @override
  void initState() {
    super.initState();
  }

  void _createComment() async {
    final contentController = TextEditingController();

    final result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Create comment"),
          content: TextField(
            controller: contentController,
            keyboardType: TextInputType.multiline,
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(contentController.text);
                },
                child: const Text("Да будет срач!"))
          ],
        );
      },
    );
    if (result is String) {
      await network.addComment(widget.postId, result);
      _refreshController.requestRefresh();
    }
  }

  void _onRefresh() async {
    final result = await network.getPost(widget.postId);
    setState(() {
      data = result;
    });
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("просмотр поста"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.comment),
        onPressed: _createComment,
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        enablePullDown: true,
        child: data == null
            ? Text("Гружу твою хуйню, жди")
            : Column(
                children: [
                  Text(data!.title),
                  Divider(),
                  Text(data!.contents),
                  Divider(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: data!.comments.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(data!.comments[index]),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
