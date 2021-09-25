import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.url}) : super(key: key);
  final String url;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test App',
      home: MainPage(url: url),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.url),
      ),
    );
  }
}
