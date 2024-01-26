import 'package:flutter_application_1/common/http_clinet.dart';
import 'package:flutter_application_1/data/datasource/comment_datasource.dart';
import 'package:flutter_application_1/data/module/coomet_module.dart';

final comments = CommentRepository(
    dataSource: CommentRemoteDataSource(httpClient: httpClient));

abstract class ICommentRepository {
  Future<List<CommentEntity>> getComment(int id);
}

class CommentRepository implements ICommentRepository {
  final ICommentDataSource dataSource;

  CommentRepository({required this.dataSource});
  @override
  Future<List<CommentEntity>> getComment(int id) => dataSource.getComment(id);
}
