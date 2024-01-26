import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/common/exception.dart';
import 'package:flutter_application_1/data/module/coomet_module.dart';
import 'package:flutter_application_1/data/repo/coomet_repositroy.dart';

part 'comment_list_event.dart';
part 'comment_list_state.dart';

class CommentListBloc extends Bloc<CommentListEvent, CommentListState> {
  final int id;
  final ICommentRepository repository;
  CommentListBloc(this.repository, this.id) : super(CommentLoadingState()) {
    on<CommentListEvent>((event, emit) async {
      if (event is CommentStartedEvent) {
        emit(CommentLoadingState());
        try {
          final comment = await repository.getComment(id);
          emit(CommentResponseState(comments: comment));
        } catch (e) {
          emit(
            CommentErrorSate(AppException()),
          );
        }
      }
    });
  }
}
