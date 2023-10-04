import 'dart:convert';

import 'package:ecart_driver/controllers/extras/api_status_controller.dart';
import 'package:ecart_driver/controllers/extras/expection_controller.dart';
import 'package:ecart_driver/controllers/orders/all_driver_orders_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../screens/orders /delivery_map_screen.dart';
import '../../utils/helping_method.dart';
import '../../utils/utils.dart';

class PickOrdersController extends GetxController {
  bool _loading = false;

  bool get loading => _loading;

  void setLoading(bool loading) {
    _loading = loading;
    update();
  }

  void pickOrders(BuildContext context, String? accessToken) async {
    setLoading(true);
    await ExceptionService.applyTryCatch(() async {
      AllDriverOrdersController allDriverOrdersController = Get.find();
      return await http
          .post(
              Uri.parse(
                "$baseUrl/order/pickup",
              ),
              headers: {
                "Authorization": "Bearer $accessToken",
                "Content-Type": "application/json",
                "Accept": "application/json"
              },
              body: json.encode({
                "orders": allDriverOrdersController.selectedOrder
                    .map((e) => e?.id)
                    .toList()
              }))
          .then((value) {
        if (value.statusCode == 200) {
          return Success(200, value.body);
        }
        return Failure(401, "unable to pick orders");
      });
    }).then((value) {
      if (value is Success) {
        Fluttertoast.showToast(msg: "Orders picked successfully !!");
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
