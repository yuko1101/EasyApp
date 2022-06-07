<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

# EasyApp
A Flutter library for building apps with ease.

## Features

- Easy JSON Config File
- Easy Multiple Language Support
- Easy Page Navigation
- Easy Detect Network Connection
- Easy Responsive Design System
- Easy In-App Notification

## Getting started

Install the package following the [installation](https://pub.dev/packages/easy_app/install)

### Initialize
```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Make sure WidgetsFlutterBinding is initialized.
  await EasyApp.initialize(
    homeScreen: HomeScreen(), // Your home screen which extends from BaseScreen. 
    languages: [], // Supported languages. Like ['en_US', 'ja_JP'].
    activateConnectionChecker: true, // Activate network connection checker.
  );
  runApp(const MyApp()); // Run your app
}
```

### Set-up Main Screen
Set-up your app with Main Screen.
```dart
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy App Example',
      home: MainScreen(
        sideMenu: SideMenu(
          title: const Text("Easy App"),
          // app icon is displayed at the left of the title.
          appIcon: const Icon(Icons.ac_unit),
          backgroundColor: Colors.yellow,
          // menu items.
          items: [
            SideMenuItem(
              title: const Text("Home"),
              // icon is displayed at the left of the title.
              icon: const Icon(Icons.home),
              onPressed: () {
                if (EasyApp.currentScreen is HomeScreen) return; // if already on HomeScreen, do nothing.
                EasyApp.pushPage(context, HomeScreen()); // push HomeScreen.
              },
              backgroundColor: Colors.transparent,
            ), // SideMenuItem
            SideMenuItem(
              title: const Text("Alarm"),
              // icon is displayed at the left of the title.
              icon: const Icon(Icons.access_alarm),
              onPressed: () {
                // AlarmScreen extends from BaseScreen.
                if (EasyApp.currentScreen is AlarmScreen) return; // if already on AlarmScreen, do nothing.
                EasyApp.pushPage(context, AlarmScreen()); // push AlarmScreen.
              },
              backgroundColor: Colors.transparent,
            ), // SideMenuItem
          ], // items
        ), // SideMenu
      ), // MainScreen
    );
  }
}
```

### Create a BaseScreen
You can create a BaseScreen as follows.
```dart
class HomeScreen extends BaseScreen {
  HomeScreen()
      : super(
    appBar: AppBar(
      title: const Text('Home'),
    ),
    screen: const Center(
      child: Text('Home Screen'),
    ),
  );
}
```

## Usage

### Config File
You can create a JSON Config File as follows.
```dart
// Load JSON file.
final ConfigFile configFile = await ConfigFile(File("${EasyApp.localPath}/config.json"),
// default value
  {
    "fruits": ["apple", "banana", "orange"],
    "counts": 3,
  }
).load();

// Get value.
final List<String> fruits = (configFile.getValue("fruits") as List).map((fruit) => fruit as String).toList();
int counts = configFile.getValue("counts") as int;

// Update data.
fruits.add("grape");
counts = fruits.length;

// Set value and save.
configFile.set(key: "fruits", value: fruits);
configFile.set(key: "counts", value: counts);
await configFile.save();

// Or, you can set value and save in one line.
await configFile.set(key: "fruits", value: fruits).set(key: "counts", value: counts).save();
```

## Additional information

See more examples in the [example](https://pub.dev/packages/easy_app/example)
Also You can find the source code of this package at [Github](https://github.com/yuko1101/EasyApp).
Change logs are available [here](https://pub.dev/packages/easy_app/changelog)
