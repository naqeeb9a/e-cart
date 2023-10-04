
import 'package:ecart_driver/data/remote/network/response/network_response.dart';
import 'package:ecart_driver/data/remote/remote_repo.dart';
import 'package:ecart_driver/model/request_body.dart';
import 'package:get/get.dart';

abstract class AuthRepository {
  Future<ApiResponse> signUp({required RequestBody request});

  // Future<ApiResponse> signIn({required RequestBody request});
  //
  // Future<ApiResponse> changePassword({required RequestBody request});
  //
  // Future<ApiResponse> forgotPassword({required RequestBody request});
  //
  // Future<ApiResponse> signOut({required RequestBody request});

  Future<ApiResponse> uploadImage({required RequestBody request});

  Future<ApiResponse> uploadDocument({required RequestBody request});
  // Future<ApiResponse> refreshToken({required RequestBody request});
}

class AuthRepositoryImpl extends AuthRepository {
  final _remoteRepo = Get.put(RemoteRepository());

  // @override
  // Future<ApiResponse> refreshToken({required RequestBody request}) {
  //   return _remoteRepo.refreshToken(request: request);
  // }

  @override
  Future<ApiResponse> signUp({required RequestBody request}) {
    return _remoteRepo.signUp(request: request);
  }

  @override
  Future<ApiResponse> uploadImage({required RequestBody request}) {
    return _remoteRepo.uploadImage(request: request);
  }

  @override
  Future<ApiResponse> uploadDocument({required RequestBody request}) {
    return _remoteRepo.uploadDocument(request: request);
  }
  //
  // @override
  // Future<ApiResponse> signIn({required RequestBody request}) {
  //   return _remoteRepo.signIn(request: request);
  // }
  //
  // @override
  // Future<ApiResponse> signOut({required RequestBody request}) {
  //   return _remoteRepo.signOut(request: request);
  // }
  //
  // @override
  // Future<ApiResponse> changePassword({required RequestBody request}) {
  //   return _remoteRepo.changePassword(request: request);
  // }
  //
  // @override
  // Future<ApiResponse> forgotPassword({required RequestBody request}) {
  //   return _remoteRepo.forgotPassword(request: request);
  // }
}
