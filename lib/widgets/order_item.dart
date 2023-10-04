import 'package:ecart_driver/utils/constants/font_constants.dart';
import 'package:ecart_driver/widgets/dash_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../model/orders/order_model.dart';

Widget orderItem(OrderDatum? orderDatum, {int selectedIndex = -1}) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: selectedIndex == 1
                  ? const Color(0xff1B7575)
                  : const Color(0xffEAEAEA))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              const Text(
                "Order ID",
                style: TextStyle(
                  color: Color(0xff969696),
                  fontWeight: FontWeight.bold,
                  fontFamily: FontConstants.bold,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                orderDatum?.id ?? "",
                style: const TextStyle(
                  color: Color(0xff5C1F5A),
                  fontWeight: FontWeight.bold,
                  fontFamily: FontConstants.bold,
                ),
              ),
              const Spacer(),
              const Text(
                "1.5 KM",
                style: TextStyle(
                  color: Color(0xffFF5555),
                  fontWeight: FontWeight.bold,
                  fontFamily: FontConstants.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  SvgPicture.asset("images/loc_start.svg"),
                  CustomPaint(
                      size: const Size(1, 30),
                      painter: DashedLineVerticalPainter()),
                  SvgPicture.asset("images/home_end.svg"),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Pickup Point",
                      style: TextStyle(
                        color: Color(0xff5C1F5A),
                        fontWeight: FontWeight.bold,
                        fontFamily: FontConstants.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      "123 Kula Plains suite 32890",
                      maxLines: 1,
                      style: TextStyle(
                        color: Color(0xff969696),
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w500,
                        fontFamily: FontConstants.medium,
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      "Delivery Point",
                      style: TextStyle(
                        color: Color(0xff5C1F5A),
                        fontWeight: FontWeight.bold,
                        fontFamily: FontConstants.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      orderDatum?.shippingAddress?.address ??
                          "No address available",
                      maxLines: 1,
                      style: const TextStyle(
                        color: Color(0xff969696),
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w500,
                        fontFamily: FontConstants.medium,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
