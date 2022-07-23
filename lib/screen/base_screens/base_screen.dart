/// BaseScreen is a base class to create a screen.
class BaseScreen {
  BaseScreen({
    this.previousPage,
  });

  /// The previous page of the screen.
  /// If the previous page is null, open the home screen instead of closing app.
  final BaseScreen? previousPage;
}
