
import 'package:ecart_driver/data/remote/network/response/network_response.dart';
import 'package:ecart_driver/data/remote/network/service/network_service_impl.dart';
import 'package:ecart_driver/model/request_body.dart';
import 'package:get/get.dart';

class RemoteRepository {
  final _service = Get.put(NetworkServiceImpl());

  Future<ApiResponse> signUp({required RequestBody request}) async {
    final response = await _service.signUp(request: request);
    return response;
  }
  //
  // Future<ApiResponse> refreshToken({required RequestBody request}) async {
  //   final response = await _service.refreshToken(request: request);
  //   return response;
  // }
  //
  // Future<ApiResponse> signIn({required RequestBody request}) async {
  //   final response = await _service.signIn(request: request);
  //   return response;
  // }
  //
  //
  // Future<ApiResponse> signOut({required RequestBody request}) async {
  //   final response = await _service.signOut(request: request);
  //   return response;
  // }
  //
  // Future<ApiResponse> changePassword({required RequestBody request}) async {
  //   final response = await _service.changePassword(request: request);
  //   return response;
  // }
  //
  // Future<ApiResponse> forgotPassword({required RequestBody request}) async {
  //   final response = await _service.forgotPassword(request: request);
  //   return response;
  // }

  Future<ApiResponse> uploadImage({required RequestBody request}) async {
    final response = await _service.uploadImage(request: request);
    return response;
  }

  Future<ApiResponse> uploadDocument({required RequestBody request}) async {
    final response = await _service.uploadDocument(request: request);
    return response;
  }


}
