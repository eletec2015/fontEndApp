part of 'comment_bloc.dart';

class CommentState extends Equatable {
  final List<Comment> list;

  const CommentState({this.list});

  factory CommentState.initial() => CommentState(list: List<Comment>());

  CommentState copyWith({List<Comment> list, bool isLoading}) =>
      CommentState(list: list ?? this.list);

  @override
  List<Object> get props => [list];
}
