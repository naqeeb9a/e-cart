import 'package:ecart_driver/controllers/extras/api_status_controller.dart';
import 'package:ecart_driver/controllers/extras/expection_controller.dart';
import 'package:ecart_driver/model/orders/assigned_order_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../utils/utils.dart';

class AssignedOrdersController extends GetxController {
  AssignedDriverOrdersModel? _allDriverOrdersModel;
  bool _loading = false;

  AssignedDriverOrdersModel? get allDriverOrdersModel => _allDriverOrdersModel;
  bool get loading => _loading;

  void setAllDriverOrdersModel(AssignedDriverOrdersModel allDriverOrdersModel) {
    _allDriverOrdersModel = allDriverOrdersModel;
  }

  void setLoading(bool loading) {
    _loading = loading;
    update();
  }

  Future getAssignedOrders(String? accessToken) async {
    setLoading(true);
    await ExceptionService.applyTryCatch(() async {
      return await http.get(
          Uri.parse(
            "$baseUrl/order/assigned",
          ),
          headers: {"Authorization": "Bearer $accessToken"}).then((value) {
        if (value.statusCode == 200) {
          return Success(200, value.body);
        }
        return Failure(401, "unable to retrieve orders");
      });
    }).then((value) {
      if (value is Success) {
        setAllDriverOrdersModel(
          assignedDriverOrdersModelFromJson(
            value.response as String,
          ),
        );
      }
      if (value is Failure) {
        Fluttertoast.showToast(msg: value.errorResponse.toString());
      }
      setLoading(false);
    });
  }
}
