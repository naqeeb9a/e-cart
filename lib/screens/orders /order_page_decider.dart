import 'package:ecart_driver/controllers/assigned%20orders%20/assigned_orders.dart';
import 'package:ecart_driver/screens/orders%20/delivery_map_screen.dart';
import 'package:ecart_driver/utils/helping_method.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/authentication/login_controller.dart';
import '../orders /orders_screen.dart';

class OrderPageDecider extends StatelessWidget {
  const OrderPageDecider({super.key});

  @override
  Widget build(BuildContext context) {
    checkCurrentOrders(context);
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  checkCurrentOrders(BuildContext context) {
    AssignedOrdersController assignedOrdersController = Get.find();
    LoginController loginController = Get.find();
    assignedOrdersController
        .getAssignedOrders(
            loginController.loginModel?.tokens?.accessToken ?? "")
        .then((value) {
      if (assignedOrdersController.allDriverOrdersModel?.orders?.isNotEmpty ??
          false) {
        HelpingMethods().openAndReplaceScreen(
            context: context, screen: const DeliveryMapScreen());
      } else {
        HelpingMethods().openAndReplaceScreen(
            context: context, screen: const OrdersScreen());
      }
    });
  }
}
