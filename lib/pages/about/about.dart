import 'package:flutter/material.dart';
import 'setting_page.dart';

class AboutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _AboutPage();
}

class _AboutPage extends State<AboutPage> {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: SettingPage());
  }
}