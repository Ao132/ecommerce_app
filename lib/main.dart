import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'presentation/config/themes.dart';
import 'presentation/config/router.dart' as routes;
import 'presentation/config/route_constantse.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 
  @override
  Widget build(BuildContext context) {
    setState(() {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    });
    return ScreenUtilInit(
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Themes.lightTheme,
        initialRoute: Routes.homePage,
        onGenerateRoute: routes.controller,
      ),
    );
  }
}
