import'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_test/block/post_block.dart';
import 'package:interview_test/block/post_event.dart';
import 'package:interview_test/block/post_state.dart';
import 'package:interview_test/model/post_model.dart';
import 'package:interview_test/screens/post_detail_screen.dart';

class PostListScreen extends StatelessWidget {
  const PostListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Post List')),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PostErrorState) {
            return Center(child: Text(state.message));
          } else if (state is PostLoadedState) {
            return ListView.separated(
              itemCount: state.posts.length,
              padding: EdgeInsets.all(20),
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return PostListItem(post: post);
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 20);
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}

class PostListItem extends StatelessWidget {
  final PostModel post;

  const PostListItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(post.title ?? ""),
        subtitle: Text(post.body ?? ""),
        onTap: () {
          context.read<PostBloc>().add(MarkPostReadEvent(post.id!));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostDetailScreen(postId: post.id!),
            ),
          );
        },
      ),
    );
  }
}
