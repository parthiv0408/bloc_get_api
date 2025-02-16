
import 'package:interview_test/model/post_model.dart';

abstract class PostState {}

class PostInitialState extends PostState {}

class PostLoadingState extends PostState {}

class PostLoadedState extends PostState {
  final List<PostModel> posts;

  PostLoadedState(this.posts);
}

class PostErrorState extends PostState {
  final String message;

  PostErrorState(this.message);
}
