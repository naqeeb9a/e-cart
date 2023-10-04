import 'package:ecart_driver/controllers/Withdraw%20amount/withdraw_amount_controller.dart';
import 'package:ecart_driver/controllers/assigned%20orders%20/assigned_orders.dart';
import 'package:ecart_driver/controllers/authentication/login_controller.dart';
import 'package:ecart_driver/controllers/orders/all_driver_orders_controller.dart';
import 'package:ecart_driver/controllers/pick%20orders/pick_orders.dart';
import 'package:ecart_driver/controllers/transaction/transaction_controller.dart';
import 'package:ecart_driver/controllers/update%20order%20status/update_order_status_controller.dart';
import 'package:ecart_driver/controllers/wallet/wallet_controller.dart';
import 'package:ecart_driver/screens/splash_screen.dart';
import 'package:ecart_driver/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'controllers/delivered orders/delivered_orders.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    Get.put(AllDriverOrdersController());
    Get.put(AllDeliveredDriverOrdersController());
    Get.put(PickOrdersController());
    Get.put(AssignedOrdersController());
    Get.put(WalletController());
    Get.put(WalletWithdrawController());
    Get.put(TransactionController());
    Get.put(UpdateOrderStatusController());
    return GetMaterialApp(
      title: 'eCart Driver',
      theme: ThemeData(
          fontFamily: "TT Norms Pro",
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              //elevation of button
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 16), //content padding inside button
            ),
          ),
          colorScheme: const ColorScheme(
            primary: Color(0xff76B139),
            secondary: Color(0xffF9B820),
            surface: Colors.white,
            background: Color(0xffF8FAF8),
            error: Colors.red,
            onPrimary: Colors.white,
            onSecondary: Colors.deepOrange,
            onSurface: Colors.black,
            onBackground: Colors.black,
            onError: Colors.redAccent,
            brightness: Brightness.light,
          )),
      home: SplashScreen(),
    );
  }
}
