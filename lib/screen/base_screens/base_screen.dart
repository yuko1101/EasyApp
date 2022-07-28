import 'package:flutter/cupertino.dart';

/// BaseScreen is a base class to create a screen.
abstract class BaseScreen extends StatelessWidget {
  const BaseScreen({
    this.previousPage,
    Key? key,
  }) : super(key: key);

  /// The previous page of the screen.
  /// If the `previousPage` is null, open the screen that was displayed before the current screen.
  final BaseScreen? previousPage;
}
