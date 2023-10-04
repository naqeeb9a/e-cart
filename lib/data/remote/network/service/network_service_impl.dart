import 'dart:convert';
import 'package:ecart_driver/data/remote/network/client/network_client_impl.dart';
import 'package:ecart_driver/data/remote/network/response/network_response.dart';
import 'package:ecart_driver/data/remote/network/service/network_service.dart';
import 'package:ecart_driver/model/request_body.dart';
import 'package:ecart_driver/utils/constants/api_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class NetworkServiceImpl implements NetworkService {
  final _api = Get.put(NetworkClientImpl());
  //
  // @override
  // Future<ApiResponse> refreshToken({required RequestBody request}) async {
  //   late ApiResponse<SignInResponse> apiResponse;
  //   try {
  //     http.Response response = await _api.postJsonRequest(
  //         request: request, endPoint: ApiConstants.refreshToken);
  //     dynamic body = jsonDecode(response.body);
  //     String message = body["message"];
  //     if (response.statusCode == 200) {
  //       Tokens token = Tokens.fromJson(body["tokens"]);
  //       SignInResponse? user = await PreferencesHelper.getUser();
  //       user!.tokens = token;
  //       PreferencesHelper.setUser(user);
  //       apiResponse = ApiResponse.completed(user);
  //     } else {
  //       apiResponse =
  //           ApiResponse.error(body["message"] ?? "Something went wrong.");
  //     }
  //     return apiResponse;
  //   } catch (e) {
  //     printMessage(e);
  //     apiResponse = ApiResponse.error(e.toString());
  //     return apiResponse;
  //   }
  // }

  @override
  Future<ApiResponse> signUp({required RequestBody request}) async {
    late ApiResponse apiResponse;
    try {
      http.Response response = await _api.postJsonRequest(
          request: request, endPoint: ApiConstants.signUp);
      dynamic body = jsonDecode(response.body);
      String message = body["message"];
      if (response.statusCode == 409) {
        apiResponse = ApiResponse.error(message);
      } else if (response.statusCode == 201) {
        apiResponse = ApiResponse.completed(message);
      } else {
        apiResponse =
            ApiResponse.error(body["message"] ?? "Something went wrong.");
      }
      return apiResponse;
    } catch (e) {
      printMessage(e);
      apiResponse = ApiResponse.error(e.toString());
      return apiResponse;
    }
  }

  //
  // @override
  // Future<ApiResponse> signIn({required RequestBody request}) async {
  //   late ApiResponse<SignInResponse> apiResponse;
  //   try {
  //     http.Response response = await _api.postJsonRequest(
  //         request: request, endPoint: ApiConstants.signIn);
  //     if (response.statusCode == 401) {
  //       dynamic body = jsonDecode(response.body);
  //       String message = body["message"];
  //       apiResponse = ApiResponse.error(message);
  //     } else if (response.statusCode == 200) {
  //       SignInResponse signInResponse = signInResponseFromJson(response.body);
  //       if (signInResponse.user.role == "seller") {
  //         apiResponse = ApiResponse.completed(signInResponse);
  //       } else {
  //         apiResponse = ApiResponse.error(
  //             "You can't sign in this app because your role is ${signInResponse.user.role}.");
  //       }
  //     } else {
  //       apiResponse = ApiResponse.error("Something went wrong.");
  //     }
  //     return apiResponse;
  //   } catch (e) {
  //     printMessage(e);
  //     apiResponse = ApiResponse.error(e.toString());
  //     return apiResponse;
  //   }
  // }
  //
  // @override
  // Future<ApiResponse> signOut({required RequestBody request}) async {
  //   late ApiResponse<String> apiResponse;
  //   try {
  //     http.Response response = await _api.postJsonRequest(
  //         request: request, endPoint: ApiConstants.signOut);
  //     dynamic body = jsonDecode(response.body);
  //     String message = body["message"];
  //     if (response.statusCode == 401) {
  //       apiResponse = ApiResponse.error(message);
  //     } else if (response.statusCode == 200) {
  //       apiResponse = ApiResponse.completed(message);
  //     } else {
  //       apiResponse = ApiResponse.error("Something went wrong.");
  //     }
  //     return apiResponse;
  //   } catch (e) {
  //     printMessage(e);
  //     apiResponse = ApiResponse.error(e.toString());
  //     return apiResponse;
  //   }
  // }
  //
  // @override
  // Future<ApiResponse> forgotPassword({required RequestBody request}) async {
  //   late ApiResponse<String> apiResponse;
  //   try {
  //     http.Response response = await _api.postJsonRequest(
  //         request: request, endPoint: ApiConstants.forgotPassword);
  //     dynamic body = jsonDecode(response.body);
  //     String message = body["message"];
  //     if (response.statusCode == 200) {
  //       apiResponse = ApiResponse.completed(message);
  //     } else {
  //       apiResponse = ApiResponse.error("Something went wrong.");
  //     }
  //     return apiResponse;
  //   } catch (e) {
  //     printMessage(e);
  //     apiResponse = ApiResponse.error(e.toString());
  //     return apiResponse;
  //   }
  // }
  //
  // @override
  // Future<ApiResponse> changePassword({required RequestBody request}) async {
  //   late ApiResponse<String> apiResponse;
  //   try {
  //     http.Response response = await _api.patchRequest(
  //         request: request, endPoint: ApiConstants.changePassword);
  //     dynamic body = jsonDecode(response.body);
  //     if (response.statusCode == 400) {
  //       apiResponse = ApiResponse.error(
  //           body["message"] ?? body["message1"] ?? body["message2"]);
  //     } else if (response.statusCode == 200) {
  //       apiResponse = ApiResponse.completed(body["message"]);
  //     } else {
  //       apiResponse = ApiResponse.error("Something went wrong.");
  //     }
  //     return apiResponse;
  //   } catch (e) {
  //     printMessage(e);
  //     apiResponse = ApiResponse.error(e.toString());
  //     return apiResponse;
  //   }
  // }

  @override
  Future<ApiResponse> uploadImage({required RequestBody request}) async {
    late ApiResponse apiResponse;
    try {
      StreamedResponse response = await _api.multiPartRequest(
          requestBody: request, endPoint: ApiConstants.uploadImage);
      String body = await response.stream.bytesToString();
      var jsonBody = json.decode(body);
      printMessage(jsonBody);
      if (response.statusCode == 200) {
        apiResponse = ApiResponse.completed(jsonBody["medias"]);
      } else {
        apiResponse = ApiResponse.error(jsonBody["message"]);
      }
      return apiResponse;
    } catch (e) {
      printMessage(e);
      apiResponse = ApiResponse.error(e.toString());
      return apiResponse;
    }
  }

  @override
  Future<ApiResponse> uploadDocument({required RequestBody request}) async {
    late ApiResponse apiResponse;
    try {
      StreamedResponse response = await _api.multiPartRequest(
          requestBody: request,
          endPoint: "media/upload/${request.directory}/document");
      if (response.statusCode == 413) {
        apiResponse = ApiResponse.error(response.reasonPhrase);
      } else if (response.statusCode == 200) {
        String body = await response.stream.bytesToString();
        var jsonBody = json.decode(body);
        printMessage(jsonBody);
        apiResponse = ApiResponse.completed(jsonBody["medias"]);
      } else {
        String body = await response.stream.bytesToString();
        var jsonBody = json.decode(body);
        printMessage(jsonBody);
        apiResponse = ApiResponse.error(jsonBody["message"]);
      }
      return apiResponse;
    } catch (e) {
      printMessage(e);
      apiResponse = ApiResponse.error(e.toString());
      return apiResponse;
    }
  }


  printMessage(message) {
    debugPrint(
        "=   =   =   =   =   =   =   =   =   =   API Response   =   =   =   =   =   =   =   =   =   =");
    debugPrint("$message");
    debugPrint(
        "=   =   =   =   =   =   =   =   =   =   =   END    =   =   =   =   =   =   =   =   =   =   =");
  }
}
