part of 'comment_bloc.dart';

// ignore_for_file: non_constant_identifier_names

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class CommentRefreshList extends CommentEvent {
  final int object_id;

  CommentRefreshList(this.object_id);

  @override
  List<Object> get props => [object_id];
}
