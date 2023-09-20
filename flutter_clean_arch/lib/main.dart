import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_arch/core/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'posts App',
        theme: appTheme,
        home: Scaffold(
          appBar: AppBar(title: const Text('Posts')),
          body: const Center(child: Text('Hello world')),
        ));
  }
}
