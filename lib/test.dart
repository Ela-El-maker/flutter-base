import 'package:flutter/material.dart';
import 'package:initial/app/app.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  void updateAppState()
  {
    MyApp.instance.appState =10;
  }

  void getAppstate()
  {
    print(MyApp.instance.appState);// 10
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}