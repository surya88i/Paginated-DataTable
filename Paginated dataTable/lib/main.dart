import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'homePage.dart';                                      
void main(){
  debugDefaultTargetPlatformOverride=TargetPlatform.fuchsia;
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor:Colors.pink,
      ),
      home:MyHomePage(),
    );
  }
}