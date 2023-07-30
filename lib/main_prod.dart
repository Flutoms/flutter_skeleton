import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


import 'dependency/app_config/app_config.dart';
import 'dependency/get_it.dart';
// import 'firebase_options.dart';
import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies(AppConfig(
    appName: 'Dado Food',
    baseUrl: 'https://api.dado.ng/api/v1',
    isDev: false,
  ));
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await dotenv.load(fileName: '.env');

  // PushNotificationService()
  //   ..createChannel()
  //   ..setNotifications();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const Index());
  });
}
