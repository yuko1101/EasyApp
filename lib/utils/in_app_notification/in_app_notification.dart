import 'package:flutter/material.dart';
import 'notification_data.dart';
import 'notification_widget.dart';

/// InAppNotification is a class that show notifications in your app.
class InAppNotification extends StatelessWidget {
  InAppNotification({
    this.borderColor,
    this.backgroundColor,
    Key? key,
  }) : super(key: key);

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  final List<NotificationData> notifications = [];
  final Color? borderColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10, right: 2),
          child: SingleChildScrollView(
            reverse: true,
            child: NotificationList(context),
          ),
        ),
      ),
    );
  }

  /// Push a notification to the list.
  Future<void> pushNotification(NotificationData notification,
      {Duration? duration}) async {
    notifications.add(notification);
    _listKey.currentState?.insertItem(notifications.length - 1);
    if (notification.progress == null) {
      Future.delayed(duration ?? const Duration(milliseconds: 2000), () {
        deleteNotification(notification.id);
      });
    } else {
      await notification.progress!.call();
      deleteNotification(notification.id);
    }
  }

  /// Delete a notification from the list.
  void deleteNotification(String id) {
    final int index =
        notifications.indexWhere((notification) => notification.id == id);
    if (index == -1) return;
    final deleted = notifications.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => SlideTransition(
        position: animation.drive(NotificationList._offset),
        child: NotificationWidget(
          notification: deleted,
          backgroundColor:
              backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
          borderColor: borderColor ?? Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

/// NotificationList is an animated list used in InAppNotification.
class NotificationList extends StatefulWidget {
  const NotificationList(this.parentContext, {Key? key}) : super(key: key);
  final BuildContext parentContext;

  /// Animation of the notification.
  static final Tween<Offset> _offset =
      Tween(begin: const Offset(1, 0), end: const Offset(0, 0));

  @override
  NotificationListState createState() => NotificationListState();
}

/// State of NotificationList.
class NotificationListState extends State<NotificationList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      key: (widget.parentContext.widget as InAppNotification)._listKey,
      initialItemCount: (widget.parentContext.widget as InAppNotification)
          .notifications
          .length,
      itemBuilder: (context, index, animation) {
        final InAppNotification inAppNotification =
            widget.parentContext.widget as InAppNotification;
        return SlideTransition(
          position: animation.drive(NotificationList._offset),
          child: NotificationWidget(
            notification: inAppNotification.notifications[index],
            borderColor:
                inAppNotification.borderColor ?? Theme.of(context).primaryColor,
            backgroundColor: inAppNotification.backgroundColor ??
                Theme.of(context).scaffoldBackgroundColor,
          ),
        );
      },
    );
  }
}
