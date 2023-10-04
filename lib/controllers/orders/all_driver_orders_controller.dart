import 'package:ecart_driver/controllers/extras/api_status_controller.dart';
import 'package:ecart_driver/controllers/extras/expection_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

import '../../model/orders/order_model.dart';
import '../../utils/utils.dart';

class AllDriverOrdersController extends GetxController {
  AllDriverOrdersModel? _allDriverOrdersModel;
  final List<OrderDatum?> _selectedOrder = [];
  bool _loading = false;

  AllDriverOrdersModel? get allDriverOrdersModel => _allDriverOrdersModel;
  List<OrderDatum?> get selectedOrder => _selectedOrder;
  bool get loading => _loading;

  void setAllDriverOrdersModel(AllDriverOrdersModel allDriverOrdersModel) {
    _allDriverOrdersModel = allDriverOrdersModel;
  }

  void addSelectOrder(OrderDatum? selectedOrder) {
    _selectedOrder.add(selectedOrder);
    update();
  }

  void deleteSelectOrder(OrderDatum? selectedOrder) {
    _selectedOrder.remove(selectedOrder);
    update();
  }

  void setLoading(bool loading) {
    _loading = loading;
    update();
  }

  void getAllDriverOrders(String? accessToken) async {
    setLoading(true);
    await ExceptionService.applyTryCatch(() async {
      return await Location.instance.getLocation().then((location) async {
        double? lng = location.longitude;
        double? lat = location.latitude;
        if (kDebugMode) {
          lng = 74.31;
          lat = 31.561920;
        }
        return await http.get(
            Uri.parse(
              "$baseUrl/order/driver?latitude=$lat&longitude=$lng&distance=10000&isDelivered=false",
            ),
            headers: {"Authorization": "Bearer $accessToken"}).then((value) {
          if (value.statusCode == 200) {
            return Success(200, value.body);
          }
          return Failure(401, "username or password is incorrect");
        });
      });
    }).then((value) {
      if (value is Success) {
        setAllDriverOrdersModel(
          allDriverOrdersModelFromJson(
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
