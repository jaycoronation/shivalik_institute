import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:provider/provider.dart';
import 'package:shivalik_institute/constant/api_end_point.dart';
import 'package:shivalik_institute/screen/DashboardScreen.dart';
import 'package:shivalik_institute/screen/EventDetailsScreen.dart';
import 'package:shivalik_institute/screen/LectureDetailsScreen.dart';
import 'package:shivalik_institute/screen/LoginWithOtpScreen.dart';
import 'package:shivalik_institute/screen/MaterialDetailScreen.dart';
import 'package:shivalik_institute/utils/app_utils.dart';
import 'package:shivalik_institute/utils/session_manager.dart';
import 'package:shivalik_institute/utils/session_manager_methods.dart';
import 'package:shivalik_institute/viewmodels/BatchViewModel.dart';
import 'package:shivalik_institute/viewmodels/CaseStudyViewModel.dart';
import 'package:shivalik_institute/viewmodels/CityViewModel.dart';
import 'package:shivalik_institute/viewmodels/CountryViewModel.dart';
import 'package:shivalik_institute/viewmodels/CourseViewModel.dart';
import 'package:shivalik_institute/viewmodels/DashboardViewModel.dart';
import 'package:shivalik_institute/viewmodels/CommonViewModel.dart';
import 'package:shivalik_institute/viewmodels/DocumentViewModel.dart';
import 'package:shivalik_institute/viewmodels/EventViewModel.dart';
import 'package:shivalik_institute/viewmodels/HolidayViewModel.dart';
import 'package:shivalik_institute/viewmodels/LectureViewModel.dart';
import 'package:shivalik_institute/viewmodels/ManagmentViewModel.dart';
import 'package:shivalik_institute/viewmodels/MaterialDetailViewModel.dart';
import 'package:shivalik_institute/viewmodels/ModuleViewModel.dart';
import 'package:shivalik_institute/viewmodels/MultipartApiViewModel.dart';
import 'package:shivalik_institute/viewmodels/StateViewModel.dart';
import 'package:shivalik_institute/viewmodels/TestimonialsViewModel.dart';
import 'package:shivalik_institute/viewmodels/UserListViewModel.dart';
import 'package:shivalik_institute/viewmodels/UserViewModel.dart';
import 'package:shivalik_institute/viewmodels/VerifyOtpViewModel.dart';
import 'package:url_launcher/url_launcher.dart';

