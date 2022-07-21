import 'package:fluent_ui/fluent_ui.dart';

class MyThemes {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    // acrylicBackgroundColor: Colors.black.withOpacity(0.1),
  );

  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: const Color.fromARGB(255, 65, 64, 63),
      activeColor: const Color.fromARGB(255, 65, 64, 63),
      acrylicBackgroundColor: const Color.fromARGB(255, 65, 64, 63),
      navigationPaneTheme: NavigationPaneThemeData(
        backgroundColor: const Color.fromARGB(255, 65, 64, 63),
        highlightColor: Colors.blue.withOpacity(0.8),
        iconPadding: const EdgeInsets.all(8),
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 200),
        labelPadding: const EdgeInsets.all(0),
      ));
}
