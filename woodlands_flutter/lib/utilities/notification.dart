import 'package:awesome_notifications/awesome_notifications.dart';

void notify(String title, String body, String image) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: 1,
        channelKey: 'key1',
        title: title,
        body: body,
        notificationLayout: NotificationLayout.BigPicture,
        bigPicture:
            "https://images.idgesg.net/images/article/2019/01/android-q-notification-inbox-100785464-large.jpg?auto=webp&quality=85,70"),
  );
}
