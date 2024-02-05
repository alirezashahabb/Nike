import 'package:dio/dio.dart';
import 'package:flutter_application_1/common/exceptions.dart';

mixin HttpResponseValidator {
  validateResponse(Response response) {
    if (response.statusCode != 200) {
      throw AppException();
    }
  }
}
