import 'package:dio/dio.dart';
import 'package:flutter_application_1/common/validator_responce.dart';
import 'package:flutter_application_1/data/module/coomet_module.dart';

/// this class for CommentDataSource
abstract class ICommentDataSource {
  Future<List<CommentEntity>> getComment(int id);
}

class CommentRemoteDataSource with Validator implements ICommentDataSource {
  final Dio httpClient;

  CommentRemoteDataSource({required this.httpClient});
  @override
  Future<List<CommentEntity>> getComment(int id) async {
    Response response = await httpClient.get('comment/list?product_id=$id');
    validatorResponse(response);
    final comments = <CommentEntity>[];
    for (var element in (response.data as List)) {
      comments.add(CommentEntity.fromJson(element));
    }
    return comments;
  }
}
