import 'package:flutter/material.dart';
import 'package:interview_test/services/post_services.dart';

class PostDetailScreen extends StatelessWidget {
  final int postId;

  PostDetailScreen({required this.postId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PostService().fetchPostDetail(postId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: const Text('Loading...')),
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: const Center(child: Text('Failed to load post')),
          );
        } else {
          final post = snapshot.data!;
          return Scaffold(
            appBar: AppBar(title: Text(post.title ?? "")),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(post.body ?? ""),
            ),
          );
        }
      },
    );
  }
}
