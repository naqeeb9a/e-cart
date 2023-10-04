import 'package:ecart_driver/utils/constants/app_constants.dart';
import 'package:ecart_driver/utils/constants/font_constants.dart';
import 'package:ecart_driver/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  TextEditingController messageController = TextEditingController();
  FocusNode messageNode = FocusNode();

  final List _messages = [
    {"message": "Hi, Will you tell me something?", "isMe": false},
    {"message": "Yes Please", "isMe": true},
    {
      "message":
          "It was great pleasure to work with Kimberly and Redfin team to make the sale go thru. Kimberly took extra efforts to get everything setup correctly for sale and organizing open houses. I am really impressed with Kimberly’s quick response to any call or text. I will highly recommend her. And above all I recommend Redfin for updating Dashboard regularly that I could watch remotely.",
      "isMe": false
    },
    {"message": "Hi, Will you tell me something?", "isMe": false},
    {"message": "Yes Please", "isMe": true},
    {
      "message":
          "It was great pleasure to work with Kimberly and Redfin team to make the sale go thru. Kimberly took extra efforts to get everything setup correctly for sale and organizing open houses. I am really impressed with Kimberly’s quick response to any call or text. I will highly recommend her. And above all I recommend Redfin for updating Dashboard regularly that I could watch remotely.",
      "isMe": false
    },
    {"message": "Hi, Will you tell me something?", "isMe": false},
    {"message": "Yes Please", "isMe": true},
    {
      "message":
          "It was great pleasure to work with Kimberly and Redfin team to make the sale go thru. Kimberly took extra efforts to get everything setup correctly for sale and organizing open houses. I am really impressed with Kimberly’s quick response to any call or text. I will highly recommend her. And above all I recommend Redfin for updating Dashboard regularly that I could watch remotely.",
      "isMe": false
    },
  ];

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
          "Admin Support",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: FontConstants.bold,
              color: Colors.black),
        ),
      ),
      body: buildListView(),
    );
  }

  Widget buildListView() {
    return Column(
      children: [
        Expanded(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(16),
            children: List.generate(
                _messages.length,
                (index) => _messages[index]["isMe"]
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      color: const Color(0xffF5F5F5),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text(
                                    _messages[index]["message"],
                                    style: const TextStyle(
                                        fontFamily: FontConstants.medium,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff969696)),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "02:23 pm",
                                  style: TextStyle(
                                      fontFamily: FontConstants.medium,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff969696)),
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          CircleAvatar(
                            radius: 27,
                            backgroundColor: const Color(0xffEAEAEA),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.grey.shade400,
                              backgroundImage:
                                  const NetworkImage(AppConstants.userImage),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 27,
                            backgroundColor: const Color(0xffEAEAEA),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.white,
                              child: SvgPicture.asset(
                                "images/logo.svg",
                                // ignore: deprecated_member_use
                                color: const Color(0xff1B7575),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      color: const Color(0xffF5F5F5),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text(
                                    _messages[index]["message"],
                                    style: const TextStyle(
                                        fontFamily: FontConstants.medium,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff969696)),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "02:23 pm",
                                  style: TextStyle(
                                      fontFamily: FontConstants.medium,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff969696)),
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          )
                        ],
                      )),
          ),
        ),
        _buildBottom(),
      ],
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
      child: Row(
        children: [
          Expanded(
              child: textField(
            textInputAction: TextInputAction.done,
            hintText: AppConstants.typeMessage,
            controller: messageController,
            focusNode: messageNode,
            isCode: true,
            isSearch: true,
          )),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                )),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 14.5)),
            onPressed: () {},
            child: const Text(
              AppConstants.send,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: FontConstants.medium,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}
