
import 'package:ecart_driver/model/request_body.dart';

abstract class NetworkClient {

  Future postJsonRequest({
    required RequestBody request,
    required String endPoint,
  });

  Future getJsonRequest({
    required RequestBody request,
    required String endPoint,
  });

  Future multiPartRequest({
    required RequestBody requestBody,
    required String endPoint,
  });

  Future patchRequest({
    required RequestBody request,
    required String endPoint,
  });

  Future deleteRequest({
    required RequestBody request,
    required String endPoint,
  });

}