import 'common_widget/common_widget.dart';
import 'constant/colors.dart';
import 'constant/global_context.dart';
import 'firebase_options.dart';
import 'model/AppVersionResponseModel.dart';
import 'model/EventResponseModel.dart';
import 'model/LecturesResponseModel.dart';
import 'model/ModuleResponseModel.dart';
import 'push_notification/PushNotificationService.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SessionManagerMethods.init();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await PushNotificationService().setupInteractedMessage();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

  //FOR NOTIFICATION//
  if (initialMessage != null)
    {
      print("@@@@@@@@ Main Dart @@@@@@@@ ${initialMessage.data}");
      NavigationService.notif_type = initialMessage.data['operation'];
      NavigationService.notif_id = initialMessage.data['content_id'];

      if (NavigationService.notif_type == "session_feedback")
      {
        //NavigationService.class_id = initialMessage.data['content_id'];
        SessionManager().setClassId(initialMessage.data['content_id']);
      }
    }

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) => runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: CommonViewModel()),
        ChangeNotifierProvider.value(value: VerifyOtpViewModel()),
        ChangeNotifierProvider.value(value: UserViewModel()),
        ChangeNotifierProvider.value(value: DashboardViewModel()),
        ChangeNotifierProvider.value(value: CourseViewModel()),
        ChangeNotifierProvider.value(value: CountryViewModel()),
        ChangeNotifierProvider.value(value: StateViewModel()),
        ChangeNotifierProvider.value(value: CityViewModel()),
        ChangeNotifierProvider.value(value: BatchViewModel()),
        ChangeNotifierProvider.value(value: ModuleViewModel()),
        ChangeNotifierProvider.value(value: LectureViewModel()),
        ChangeNotifierProvider.value(value: UserListViewModel()),
        ChangeNotifierProvider.value(value: EventViewModel()),
        ChangeNotifierProvider.value(value: HolidayViewModel()),
        ChangeNotifierProvider.value(value: CaseStudyViewModel()),
        ChangeNotifierProvider.value(value: ManagementViewModel()),
        ChangeNotifierProvider.value(value: TestimonialsViewModel()),
        ChangeNotifierProvider.value(value: DocumentViewModel()),
        ChangeNotifierProvider.value(value: MultipartApiViewModel()),
        ChangeNotifierProvider.value(value: MaterialDetailViewModel()),
      ],
      child: const MyApp(),
    )
  ));

}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");

  print("@@@@@@@@ Main Dart @@@@@@@@ ${message.data}");
  NavigationService.notif_type = message.data['operation'];
  NavigationService.notif_id = message.data['content_id'];

  if (NavigationService.notif_type == "session_feedback")
    {
      //NavigationService.class_id = message.data['content_id'];

      print("NavigationService.class_id ===== ${NavigationService.class_id}");
      SessionManager().setClassId(message.data['content_id']);

    }

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle( const SystemUiOverlayStyle(
      statusBarColor: white,
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      statusBarBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarColor: grayLight,
      systemNavigationBarDividerColor: grayLight,
    ));
    return MaterialApp(
      title: 'Shivalik Institute',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
          primaryColor: black,
          platform: TargetPlatform.iOS,
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: white,
            contentPadding: const EdgeInsets.only(left: 12, right: 12, top: 18, bottom: 18),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kEditTextCornerRadius),
                borderSide:  const BorderSide(width: 1, style: BorderStyle.solid, color: grayNew)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kEditTextCornerRadius),
                borderSide:  const BorderSide(width: 1, style: BorderStyle.solid, color: black)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kEditTextCornerRadius),
                borderSide: const BorderSide(width: 1, color: grayNew)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kEditTextCornerRadius),
                borderSide: const BorderSide(width:1, color: grayNew)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kEditTextCornerRadius),
                borderSide: const BorderSide(width:1, style: BorderStyle.solid, color: grayNew)),
            labelStyle: const TextStyle(
              color: lableHint,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            hintStyle: const TextStyle(color: lableHint,
                fontSize: 14,
                fontWeight: FontWeight.w400),
          ),
          fontFamily: 'Colfax',
          textSelectionTheme: TextSelectionThemeData(selectionColor: black.withOpacity(0.3)),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: createMaterialColor(white)).copyWith(secondary: white)
      ),
      navigatorKey: NavigationService.navigatorKey,
      home: const MyHomePage(title: 'Shivalik Institute'),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  num isForceUpdate = 0;

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  @override
  void initState(){
    getVersionFromLocal();
    getAppVersion();
    super.initState();
  }

  void doSomeAsyncStuff() {
    SessionManager sessionManager = SessionManager();
    if (sessionManager.checkIsLoggedIn() ?? false)
    {
      if (NavigationService.notif_type.isNotEmpty)
      {
        var contentId = NavigationService.notif_type;


        print("CONTENT ID ==== ${contentId}");

        if (contentId == "event_scheduled")
        {
          Timer(const Duration(seconds: 3),(){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>  EventsDetailsScreen(EventList())),(route) => false);
          });

        }
        else if (contentId == "lecture_complete")
        {
          Timer(const Duration(seconds: 3),(){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>  LectureDetailsScreen(NavigationService.notif_id ?? '')),(route) => false);
          });

        }
        else if (contentId == "lecture_reminder")
        {
          Timer(const Duration(seconds: 3),(){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>  LectureDetailsScreen(NavigationService.notif_id ?? '')),(route) => false);
          });

        }
        else if (contentId == "lecture_scheduled")
        {
          Timer(const Duration(seconds: 3),(){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>  LectureDetailsScreen(NavigationService.notif_id ?? '')),(route) => false);
          });

        }
        else if (contentId == "material_uploaded")
        {
          Timer(const Duration(seconds: 3),(){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>  MaterialDetailScreen(ModuleList(), LectureList())),(route) => false);
          });

        }
        else if (contentId == "pedning_fees_reminder")
        {
          NavigationService.isForPendingFees = true;
          Timer(const Duration(seconds: 3),(){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>  const DashboardScreen()),(route) => false);
          });
        }
        else if (contentId == "submission_reminder")
        {
          Timer(const Duration(seconds: 3),(){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>  const DashboardScreen()),(route) => false);
          });
        }
        else if (contentId == "lecture_cancelled")
        {
          Timer(const Duration(seconds: 3),(){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LectureDetailsScreen(NavigationService.notif_id ?? '')),(route) => false);
          });
        }
        else if (contentId == "session_feedback")
        {
          Timer(const Duration(seconds: 3),(){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>  const DashboardScreen()),(route) => false);
          });
        }
        else
        {
          Timer(const Duration(seconds: 3),(){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>  const DashboardScreen()),(route) => false);
          });
        }
      }
      else
      {
        Timer(const Duration(seconds: 3),(){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>  const DashboardScreen()),(route) => false);
        });
      }

    }
    else
    {
      Timer(const Duration(seconds: 3),(){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginWithOTPScreen()),(route) => false);
      });
    }
  }

  Future<void> getVersionFromLocal() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

  getAppVersion() async {

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(appVersion);

    Map<String, String> jsonBody = {
      'device_type': Platform.isAndroid ? 'android' : 'ios',
    };
    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> apiResponse = jsonDecode(body);
    var dataResponse = AppVersionResponseModel.fromJson(apiResponse);

    if (statusCode == 200 && dataResponse.success == 1)
    {
      var verApp = int.parse(_packageInfo.version.toString().replaceAll(".", ''));
      var verLive = int.parse(dataResponse.version.toString().replaceAll(".", ''));
      print("verApp === $verApp");
      print("verLive ==== $verLive");

      isForceUpdate = dataResponse.forceUpdate == "0" ? 0 : 1;

      if (verLive > verApp)
      {
        if (Platform.isIOS)
          {
            showVersionMismatchDialogIos();
          }
        else
          {
            showVersionMismatchDialog();
          }
      }
      else
      {
        doSomeAsyncStuff();
      }
    }
    else
    {
      doSomeAsyncStuff();
    }
  }

  void showVersionMismatchDialog() {
    var titleText = "Upgrade";
    var messageText = "A new version of Shivalik Institute of Real Estate is ready for installation. Please upgrade to continue.";
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Text(titleText,style: const TextStyle(color: black,fontWeight: FontWeight.w500,fontSize: 16)),
        content: Text(messageText,style: const TextStyle(color: black,fontWeight: FontWeight.w400,fontSize: 14)),
        actions: <Widget>[
          Visibility(
            visible: isForceUpdate != 1,
            child: TextButton(
                onPressed: (){
                  doSomeAsyncStuff();
                  Navigator.pop(context);
                },
                child: const Text("Skip",style: TextStyle(color: black, fontSize: 16,fontWeight: FontWeight.w600),)
            ),
          ),
          TextButton(
              onPressed: () async {
                String appPackageName = _packageInfo.packageName;
                try
                {
                  if (Platform.isIOS)
                  {
                    if (await canLaunchUrl(Uri.parse("https://apps.apple.com/us/app/shivalik-institute/id6471340089")))
                    {
                      launchUrl(Uri.parse("https://apps.apple.com/us/app/shivalik-institute/id6471340089"),mode: LaunchMode.externalApplication);
                    }
                  }
                  else
                  {
                    if (await canLaunchUrl(Uri.parse("https://play.google.com/store/apps/details?id=$appPackageName")))
                    {
                      launchUrl(Uri.parse("https://play.google.com/store/apps/details?id=$appPackageName"),mode: LaunchMode.externalApplication);
                    }
                  }
                }
                catch (anfe)
                {
                  if (await canLaunchUrl(Uri.parse("https://play.google.com/store/apps/details?id=$appPackageName")))
                  {
                    launchUrl(Uri.parse("https://play.google.com/store/apps/details?id=$appPackageName"),mode: LaunchMode.externalApplication);
                  }
                }
              },
              child: const Text("Upgrade",style: TextStyle(color: black, fontSize: 16,fontWeight: FontWeight.w600),)
          )

        ],
      ),
    );
  }

  void showVersionMismatchDialogIos() {
    var titleText = "Upgrade";
    var messageText = "A new version of Shivalik Institute of Real Estate is ready for installation. Please upgrade to continue.";

    showCupertinoModalPopup<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(titleText,style: const TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 16)),
        content: Text(messageText,style: const TextStyle(color: black,fontWeight: FontWeight.w400,fontSize: 14)),
        actions: isForceUpdate == 1
            ? <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () async {
                  String appPackageName = _packageInfo.packageName;
                  try
                  {
                    if (Platform.isIOS)
                    {
                      if (await canLaunchUrl(Uri.parse("https://apps.apple.com/in/app/shivalik-institute/id6471340089")))
                      {
                        launchUrl(Uri.parse("https://apps.apple.com/in/app/shivalik-institute/id6471340089"),mode: LaunchMode.externalApplication);
                      }
                    }
                    else
                    {
                      if (await canLaunchUrl(Uri.parse("https://play.google.com/store/apps/details?id=$appPackageName")))
                      {
                        launchUrl(Uri.parse("https://play.google.com/store/apps/details?id=$appPackageName"),mode: LaunchMode.externalApplication);
                      }
                    }
                  }
                  catch (anfe)
                  {
                    if (await canLaunchUrl(Uri.parse("https://play.google.com/store/apps/details?id=$appPackageName")))
                    {
                      launchUrl(Uri.parse("https://play.google.com/store/apps/details?id=$appPackageName"));
                    }
                  }
                },
                child: const Text('Upgrade',style: TextStyle(color: Colors.green,fontWeight: FontWeight.w500,fontSize: 16)),
              ),
            ]
            : <Widget>[
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Skip',style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500,fontSize: 16)),
                ),
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () async {
                    String appPackageName = _packageInfo.packageName;
                    try
                    {
                      if (Platform.isIOS)
                      {
                        if (await canLaunchUrl(Uri.parse("https://apps.apple.com/in/app/shivalik-channel-partner-app/id1560302550")))
                        {
                          launchUrl(Uri.parse("https://apps.apple.com/in/app/shivalik-channel-partner-app/id1560302550"),mode: LaunchMode.externalApplication);
                        }
                      }
                      else
                      {
                        if (await canLaunchUrl(Uri.parse("https://play.google.com/store/apps/details?id=$appPackageName")))
                        {
                          launchUrl(Uri.parse("https://play.google.com/store/apps/details?id=$appPackageName"),mode: LaunchMode.externalApplication);
                        }
                      }
                    }
                    catch (anfe)
                    {
                      if (await canLaunchUrl(Uri.parse("https://play.google.com/store/apps/details?id=$appPackageName")))
                      {
                        launchUrl(Uri.parse("https://play.google.com/store/apps/details?id=$appPackageName"));
                      }
                    }
                  },
                  child: const Text('Upgrade',style: TextStyle(color: Colors.green,fontWeight: FontWeight.w500,fontSize: 16)),
                ),
              ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: white,
        elevation: 0,
      ),
      body: Center(
        child: Image.asset('assets/images/ic_sire_logo_splash.png', width: 300,height: 300,),
      ),
    );
  }
}
