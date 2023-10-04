import 'package:ecart_driver/screens/orders%20/delivery_map_screen.dart';
import 'package:ecart_driver/utils/constants/app_constants.dart';
import 'package:ecart_driver/utils/constants/font_constants.dart';
import 'package:ecart_driver/utils/helping_method.dart';
import 'package:ecart_driver/widgets/order_item.dart';
import 'package:ecart_driver/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/orders/all_driver_orders_controller.dart';
import '../model/orders/order_model.dart';

class OrderSelectionScreen extends StatefulWidget {
  const OrderSelectionScreen({Key? key}) : super(key: key);

  @override
  State<OrderSelectionScreen> createState() => _OrderSelectionScreenState();
}

class _OrderSelectionScreenState extends State<OrderSelectionScreen> {
  TextEditingController searchController = TextEditingController();
  FocusNode searchNode = FocusNode();
  TextEditingController kmController = TextEditingController();
  FocusNode kmNode = FocusNode();
  final HelpingMethods helpingMethods = HelpingMethods();

  @override
  void initState() {
    searchController.text = "#5 Suite, Trincity Industrial Esta";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      bottomNavigationBar: selectedIndex != -1 ? _buildBottom() : null,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: const BoxDecoration(
                        color: Color(0xffE1F5E9),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        )),
                    child: const Text(
                      "Search By: Kilometer",
                      style: TextStyle(
                          color: Color(0xffA6C4B2),
                          fontFamily: FontConstants.bold,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                      child: textField(
                    textInputAction: TextInputAction.search,
                    hintText: AppConstants.deliveryLocation,
                    controller: kmController,
                    focusNode: kmNode,
                    isPhone: true,
                    isSearch: true,
                  )),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "You can select any three orders from this Location",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: FontConstants.medium),
              ),
            ),
            orderListView(),
          ],
        ),
      ),
    );
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
      child: ElevatedButton(
        onPressed: () {
          helpingMethods.openScreen(
              context: context, screen: const DeliveryMapScreen());
        },
        child: const Text(
          AppConstants.pickOrder,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: FontConstants.medium,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  int selectedIndex = -1;

  Widget orderListView() {
    return GetBuilder<AllDriverOrdersController>(
        builder: (allDriverOrdersController) {
      return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        shrinkWrap: true,
        primary: false,
        itemCount: allDriverOrdersController
                .allDriverOrdersModel?.orders?.data?.length ??
            0,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 16),
        itemBuilder: (BuildContext context, int index) {
          OrderDatum? orderDatum = allDriverOrdersController
              .allDriverOrdersModel?.orders?.data?[index];
          return GestureDetector(
            onTap: () {
              selectedIndex = index;
              setState(() {});
            },
            child: orderItem(orderDatum, selectedIndex: selectedIndex),
          );
        },
      );
    });
  }
}
