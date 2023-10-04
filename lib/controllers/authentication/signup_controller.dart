import 'package:ecart_driver/controllers/extras/api_status_controller.dart';
import 'package:ecart_driver/controllers/extras/expection_controller.dart';
import 'package:ecart_driver/model/authentication/login_model.dart';
import 'package:ecart_driver/screens/main_screen.dart';
import 'package:ecart_driver/utils/global.dart';
import 'package:ecart_driver/utils/helping_method.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;

import '../../utils/utils.dart';

class LoginController extends GetxController {
  LoginModel? _loginModel;
  bool _loading = false;

  LoginModel? get loginModel => _loginModel;
  bool get loading => _loading;

  void setLoginModel(LoginModel loginModel) {
    _loginModel = loginModel;
  }

  void setLoading(bool loading) {
    _loading = loading;
    update();
  }

  void loginUser(BuildContext context, String email, String password) async {
    setLoading(true);
    await ExceptionService.applyTryCatch(() async {
      return await http.post(
          Uri.parse(
            "$baseUrl/auth/driver/register",
          ),
          body: {
            "email": email,
            "password": password,
          }).then((value) {
        if (value.statusCode == 200) {
          return Success(200, value.body);
        }
        return Failure(401, "username or password is incorrect");
      });
    }).then((value) {
      if (value is Success) {
        setLoginModel(
          loginModelFromJson(
            value.response as String,
          ),
        );
        Global.storageService
            .setAuthenticationModelString(value.response as String);
        setLoading(false);
        HelpingMethods()
            .openAndReplaceScreen(context: context, screen: const MainScreen());
        return;
      }
      if (value is Failure) {
        Fluttertoast.showToast(msg: value.errorResponse.toString());
        setLoading(false);
      }
    });
  }
}
