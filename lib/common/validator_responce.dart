import 'package:dio/dio.dart';
import 'package:flutter_application_1/common/exception.dart';

 mixin class Validator{
   validatorResponse(Response response){
if(response.statusCode != 200){
 throw AppException();
}

}
}
