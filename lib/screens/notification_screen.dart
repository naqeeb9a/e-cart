import 'package:ecart_driver/model/notification.dart';
import 'package:ecart_driver/utils/constants/font_constants.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<Notifications> _notifications = [
    Notifications(
      title: "Completed Order #216890",
      subTitle: "You have completed this order successfully",
      status: "Now",
      isUnread: true,
    ),
    Notifications(
      title: "New Invoice",
      subTitle: "Review and receive your payment on time",
      status: "Today",
      isUnread: true,
    ),
    Notifications(
      title: "There has been a slight change",
      subTitle: "This is to inform you our new feature",
      status: "Yesterday",
      isUnread: false,
    ),
    Notifications(
      title: "Congratulations!",
      subTitle: "You have completed 100 rides.",
      status: "18/11/2022",
      isUnread: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAF8),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: const Color(0xffF8FAF8),
        elevation: 0,
        title: const Text(
          "Notifications",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: FontConstants.bold,
              color: Colors.black),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        shrinkWrap: true,
        itemCount: _notifications.length,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 16),
        itemBuilder: (BuildContext context, int index) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_notifications[index].status,
                    style: TextStyle(
                        fontFamily: FontConstants.regular,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.primary)),
                if (_notifications[index].isUnread)
                  const CircleAvatar(
                    backgroundColor: Color(0xffFF5555),
                    radius: 5,
                  )
              ],
            ),
            const SizedBox(height: 4),
            Text(_notifications[index].title,
                style: const TextStyle(
                    fontFamily: FontConstants.bold,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff5C1F5A))),
            const SizedBox(height: 4),
            Text(_notifications[index].subTitle,
                style: const TextStyle(
                    fontFamily: FontConstants.regular,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff969696))),
          ],
        ),
      ),
    );
  }
}
