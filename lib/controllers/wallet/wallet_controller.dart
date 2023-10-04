import 'package:ecart_driver/controllers/authentication/login_controller.dart';
import 'package:ecart_driver/controllers/extras/api_status_controller.dart';
import 'package:ecart_driver/controllers/extras/expection_controller.dart';
import 'package:ecart_driver/model/wallet/walled_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../utils/utils.dart';

class WalletController extends GetxController {
  WalletModel? _walletModel;
  bool _loading = false;

  WalletModel? get walletModel => _walletModel;
  bool get loading => _loading;

  void setLoading(bool loading) {
    _loading = loading;
    update();
  }

  void setWalletModel(WalletModel? walletModel) {
    _walletModel = walletModel;
  }

  void getWallet() async {
    setLoading(true);
    await ExceptionService.applyTryCatch(() async {
      LoginController loginController = Get.find();
      return await http.get(
        Uri.parse(
          "$baseUrl/wallet",
        ),
        headers: {
          "Authorization":
              "Bearer ${loginController.loginModel?.tokens?.accessToken}",
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
      ).then((value) {
        if (value.statusCode == 200) {
          return Success(200, value.body);
        }
        return Failure(401, "unable to load wallet");
      });
    }).then((value) {
      if (value is Success) {
        setWalletModel(walletModelFromJson(value.response as String));
      }
      if (value is Failure) {
        Fluttertoast.showToast(msg: value.errorResponse.toString());
      }
      setLoading(false);
    });
  }
}
