
import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shivalik_institute/model/LecturesResponseModel.dart';
import 'package:shivalik_institute/screen/ChatScreen.dart';
import 'package:shivalik_institute/screen/DashboardScreen.dart';
import 'package:shivalik_institute/screen/FacultyProfileScreen.dart';
import 'package:shivalik_institute/screen/LectureDetailsScreen.dart';
import '../constant/api_end_point.dart';
import '../constant/global_context.dart';
import '../model/EventResponseModel.dart';
import '../model/ModuleResponseModel.dart';
import '../screen/EventDetailsScreen.dart';
import '../screen/MaterialDetailScreen.dart';
import '../utils/session_manager.dart';
import 'package:http/http.dart' as http;
import '../utils/session_manager_methods.dart';
import 'package:to_do_package_shivalik/screens/todo_list_screen.dart';
import 'package:to_do_package_shivalik/screens/todo_detail_screen.dart';
import 'package:to_do_package_shivalik/model/todo_list_data_response_model.dart';

/**
 * Documents added by Alaa, enjoy ^-^:
 * There are 3 major things to consider when dealing with push notification :
 * - Creating the notification
 * - Hanldle notification click
 * - App status (foreground/background and killed(Terminated))
 *
 * Creating the notification:
 *
 * - When the app is killed or in background state, creating the notification is handled through the back-end services.
 *   When the app is in the foreground, we have full control of the notification. so in this case we build the notification from scratch.
 *
 * Handle notification click:
 *
 * - When the app is killed, there is a function called getInitialMessage which
 *   returns the remoteMessage in case we receive a notification otherwise returns null.
 *   It can be called at any point of the application (Preferred to be after defining GetMaterialApp so that we can go to any screen without getting any errors)
 * - When the app is in the background, there is a function called onMessageOpenedApp which is called when user clicks on the notification.
 *   It returns the remoteMessage.
 * - When the app is in the foreground, there is a function flutterLocalNotificationsPlugin, is passes a future function called onSelectNotification which
 *   is called when user clicks on the notification.
 *
 * */

class PushNotificationService {

