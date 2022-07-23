import 'package:easy_app/screen/page_manager.dart';
import 'package:easy_app/screen/base_screens/scaffold_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:easy_app/easy_app.dart';

void main() {
  // test('adds one to input values', () {
  //   final calculator = Calculator();
  //   expect(calculator.addOne(2), 3);
  //   expect(calculator.addOne(-7), -6);
  //   expect(calculator.addOne(0), 1);
  // });

  test("test", () async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyApp.initialize(homeScreen: HomeScreen());
    expect(PageManager.homeScreen.runtimeType, HomeScreen);
  });

  test("test2", () async {});
}

class HomeScreen extends ScaffoldScreen {
  HomeScreen() : super(body: Container());
}
