import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shivalik_institute/screen/DashboardScreen.dart';
import 'package:shivalik_institute/screen/LoginWithOtpScreen.dart';
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

import 'common_widget/common_widget.dart';
import 'constant/colors.dart';
import 'constant/global_context.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SessionManagerMethods.init();

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
                borderSide:  BorderSide(width: 1, style: BorderStyle.solid, color: black)),
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
          fontFamily: 'Poppins',
          textSelectionTheme: TextSelectionThemeData(selectionColor: black.withOpacity(0.3)),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: createMaterialColor(white)).copyWith(secondary: white)
      ),
      navigatorKey: NavigationService.navigatorKey,
      home: const MyHomePage(title: 'Shivalik Institute'),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
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

  @override
  void initState(){

    SessionManager sessionManager = SessionManager();
    if (sessionManager.checkIsLoggedIn() ?? false)
    {
      Timer(const Duration(seconds: 3),(){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>  DashboardScreen()),(route) => false);
      });
    }
    else
    {
      Timer(const Duration(seconds: 3),(){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginWithOTPScreen()),(route) => false);
      });
    }

    super.initState();
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
        child:  Image.asset('assets/images/ic_shivalik_ins_logo.png', width: 180,height: 180,),
      ),
    );
  }
}