  Future<void> setupInteractedMessage() async
  {
    await Firebase.initializeApp();
    if (Platform.isAndroid)
    {
      await FirebaseMessaging.instance.requestPermission();
    }
    else
    {
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
    await enableIOSNotifications();
    await registerNotificationListeners();
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    // Get any messages which caused the application to open from a terminated state.
    // If you want to handle a notification click when the app is terminated, you can use `getInitialMessage`
    // to get the initial message, and depending in the remoteMessage, you can decide to handle the click
    // This function can be called from anywhere in your app, there is an example in main file.
    // RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    // if (initialMessage != null && initialMessage.data['type'] == 'chat') {
    // Navigator.pushNamed(context, '/chat',
    //     arguments: ChatArguments(initialMessage));
    // }
    // Also handle any interaction when the app is in the background via a
    // Stream listener
    // This function is called when the app is in the background and user clicks on the notification

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      var id = "";
      var contentType = "";
      var image = "";
      var messageData = "";
      print('Data Payload:${message.data.toString()}');
      message.data.forEach((key, value) {
        if (key == "id") {
          id = value;
        }

        if (key == "operation") {
          contentType = value;
        }

        /*if (key == "image") {
          image = value;
        }

        if (key == "body") {
          messageData = value;
        }*/
      });

      print('<><> onMessageOpenedApp setupInteractedMessage id--->$id');
      print('<><> onMessageOpenedApp setupInteractedMessage contentType--->$contentType');

      NavigationService.notif_id = id;
      NavigationService.notif_type = contentType;


      SessionManagerMethods.init();

      SessionManager sessionManager = SessionManager();

      if (contentType == "lecture_complete")
      {
        sessionManager.setClassId(id);
      }
      else if (contentType == "user_chat")
      {
        int userCount = sessionManager.getMessageCount() ?? 0;

        userCount = userCount + 1;

        print("USER CHAT BEFORE ===== $userCount");

        sessionManager.setMessageCount(userCount);
        sessionManager.setBatchId(message.data['id']);

        print("USER CHAT ===== ${sessionManager.getMessageCount()}");
      }


      openPage(contentType);
    });
  }

  registerNotificationListeners() async {
    AndroidNotificationChannel channel = androidNotificationChannel();
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);


    var androidSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');

    var iOSSettings = const DarwinInitializationSettings(
        requestSoundPermission: true,defaultPresentSound: true);

    var initSettings = InitializationSettings(android: androidSettings, iOS: iOSSettings);

    flutterLocalNotificationsPlugin.initialize(initSettings, onDidReceiveNotificationResponse: (NotificationResponse payload) {
      // This function handles the click in the notification when the app is in foreground
      // Get.toNamed(NOTIFICATIOINS_ROUTE);
      try {
        print('<><> TAP onMessage :' + payload.payload.toString() + "  <><>");
        var contentType = payload.payload.toString();
        openPage(contentType);
      } catch (e) {
        print(e);
      }
    });

    // onMessage is called when the app is in foreground and a notification is received

    FirebaseMessaging.onMessage.listen((RemoteMessage? message) async {
      print('onMessage Notification Payload:${message?.notification!.toMap().toString()}');
      print('onMessage Data Payload:${message?.data.toString()}');
      RemoteNotification? notification = message?.notification;
      AndroidNotification? android = message?.notification?.android;
      AppleNotification? appleNotification = message?.notification?.apple;
      SessionManager sessionManager = SessionManager();
      var isLoggedIn = sessionManager.checkIsLoggedIn() ?? false;
      if (notification != null && isLoggedIn)
      {
        var id = "";
        var contentType = "";
        var image = "";
        var title = "";
        var messageData = "";

        message?.notification?.toMap().forEach((key, value) {
          if (key == "image") {
            image = value;
          }

          if (key == "title") {
            title = value;
          }

          if (key == "body") {
            messageData = value;
          }
        });

        print("data ==== ${message?.data}");
        print("notification ==== ${message?.notification}");

        message?.data.forEach((key, value) {
          if (key == "id") {
            id = value;
          }

          if (key == "operation") {
            contentType = value;
          }

          if (key == "image") {
            image = value;
          }

          if (key == "title") {
            title = value;
          }

          if (key == "body") {
            messageData = value;
          }
        });

        image = android?.imageUrl ?? '';

        print('<><> onMessage id--->$id');
        print('<><> onMessage title--->$title');
        print('<><> onMessage messageData--->$messageData');
        print('<><> onMessage contentType--->$contentType');
        print("<><> onMessage Image URL : $image <><>");

        SessionManagerMethods.init();

        int userCount = sessionManager.getMessageCount() ?? 0;

        userCount = userCount + 1;

        print("USER CHAT BEFORE ===== $userCount");

        sessionManager.setMessageCount(userCount);


        if (image.isNotEmpty)
        {

          String largeIconPath = await _downloadAndSaveFile(image.toString().replaceAll(" ", "%20"), 'largeIcon');
          String bigPicturePath = await _downloadAndSaveFile(image.toString().replaceAll(" ", "%20"), 'bigPicture');

          final BigPictureStyleInformation bigPictureStyleInformation = BigPictureStyleInformation(
              FilePathAndroidBitmap(bigPicturePath),
              largeIcon: FilePathAndroidBitmap(largeIconPath),
              hideExpandedLargeIcon: false,
              contentTitle: title, //"<b>$title</b>"
              htmlFormatContentTitle: true,
              summaryText: '',
              htmlFormatSummaryText: true
          );

          final DarwinNotificationDetails iOSPlatformChannelSpecifics = DarwinNotificationDetails(
              presentSound: true,
              presentAlert: true,
              categoryIdentifier: "myNotificationCategory",
              threadIdentifier: "myNotificationCategory",
              attachments: <DarwinNotificationAttachment>[
                DarwinNotificationAttachment(
                  bigPicturePath,
                )
              ]);

          print("object------->$bigPicturePath**************");

          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails('SIRE', 'SIRE',
                    channelDescription: channel.description,
                    icon: android!.smallIcon,
                    playSound: true,
                    styleInformation: bigPictureStyleInformation,
                    importance: Importance.max,
                    priority: Priority.high),
                iOS: iOSPlatformChannelSpecifics),
            payload: contentType,
          );

        }
        else
        {
          print("IMAGE NOT EMPTY");
          const DarwinNotificationDetails iOSPlatformChannelSpecifics = DarwinNotificationDetails(presentSound: true, presentAlert: true,);
          print("IMAGE  ==== ${title} ====== ${messageData}");
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            title,
            messageData,
            payload: contentType,
            NotificationDetails(
              android: AndroidNotificationDetails(
                'SIRE',
                'SIRE',
                channelDescription: channel.description,
                icon: android!.smallIcon,
                playSound: true,
                importance: Importance.max,
                styleInformation: BigTextStyleInformation(messageData),
                priority: Priority.high,
              ),
              iOS: iOSPlatformChannelSpecifics,
            ),
          );
        }

      }
      else
      {
        print("<><> CHECK DATA : " + " <><>");
      }

    });
  }

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  enableIOSNotifications() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, // Required to display a heads up notification
        badge: true,
        sound: true);
  }

  androidNotificationChannel() => const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.max,
    playSound: true,
    sound: RawResourceAndroidNotificationSound('notification_sound_tone.mp3'),
  );


