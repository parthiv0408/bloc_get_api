abstract class PostEvent {}

class FetchPostsEvent extends PostEvent {}

class MarkPostReadEvent extends PostEvent {
  final int postId;

  MarkPostReadEvent(this.postId);
}
