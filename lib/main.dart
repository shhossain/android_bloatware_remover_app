import 'dart:io';
import 'package:bloatwareremover/mythems.dart';
import 'package:bloatwareremover/pages/main_page.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:window_size/window_size.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    setWindowMaxSize(const Size(1280, 720));
    setWindowMinSize(const Size(800, 600));
  }

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      debugShowCheckedModeBanner: false,
      title: 'Fluent UI',
      themeMode: ThemeMode.system,
      darkTheme: MyThemes.darkTheme,
      theme: MyThemes.lightTheme,
      home: const MainScreen(),
    );
  }
}
