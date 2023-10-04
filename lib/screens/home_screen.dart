import 'dart:async';

import 'package:ecart_driver/controllers/authentication/login_controller.dart';
import 'package:ecart_driver/screens/notification_screen.dart';
import 'package:ecart_driver/utils/constants/app_constants.dart';
import 'package:ecart_driver/utils/constants/font_constants.dart';
import 'package:ecart_driver/utils/helping_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/orders/all_driver_orders_controller.dart';
import 'orders /order_page_decider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final HelpingMethods helpingMethods = HelpingMethods();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  bool isSelectOrder = false;

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.find();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme:
            const IconThemeData(color: Colors.black //change your color here
                ),
        backgroundColor: Colors.white,
        toolbarHeight: 50,
        actions: [
          GestureDetector(
            onTap: () {
              helpingMethods.openScreen(
                  context: context, screen: const NotificationScreen());
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset("images/bell_icon.svg"),
                  Positioned(
                    top: 20,
                    left: -2,
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      radius: 7,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
        leading: Padding(
          padding: const EdgeInsets.only(left: 13.0),
          child: CircleAvatar(
            backgroundColor: Colors.grey.shade400,
            backgroundImage: const NetworkImage(AppConstants.userImage),
          ),
        ),
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Hi,",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: FontConstants.medium,
                  color: Color(0xff969696)),
            ),
            Text(
              "${loginController.loginModel?.user?.firstName ?? ""} ${loginController.loginModel?.user?.lastName ?? ""}",
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontConstants.bold,
                  color: Colors.black),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _kGooglePlex,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.white.withOpacity(0.0)],
                stops: const [0.5, 1],
                end: Alignment.bottomCenter,
                begin: Alignment.topCenter,
              ),
            ),
          ),
          if (!isSelectOrder)
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  isSelectOrder = !isSelectOrder;
                  setState(() {});
                },
                child: const Chip(
                  backgroundColor: Colors.white,
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xffFF5555),
                        radius: 8,
                      ),
                      SizedBox(width: 8),
                      Text(
                        AppConstants.offline,
                        style: TextStyle(
                            color: Color(0xffFF5555),
                            fontSize: 16,
                            fontFamily: FontConstants.bold,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (isSelectOrder)
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {},
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        isSelectOrder = !isSelectOrder;
                        setState(() {});
                      },
                      child: const Chip(
                        backgroundColor: Color(0xff1B7575),
                        deleteIcon: CircleAvatar(
                          backgroundColor: Color(0xffFF5555),
                          radius: 8,
                        ),
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppConstants.online,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: FontConstants.bold,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 8),
                            CircleAvatar(
                              backgroundColor: Color(0xffE1F5E9),
                              radius: 8,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        AllDriverOrdersController allDriverOrdersController =
                            Get.find();
                        allDriverOrdersController.selectedOrder.clear();
                        allDriverOrdersController.getAllDriverOrders(
                            loginController.loginModel?.tokens?.accessToken);
                        helpingMethods.openScreen(
                            context: context, screen: const OrderPageDecider());
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 16),
                      ),
                      child: const Text(AppConstants.selectOrder),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
