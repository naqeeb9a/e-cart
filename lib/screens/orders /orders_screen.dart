import 'package:ecart_driver/controllers/orders/all_driver_orders_controller.dart';
import 'package:ecart_driver/controllers/pick%20orders/pick_orders.dart';
import 'package:ecart_driver/utils/constants/app_constants.dart';
import 'package:ecart_driver/utils/constants/font_constants.dart';
import 'package:ecart_driver/utils/helping_method.dart';
import 'package:ecart_driver/widgets/order_item.dart';
import 'package:ecart_driver/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../controllers/authentication/login_controller.dart';
import '../../controllers/delivered orders/delivered_orders.dart';
import '../../model/orders/order_model.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<String> _tabs = [];
  int selectedTab = 0;
  PageController? controller;
  TextEditingController searchController = TextEditingController();
  FocusNode searchNode = FocusNode();
  final HelpingMethods helpingMethods = HelpingMethods();

  @override
  void initState() {
    controller = PageController(initialPage: selectedTab);
    _tabs = [
      AppConstants.pickOrders,
      AppConstants.orderDelivered,
    ];
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: GetBuilder<AllDriverOrdersController>(
        builder: (controller) {
          if (controller.selectedOrder.isEmpty) {
            return const SizedBox.shrink();
          }
          return _buildBottom();
        },
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          AppConstants.allOrders,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: FontConstants.bold,
              color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTabs(),
          _buildPages(),
        ],
      ),
    );
  }

  Widget _buildPages() => Expanded(
          child: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildOrders(),
          _buildOrders(isDelivered: true),
        ],
      ));

  Widget _buildTabs() => SizedBox(
        height: 75,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(width: 16),
          itemCount: _tabs.length,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
            onTap: () {
              selectedTab = index;
              setState(() {});
              controller!.animateToPage(selectedTab,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease);
            },
            child: Chip(
                label: Text(_tabs[index]),
                backgroundColor: selectedTab == index
                    ? const Color(0xffE1F5E9)
                    : const Color(0xffF3F2F4),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                labelPadding: const EdgeInsets.symmetric(horizontal: 25),
                labelStyle: TextStyle(
                    color: selectedTab == index
                        ? const Color(0xff1B7575)
                        : const Color(0xff969696),
                    fontFamily: FontConstants.medium,
                    fontWeight: FontWeight.w500)),
          ),
        ),
      );
  Widget _buildOrders({bool isDelivered = false}) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                    child: textField(
                  textInputAction: TextInputAction.search,
                  hintText: AppConstants.deliveryLocation,
                  controller: searchController,
                  focusNode: searchNode,
                  isCode: true,
                  isSearch: true,
                )),
                Container(
                  height: 48,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )),
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: isDelivered
                ? allDeliveredDriverOrderListView()
                : allDriverOrderListView(),
          )
        ],
      );

  GetBuilder allDriverOrderListView() {
    return GetBuilder<AllDriverOrdersController>(
        builder: (allDriverOrdersController) {
      if (allDriverOrdersController.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: allDriverOrdersController
                .allDriverOrdersModel?.orders?.data?.length ??
            0,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 16),
        itemBuilder: (BuildContext context, int index) {
          int selectedIndex = -1;
          OrderDatum? orderDatum = allDriverOrdersController
              .allDriverOrdersModel?.orders?.data?[index];
          if (allDriverOrdersController.selectedOrder.contains(orderDatum) ==
              true) {
            selectedIndex = 1;
          }
          return GestureDetector(
              onTap: () {
                if (allDriverOrdersController.selectedOrder
                        .contains(orderDatum) ==
                    true) {
                  return allDriverOrdersController
                      .deleteSelectOrder(orderDatum);
                }
                if (allDriverOrdersController.selectedOrder.length < 3) {
                  allDriverOrdersController.addSelectOrder(orderDatum);
                } else {
                  Fluttertoast.showToast(
                      msg: "You can only pick three orders at a time");
                }
              },
              child: orderItem(orderDatum, selectedIndex: selectedIndex));
        },
      );
    });
  }

  GetBuilder allDeliveredDriverOrderListView() {
    return GetBuilder<AllDeliveredDriverOrdersController>(
        builder: (allDriverOrdersController) {
      if (allDriverOrdersController.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (allDriverOrdersController
              .allDriverOrdersModel?.orders?.data?.isEmpty ??
          true) {
        return const Center(
          child: Text("No Delivered Orders yet"),
        );
      }
      return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: allDriverOrdersController
                .allDriverOrdersModel?.orders?.data?.length ??
            0,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 16),
        itemBuilder: (BuildContext context, int index) {
          OrderDatum? orderDatum = allDriverOrdersController
              .allDriverOrdersModel?.orders?.data?[index];

          return orderItem(orderDatum);
        },
      );
    });
  }

  Container _buildBottom() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: GetBuilder<PickOrdersController>(builder: (pickOrdersController) {
        if (pickOrdersController.loading) {
          return const SizedBox(
            height: 50,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return ElevatedButton(
          onPressed: () {
            LoginController loginController = Get.find();
            pickOrdersController.pickOrders(
                context, loginController.loginModel?.tokens?.accessToken ?? "");
          },
          child: const Text(
            AppConstants.pickOrder,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: FontConstants.medium,
              fontSize: 16,
            ),
          ),
        );
      }),
    );
  }
}
