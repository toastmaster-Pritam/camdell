
import 'package:camdell/core/route/route_pages.dart';
import 'package:camdell/core/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Camdell',
        initialRoute: AppRoute.splash,
        getPages: Routes.routes,
     
    );
  }
}
