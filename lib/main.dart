import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hourglass/data/repository.dart';

import 'data/network/api_client.dart';
import 'features/main/main_view.dart';

void main() {
  setupDI();
  runApp(const MyApp());
}

void setupDI() {
  final getIt = GetIt.instance;
  getIt.registerSingleton<ApiClient>(ApiClient(Dio()));
  getIt.registerSingleton<Repository>(Repository());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hourglass',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MainView(),
    );
  }
}
