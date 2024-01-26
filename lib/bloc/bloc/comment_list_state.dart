part of 'comment_list_bloc.dart';

sealed class CommentListState extends Equatable {
  const CommentListState();

  @override
  List<Object> get props => [];
}

final class CommentLoadingState extends CommentListState {}

class CommentErrorSate extends CommentListState {
  final AppException exception;

  const CommentErrorSate(this.exception);
  @override
  List<Object> get props => [exception];
}

class CommentResponseState extends CommentListState {
  final List<CommentEntity> comments;

  const CommentResponseState({required this.comments});
  @override
  List<Object> get props => [comments];
}
