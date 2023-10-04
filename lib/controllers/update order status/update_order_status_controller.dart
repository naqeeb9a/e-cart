import 'package:ecart_driver/controllers/extras/api_status_controller.dart';
import 'package:ecart_driver/controllers/extras/expection_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../screens/orders /delivery_map_screen.dart';
import '../../utils/helping_method.dart';
import '../../utils/utils.dart';

class UpdateOrderStatusController extends GetxController {
  bool _loading = false;

  bool get loading => _loading;

  void setLoading(bool loading) {
    _loading = loading;
    update();
  }

  Future updateOrder(
    BuildContext context,
    String? accessToken,
    String? orderId,
    Object? body,
  ) async {
    setLoading(true);
    await ExceptionService.applyTryCatch(() async {
      return await http
          .patch(
              Uri.parse(
                "$baseUrl/order/$orderId",
              ),
              headers: {"Authorization": "Bearer $accessToken"},
              body: body)
          .then((value) {
        if (value.statusCode == 200) {
          return Success(200, value.body);
        }
        return Failure(401, "unable to update orders");
      });
    }).then((value) {
      if (value is Success) {
        Fluttertoast.showToast(msg: "Order status updated successfully !!");
        HelpingMethods()
            .openScreen(context: context, screen: const DeliveryMapScreen());
      }
      if (value is Failure) {
        Fluttertoast.showToast(msg: value.errorResponse.toString());
      }
      setLoading(false);
    });
  }
}