void openPage(String contentId) {

    SessionManagerMethods.init();


    print("<><> ONTAP DATA :: " + contentId + "<><>");

    NavigationService.notif_type = contentId;
    if (contentId == "event_scheduled")
      {
        NavigationService.navigatorKey.currentState!.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => EventsDetailsScreen(EventList())), (Route<dynamic> route) => false
        );
      }
    else if (contentId == "lecture_complete")
      {
        NavigationService.navigatorKey.currentState!.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => DashboardScreen()), (Route<dynamic> route) => false
        );
      }
    else if (contentId == "lecture_reminder")
      {
        NavigationService.navigatorKey.currentState!.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LectureDetailsScreen(NavigationService.notif_id ?? '')), (Route<dynamic> route) => false
        );
      }
    else if (contentId == "lecture_scheduled")
      {
        NavigationService.navigatorKey.currentState!.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LectureDetailsScreen(NavigationService.notif_id ?? '')), (Route<dynamic> route) => false
        );
      }
    else if (contentId == "material_uploaded")
      {
        NavigationService.navigatorKey.currentState!.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MaterialDetailScreen(ModuleList(), LectureList())), (Route<dynamic> route) => false
        );
      }
    else if (contentId == "pedning_fees_reminder")
      {
        NavigationService.isForPendingFees = true;
        NavigationService.navigatorKey.currentState!.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const DashboardScreen()), (Route<dynamic> route) => false
        );
      }
    else if (contentId == "submission_reminder")
      {
        NavigationService.navigatorKey.currentState!.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const DashboardScreen()), (Route<dynamic> route) => false
        );
      }
    else if (contentId == "lecture_cancelled")
      {
        NavigationService.navigatorKey.currentState!.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LectureDetailsScreen(NavigationService.notif_id ?? '')), (Route<dynamic> route) => false
        );
      }
    else if (contentId == "module_completed")
      {
        NavigationService.navigatorKey.currentState!.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LectureDetailsScreen(NavigationService.notif_id ?? '')), (Route<dynamic> route) => false
        );
      }
    else if (contentId == "lecture_complete")
      {
        NavigationService.navigatorKey.currentState!.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const DashboardScreen()), (Route<dynamic> route) => false
        );
      }
    else if (contentId == "faculty_profile")
      {
        NavigationService.navigatorKey.currentState!.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => FacultyProfileScreen(NavigationService.notif_id ?? '')), (Route<dynamic> route) => false
        );
      }
    else if (contentId == "user_chat")
      {
        NavigationService.navigatorKey.currentState!.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const ChatScreen(false)), (Route<dynamic> route) => false
        );
      }
    else if(contentId == "task_deleted" || contentId == "removed_from_task_observation" || contentId == "removed_from_task"){
      NavigationService.navigatorKey.currentState!.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) =>  ToDoListScreen(
              AuthHeader,
              SessionManager().getUserId() ?? "",
              SessionManager().getUserId() ?? "",
              "${SessionManager().getName() ?? ""} ${SessionManager().getLastName() ?? ""}",
              SessionManager().getProfilePic() ?? ""
          )), (Route<dynamic> route) => false
      );

    }
    else if(contentId == "new_task_assigned" || contentId == "observer_assigned_to_task" || contentId == "task_update" || contentId == "daily_task_summary" || contentId == "task_comment"){
      NavigationService.navigatorKey.currentState!.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) =>  ToDoDetailScreen(
            TodoList(), const [], true,false,NavigationService.notif_id,userId: SessionManager().getUserId() ?? "",AuthHeader,
            userProfile: SessionManager().getProfilePic() ?? "",
            name:  "${SessionManager().getName() ?? ""} ${SessionManager().getLastName() ?? ""}", filterProjectList: [],
          )), (Route<dynamic> route) => false
      );

    }
    else
      {
        NavigationService.navigatorKey.currentState!.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const DashboardScreen()), (Route<dynamic> route) => false
        );
      }
  }


}
