import 'dart:convert';

import 'package:ecart_driver/controllers/authentication/login_controller.dart';
import 'package:ecart_driver/controllers/extras/api_status_controller.dart';
import 'package:ecart_driver/controllers/extras/expection_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../utils/utils.dart';

class WalletWithdrawController extends GetxController {
  bool _loading = false;

  bool get loading => _loading;

  void setLoading(bool loading) {
    _loading = loading;
    update();
  }

  void withdrawAmount(Object? body) async {
    setLoading(true);
    await ExceptionService.applyTryCatch(() async {
      LoginController loginController = Get.find();
      return await http
          .post(
        Uri.parse(
          "$baseUrl/wallet/withdraw",
        ),
        headers: {
          "Authorization":
              "Bearer ${loginController.loginModel?.tokens?.accessToken}",
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: jsonEncode(body),
      )
          .then((value) {
        if (value.statusCode == 200) {
          return Success(200, value.body);
        }
        return Failure(
          401,
          "unable to add request for withdraw",
        );
      });
    }).then((value) {
      if (value is Success) {
        Fluttertoast.showToast(msg: "Withdraw requested successfully");
      }
      if (value is Failure) {
        Fluttertoast.showToast(msg: value.errorResponse.toString());
      }
      setLoading(false);
    });
  }
}
