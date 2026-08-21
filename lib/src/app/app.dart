import 'package:dots_in/src/app/app_pages.dart';
import 'package:dots_in/src/app/bindings/initial_binding.dart';
import 'package:dots_in/src/app/routes/app_routes.dart';
import 'package:dots_in/src/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dots_In',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      initialRoute: AppRoutes.home,
      initialBinding: InitialBinding(),
      getPages: AppPages.pages,
      unknownRoute: AppPages.unknownRoute,
    );
  }
}
