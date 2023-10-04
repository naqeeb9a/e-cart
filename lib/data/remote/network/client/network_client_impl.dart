import 'dart:async';
import 'dart:convert';
import 'package:ecart_driver/data/remote/network/client/network_client.dart';
import 'package:ecart_driver/data/remote/network/client/network_exception.dart';
import 'package:ecart_driver/model/request_body.dart';
import 'package:ecart_driver/utils/constants/api_constants.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NetworkClientImpl implements NetworkClient {
  @override
  Future postJsonRequest({
    required RequestBody request,
    required String endPoint,
  }) async {
    dynamic responseJson;
    try {
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": 'Bearer ${request.authToken}',
      };
      Uri uri = Uri.parse(ApiConstants.baseUrl + endPoint);
      http.Response response = await http
          .post(
            uri,
            headers: headers,
            body: jsonEncode(request.body),
          )
          .timeout(const Duration(seconds: 60));
      responseJson = response;
      printMessage(response.body);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }on TimeoutException{
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getJsonRequest({
    required RequestBody request,
    required String endPoint,
  }) async {
    dynamic responseJson;
    try {
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": 'Bearer ${request.authToken}',
      };
      Uri uri = Uri.parse(ApiConstants.baseUrl + endPoint);
      if (request.parameters != null) {
        uri = uri.replace(queryParameters: request.parameters);
      }
      http.Response response = await http
          .get(
            uri,
            headers: headers,
          )
          .timeout(const Duration(seconds: 60));
      responseJson = response;
      printMessage(response.body);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException{
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future patchRequest({
    required RequestBody request,
    required String endPoint,
  }) async {
    dynamic responseJson;
    try {
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": 'Bearer ${request.authToken}',
      };
      Uri uri = Uri.parse(ApiConstants.baseUrl + endPoint);
      http.Response response = await http
          .patch(uri, headers: headers, body: jsonEncode(request.body))
          .timeout(const Duration(seconds: 60));
      responseJson = response;
      printMessage(response.body);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }on TimeoutException{
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future deleteRequest({
    required RequestBody request,
    required String endPoint,
  }) async {
    dynamic responseJson;
    try {
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": 'Bearer ${request.authToken}',
      };
      Uri uri = Uri.parse(
          "${ApiConstants.baseUrl}$endPoint/${request.parameters!["paramKey"]}");
      http.Response response = await http
          .delete(
            uri,
            headers: headers,
          )
          .timeout(const Duration(seconds: 60));
      responseJson = response;
      printMessage(response.body);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }on TimeoutException{
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future multiPartRequest({
    required RequestBody requestBody,
    required String endPoint,
  }) async {
    dynamic responseJson;
    try {
      Uri uri = Uri.parse(ApiConstants.baseUrl + endPoint);
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          "Authorization": 'Bearer ${requestBody.authToken}',
        });
      for (int i = 0; i < requestBody.files!.length; i++) {
        request.files.add(await http.MultipartFile.fromPath(
          requestBody.files![i]["key"],
          requestBody.files![i]["filePath"],
          contentType: MediaType('image', 'png'),
        ));
      }
      var response = await request.send();
      responseJson = response;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }on TimeoutException{
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  printMessage(message) {
    if (kDebugMode) {
      print(
          "=   =   =   =   =   =   =   =   =   =   API Response   =   =   =   =   =   =   =   =   =   =");
      print("$message");
      print(
          "=   =   =   =   =   =   =   =   =   =   =   END    =   =   =   =   =   =   =   =   =   =   =");
    }
  }
}
