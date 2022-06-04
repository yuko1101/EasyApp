import 'package:flutter/material.dart';
import 'notification_data.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget(
      {required this.notification,
      required this.borderColor,
      required this.backgroundColor,
      Key? key})
      : super(key: key);

  final NotificationData notification;
  final Color borderColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 4),
        Row(
          children: [
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: borderColor),
                color: backgroundColor,
              ),
              child: notification.child,
            ),
          ],
        ),
      ],
    );
  }
}
