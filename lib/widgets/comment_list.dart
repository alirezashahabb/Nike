import 'package:flutter/material.dart';

import 'package:flutter_application_1/bloc/comment/comment_list_bloc.dart';
import 'package:flutter_application_1/common/style.dart';
import 'package:flutter_application_1/data/module/coomet_module.dart';

import 'package:flutter_application_1/data/repo/coomet_repositroy.dart';
import 'package:flutter_application_1/screen/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// this class for Comment Section
///
class CommentList extends StatelessWidget {
  final int id;
  const CommentList({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = CommentListBloc(comments, id);
        bloc.add(CommentStartedEvent());
        return bloc;
      },
      child: BlocBuilder<CommentListBloc, CommentListState>(
        builder: (context, state) {
          if (state is CommentLoadingState) {
            return const SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is CommentResponseState) {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: state.comments.length,
                (context, index) =>
                    CommentItems(comments: state.comments[index]),
              ),
            );
          } else if (state is CommentErrorSate) {
            return SliverToBoxAdapter(
              child: AppErrorWidget(
                exception: state.exception,
                onTap: () {},
              ),
            );
          } else {
            throw Exception('stat is not support');
          }
        },
      ),
    );
  }
}

/// this is for comment Items
class CommentItems extends StatelessWidget {
  final CommentEntity comments;
  const CommentItems({
    super.key,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: LightThemeColors.secondaryTextColor,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// comment title and data
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(comments.title),
                Text(
                  comments.data,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),

            /// comment
            Text(
              comments.email,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(comments.content)
          ],
        ),
      ),
    );
  }
}
