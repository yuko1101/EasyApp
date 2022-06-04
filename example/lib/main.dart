import 'package:easy_app/easy_app.dart';
import 'package:easy_app/screen/base_screen.dart';
import 'package:easy_app/screen/drawer.dart';
import 'package:easy_app/screen/main_screen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyApp.initialize(
    homeScreen: HomeScreen(),
    languages: []
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy App Example',
      home: MainScreen(
          sideMenu: SideMenu(
            title: const Text("Easy App"),
            appIcon: const Icon(Icons.ac_unit),
            items: [
              SideMenuItem(
                title: const Text("Home"),
                icon: const Icon(Icons.home),
                onPressed: () {
                  if (EasyApp.currentScreen is HomeScreen) return;
                  EasyApp.pushPage(context, HomeScreen());
                },
              ),
              SideMenuItem(
                  title: const Text("Alarm"),
                  icon: const Icon(Icons.access_alarm),
                  onPressed: () {
                    if (EasyApp.currentScreen is AlarmScreen) return;
                    EasyApp.pushPage(context, AlarmScreen());
                  }
              )

            ],
          )
      )
    );
  }
}


class HomeScreen extends BaseScreen {
  HomeScreen() : super(
    appBar: AppBar(
      title: const Text('Home'),
    ),
    screen: const Center(
      child: Text('Home Screen'),
    )
  );
}

class AlarmScreen extends BaseScreen {
  AlarmScreen() : super(
    appBar: AppBar(
      title: const Text('Alarm'),
    ),
    screen: const Center(
      child: Text('Alarm Screen'),
    )
  );
}