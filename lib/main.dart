import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/style.dart';

import 'package:flutter_application_1/data/repo/banner_repositroy.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    banner.getBanner().then((value) {
        debugPrint(value.toString());
    }).catchError((e){
 debugPrint(e.toString());
    });
    const TextStyle defaultTextStyle = TextStyle(
      fontFamily: 'Vazir'
      
    );
    return MaterialApp(
    
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
   
       textTheme:  TextTheme(
        bodyMedium: defaultTextStyle,
        titleLarge: defaultTextStyle.copyWith(
          fontWeight: FontWeight.w700
        ) , 
        bodySmall:  defaultTextStyle.apply(
          color: LightThemeColors.secondaryTextColor,
        )
       ) , 
       colorScheme: const ColorScheme.light(
        primary: LightThemeColors.primaryColor,
        secondary: LightThemeColors.secondaryColor,
        onPrimary: Colors.white,
       )
      ),
      home: const HemeScreen(),
    );
  }
}

class HemeScreen extends StatelessWidget {
  const HemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('سلام خوبی منم خوبم'),),
    );
  }
}