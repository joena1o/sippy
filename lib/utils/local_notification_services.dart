// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:nine_life_booking/core/config/get_it_setup.dart';
// import 'package:nine_life_booking/features/auth/data/repository/auth_repository.dart';

// class LocalNotificationService {
//   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   static Future<void> initialize() async {
//     // Android initialization settings
//     const AndroidInitializationSettings androidSettings =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     // iOS initialization settings
//     const DarwinInitializationSettings iosSettings =
//         DarwinInitializationSettings();

//     // Combined settings
//     const InitializationSettings settings =
//         InitializationSettings(android: androidSettings, iOS: iosSettings);

//     // Initialize the plugin
//     await _notificationsPlugin.initialize(settings);
//   }

//   static Future<void> showNotification({
//     required String title,
//     required String body,
//     int id = 0,
//   }) async {
//     const AndroidNotificationDetails androidDetails =
//         AndroidNotificationDetails(
//       'main_channel',
//       'Main Channel',
//       importance: Importance.high,
//       priority: Priority.high,
//     );

//     const NotificationDetails notificationDetails =
//         NotificationDetails(android: androidDetails);

//     await _notificationsPlugin.show(id, title, body, notificationDetails);
//   }

//   static Future<String?> initializeFCM() async {
//     FirebaseMessaging messaging = FirebaseMessaging.instance;
//     try {
//       // Request permission (especially for iOS)
//       NotificationSettings settings = await messaging.requestPermission(
//         alert: true,
//         badge: true,
//         sound: true,
//       );
//       if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//         // Get the FCM token
//         String? token = await messaging.getToken();
//         if (token != null) {
//           getIt<AuthRepository>().updateTokenOnServer(token);
//           return token;
//         }
//       } else {
//         print("User did not grant permission");
//       }
//     } catch (e) {
//       print("Error initializing FCM: $e");
//     }
//     return null;
//   }
// }
