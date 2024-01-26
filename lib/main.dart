import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/style.dart';

import 'package:flutter_application_1/data/repo/coomet_repositroy.dart';
import 'package:flutter_application_1/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    comments.getComment(9).then((value) {
      debugPrint(value.toString());
    }).catchError((e) {
      debugPrint(e.toString());
    });
    const TextStyle defaultTextStyle = TextStyle(fontFamily: 'Vazir');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: LightThemeColors.secondaryColor,
          ),
          fontFamily: 'Vazir',
          textTheme: TextTheme(
              titleMedium: defaultTextStyle.apply(
                  color: LightThemeColors.secondaryTextColor),
              labelLarge: defaultTextStyle,
              bodyMedium: defaultTextStyle,
              titleLarge:
                  defaultTextStyle.copyWith(fontWeight: FontWeight.w700),
              bodySmall: defaultTextStyle.apply(
                color: LightThemeColors.secondaryTextColor,
              )),
          colorScheme: const ColorScheme.light(
            primary: LightThemeColors.primaryColor,
            secondary: LightThemeColors.secondaryColor,
            onPrimary: Colors.white,
          )),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: HomeScreen(),
      ),
    );
  }
}
