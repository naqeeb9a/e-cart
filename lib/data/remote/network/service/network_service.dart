
import 'package:ecart_driver/data/remote/network/response/network_response.dart';
import 'package:ecart_driver/model/request_body.dart';

abstract class NetworkService {
  // Future<ApiResponse> refreshToken({required RequestBody request});
  Future<ApiResponse> signUp({required RequestBody request});
  // Future<ApiResponse> signIn({required RequestBody request});
  // Future<ApiResponse> signOut({required RequestBody request});
  // Future<ApiResponse> forgotPassword({required RequestBody request});
  // Future<ApiResponse> changePassword({required RequestBody request});
  Future<ApiResponse> uploadImage({required RequestBody request});
  Future<ApiResponse> uploadDocument({required RequestBody request});

}
