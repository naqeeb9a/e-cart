import 'dart:async';
import 'dart:ui' as ui;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecart_driver/controllers/assigned%20orders%20/assigned_orders.dart';
import 'package:ecart_driver/controllers/authentication/login_controller.dart';
import 'package:ecart_driver/controllers/update%20order%20status/update_order_status_controller.dart';
import 'package:ecart_driver/model/orders/assigned_order_model.dart';
import 'package:ecart_driver/screens/order_success_screen.dart';
import 'package:ecart_driver/utils/constants/app_constants.dart';
import 'package:ecart_driver/utils/constants/font_constants.dart';
import 'package:ecart_driver/utils/helping_method.dart';
import 'package:ecart_driver/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DeliveryMapScreen extends StatefulWidget {
  const DeliveryMapScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryMapScreen> createState() => _DeliveryMapScreenState();
}

class _DeliveryMapScreenState extends State<DeliveryMapScreen> {
  int selectedIndex = 0;
  TextEditingController searchController = TextEditingController();
  FocusNode searchNode = FocusNode();
  final Completer<GoogleMapController> _controller = Completer();
  final HelpingMethods helpingMethods = HelpingMethods();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(5.6036535, -0.2097939),
    zoom: 19.151926040649414,
  );
  final List<Marker> _markers = <Marker>[];
  final List<Polyline> _polylines = <Polyline>[];

  Future<Uint8List> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  void initState() {
    searchController.text = "#5 Suite, Trincity Industrial Esta";
    getImages("images/loc_pin.png", 100).then((markIcons) {
      _markers.add(Marker(
        markerId: const MarkerId("id"),
        icon: BitmapDescriptor.fromBytes(markIcons),
        position: const LatLng(5.6036535, -0.2097939),
      ));
      setState(() {});
    });

    super.initState();
  }

  addDirPin() async {
    UpdateOrderStatusController updateOrderStatusController = Get.find();
    AssignedOrdersController assignedOrdersController = Get.find();
    LoginController loginController = Get.find();

    await updateOrderStatusController.updateOrder(
        context,
        loginController.loginModel?.tokens?.accessToken,
        assignedOrdersController
            .allDriverOrdersModel?.orders?[selectedIndex].id,
        {"status": "driver_started"});
    assignedOrdersController.getAssignedOrders(
        loginController.loginModel?.tokens?.accessToken ?? "");
    List<LatLng> latLen = [
      const LatLng(5.6036535, -0.2097939),
      const LatLng(5.603794, -0.209921),
      const LatLng(5.603858, -0.209976),
      const LatLng(5.603794, -0.210045),
    ];
    getImages("images/dir_pin.png", 100).then((markIcons) {
      _markers.add(Marker(
        markerId: const MarkerId("iddir"),
        icon: BitmapDescriptor.fromBytes(markIcons),
        position: const LatLng(5.603794, -0.210045),
      ));
      _polylines.add(Polyline(
          polylineId: const PolylineId('1'),
          points: latLen,
          color: Colors.green.shade200,
          width: 5));
      animateMap(const LatLng(5.603794, -0.210045));
    });
  }

  @override
  Widget build(BuildContext context) {
    AssignedOrdersController assignedOrdersController = Get.find();
    Order? order =
        assignedOrdersController.allDriverOrdersModel?.orders?[selectedIndex];
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildBottom(),
      appBar: AppBar(
        elevation: 0,
        iconTheme:
            const IconThemeData(color: Colors.black //change your color here
                ),
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        actions: [
          if (!(order?.status != "driver_started"))
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: SvgPicture.asset("images/ambulance_icon.svg"),
            )
        ],
        title: Text(
          (order?.status != "driver_started")
              ? AppConstants.yourOrders
              : AppConstants.onTheWay,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: FontConstants.bold,
              color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _kGooglePlex,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            markers: Set<Marker>.of(_markers),
            polylines: Set<Polyline>.of(_polylines),
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
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: GetBuilder<AssignedOrdersController>(
                builder: (assignedOrdersController) {
              if (assignedOrdersController.loading) {
                return const SizedBox(
                  height: 190,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return buildSlider(assignedOrdersController);
            }),
          ),
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
        ],
      ),
    );
  }

  Widget _delivryCard(Order? order) => Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey.shade400,
                  backgroundImage: const NetworkImage(AppConstants.userImage),
                ),
                title: Text(
                  "${order?.shippingAddress?.firstName ?? ""} ${order?.shippingAddress?.lastName ?? ""}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontConstants.bold),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Amount",
                        style: TextStyle(
                            color: Color(0xff969696),
                            fontWeight: FontWeight.w500,
                            fontFamily: FontConstants.medium)),
                    Text(
                      "\$${order?.totalPrice}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontConstants.bold),
                    )
                  ],
                ),
              ),
              const Spacer(),
              ListTile(
                onTap: () {
                  launchUrl(Uri.parse("tel:${order?.phone}"));
                },
                tileColor: const Color(0xffEAF4DF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                leading: SvgPicture.asset("images/phone_icon.svg"),
                title: const Text("Call Customer",
                    style: TextStyle(
                        color: Color(0xff1B7575),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        fontFamily: FontConstants.bold)),
                subtitle: Text("${order?.phone}",
                    style: const TextStyle(
                        color: Color(0xff1B7575),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: FontConstants.bold)),
              )
            ],
          ),
        ),
      );

  Future<void> animateMap(latlng) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latlng, zoom: 19.151926040649414)));
  }

  CarouselSlider buildSlider(
      AssignedOrdersController assignedOrdersController) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 190.0,
        enlargeCenterPage: true,
        autoPlayCurve: Curves.easeInOut,
        enableInfiniteScroll: false,
        viewportFraction: 1,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        onPageChanged: (index, reason) {
          selectedIndex = index;
          return animateMap(LatLng(
              assignedOrdersController.allDriverOrdersModel?.orders?[index]
                      .shippingAddress?.location?.coordinates?[0] ??
                  0.0,
              assignedOrdersController.allDriverOrdersModel?.orders?[index]
                      .shippingAddress?.location?.coordinates?[1] ??
                  0.0));
        },
      ),
      items: List.generate(
        assignedOrdersController.allDriverOrdersModel?.orders?.length ?? 0,
        (index) {
          Order? order =
              assignedOrdersController.allDriverOrdersModel?.orders?[index];
          return _delivryCard(order);
        },
      ),
    );
  }

  Container _buildBottom() {
    AssignedOrdersController assignedOrdersController = Get.find();
    Order? order =
        assignedOrdersController.allDriverOrdersModel?.orders?[selectedIndex];
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
          if (order?.status != "driver_started") {
            addDirPin();
          } else {
            _replyBottomSheet();
          }
        },
        child: Text(
          (order?.status != "driver_started")
              ? AppConstants.startDelivery
              : AppConstants.arrived,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: FontConstants.medium,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  TextEditingController replyController = TextEditingController();
  FocusNode replyNode = FocusNode();

  _replyBottomSheet() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          AppConstants.askDelivery,
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff1B7575),
                              fontWeight: FontWeight.bold,
                              fontFamily: FontConstants.bold),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.black,
                            ))
                      ],
                    ),
                    const SizedBox(height: 16),
                    textField(
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      hintText: AppConstants.codeHint,
                      controller: replyController,
                      focusNode: replyNode,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const OrderSuccessScreen()));
                      },
                      child: const Text(
                        AppConstants.done,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: FontConstants.medium),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
