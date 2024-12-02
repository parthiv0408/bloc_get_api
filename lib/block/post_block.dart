import'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_test/block/post_event.dart';
import 'package:interview_test/block/post_state.dart';
import 'package:interview_test/model/post_model.dart';
import 'package:interview_test/services/post_services.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostService _postService = PostService();

  PostBloc() : super(PostInitialState()) {
    on<FetchPostsEvent>(_onFetchPosts);
    on<MarkPostReadEvent>(_onMarkPostRead);
  }

  Future<void> _onFetchPosts(FetchPostsEvent event, Emitter<PostState> emit) async {
    emit(PostLoadingState());
    try {
      final posts = await _postService.fetchPosts();
      emit(PostLoadedState(posts));
    } catch (e) {
      emit(PostErrorState("Failed to load posts"));
    }
  }

  void _onMarkPostRead(MarkPostReadEvent event, Emitter<PostState> emit) {
    if (state is PostLoadedState) {
      final updatedPosts = (state as PostLoadedState).posts.map((post) {
        if (post.id == event.postId) {
          return PostModel(id: post.id, title: post.title, body: post.body);
        }
        return post;
      }).toList();
      emit(PostLoadedState(updatedPosts));
    }
  }
}
