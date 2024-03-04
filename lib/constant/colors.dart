import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

var bottomWidgetKey = GlobalKey<State<BottomNavigationBar>>();

bool isDashboardLoad = false;
FirebaseAnalytics analytics = FirebaseAnalytics.instance;

const Color white= Color(0xffffffff);
const Color black= Color(0xff000000);
const Color gray = Color(0xffD3DADC);
const Color grayNew = Color(0xffECECEC);
const Color grayGradient = Color(0xfff1f1f1);
const Color grayButton = Color(0xffF3F3F3);
const Color grayLight= Color(0xffe0e0e0);
const Color graySemiDark= Color(0xffaaa9a3);
const Color grayDark= Color(0xff72716d);
const Color grayDarkNew= Color(0xff737373);
const Color lableHint= Color(0xff3A3A3A);
const Color appBg= Color(0xffffffff);
const Color searchColor = Color(0Xfff6f6f6);
const Color blackConst= Color(0xff000000);
const Color lightPink= Color(0xffFFF6F5);
const Color lightPinkBorder = Color(0xffF6EEEC);
const Color lightPinkText = Color(0xffC47D83);
const Color progress= Color(0xffD9D9D9);
const Color greenBg= Color(0x4200a814);
const Color redBg= Color(0x42FF0000);
const Color brandColor= Color(0xFFe31e24);
const Color lightGrey = Color(0xfff3f2f2);
const chatBoxBg = Color(0xfff6f6f6);