import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rare_crew_test/firebase_options.dart';
import 'package:rare_crew_test/shared_resources/routes_manager.dart';
import 'package:rare_crew_test/shared_resources/theme_manager.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const ProviderScope(child:MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rare Test',
      onGenerateRoute: RouteGenerator.getRoute,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splashRoute,
      darkTheme: getAppTheme(),
      themeMode: ThemeMode.dark,
    );
  }
}
