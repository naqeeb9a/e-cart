import 'dart:io';

import 'package:ecart_driver/data/remote/network/response/network_response.dart';
import 'package:ecart_driver/data/repository/auth_repo.dart';
import 'package:ecart_driver/model/request_body.dart';
import 'package:ecart_driver/screens/authentication/signin_screen.dart';
import 'package:ecart_driver/utils/constants/app_constants.dart';
import 'package:get/get.dart';

class AuthViewModel extends GetxController {
  RxBool visible = false.obs;
  RxBool showPassword = true.obs;
  RxBool showConfirmPassword = true.obs;
  final _service = Get.put(AuthRepositoryImpl());
  Rx<File>? userImage = File("").obs;
  RxList documents = [
    {"title": AppConstants.driverPermit, "file": File("")},
    {"title": AppConstants.certifiedCopy, "file": File("")},
    {"title": AppConstants.certificateOfCharacter, "file": File("")},
    {"title": AppConstants.insurance, "file": File("")},
    {"title": AppConstants.vehicleImage, "file": File("")},
    {"title": AppConstants.proofOfAddress, "file": File("")},
  ].obs;
  RxBool rememberMe = false.obs;
  //
  // @override
  // void onInit() {
  //   fetchToken();
  //   super.onInit();
  // }

  fetchToken() {
    // Future.delayed(const Duration(seconds: 1)).then((value) async {
    //   visible.value = !visible.value;
    // });
    Get.off(() => const SignInScreen());
  }

  // Future<ApiResponse> refreshToken({required RequestBody request}) async {
  //   return await _service.refreshToken(request: request);
  // }

  Future<ApiResponse> signUpAccount({required RequestBody request}) async {
    return await _service.signUp(request: request);
  }
  //
  // Future<ApiResponse> signInAccount({required RequestBody request}) async {
  //   return await _service.signIn(request: request);
  // }
  //
  // Future<ApiResponse> changePassword({required RequestBody request}) async {
  //   return await _service.changePassword(request: request);
  // }
  //
  // Future<ApiResponse> forgotPassword({required RequestBody request}) async {
  //   return await _service.forgotPassword(request: request);
  // }
  //
  // Future<ApiResponse> signOut({required RequestBody request}) async {
  //   return await _service.signOut(request: request);
  // }

  Future<ApiResponse> uploadImage({required RequestBody request}) async {
    return await _service.uploadImage(request: request);
  }

  Future<ApiResponse> uploadDocument({required RequestBody request}) async {
    return await _service.uploadDocument(request: request);
  }

  resetSignUp() {
    documents = [
      {"title": AppConstants.driverPermit, "file": File("")},
      {"title": AppConstants.certifiedCopy, "file": File("")},
      {"title": AppConstants.certificateOfCharacter, "file": File("")},
      {"title": AppConstants.insurance, "file": File("")},
      {"title": AppConstants.vehicleImage, "file": File("")},
      {"title": AppConstants.proofOfAddress, "file": File("")},
    ].obs;
    userImage = File("").obs;
  }
}
