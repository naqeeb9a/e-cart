import 'package:ecart_driver/controllers/authentication/login_controller.dart';
import 'package:ecart_driver/controllers/extras/api_status_controller.dart';
import 'package:ecart_driver/controllers/extras/expection_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../model/transaction/transaction_model.dart';
import '../../utils/utils.dart';

class TransactionController extends GetxController {
  TransactionModel? _transactionModel;
  bool _loading = false;

  TransactionModel? get transactionModel => _transactionModel;
  bool get loading => _loading;

  void setLoading(bool loading) {
    _loading = loading;
    update();
  }

  void setTransactionModel(TransactionModel? transactionModel) {
    _transactionModel = transactionModel;
  }

  void getTransaction() async {
    setLoading(true);
    await ExceptionService.applyTryCatch(() async {
      LoginController loginController = Get.find();
      return await http.get(
        Uri.parse(
          "$baseUrl/transactions",
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
        return Failure(401, "unable to load transactions");
      });
    }).then((value) {
      if (value is Success) {
        setTransactionModel(transactionModelFromJson(value.response as String));
      }
      if (value is Failure) {
        Fluttertoast.showToast(msg: value.errorResponse.toString());
      }
      setLoading(false);
    });
  }
}
