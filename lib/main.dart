import 'package:flutter/material.dart';
import 'package:newss/screens/Home_Screen.dart';
import 'package:newss/screens/source_news.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName : (context) => HomeScreen(),
        SourceNews.routeName : (context) => SourceNews(),
      },
    );
  }
}
