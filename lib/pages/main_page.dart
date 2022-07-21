import 'package:bloatwareremover/pages/home_page.dart';
import 'package:fluent_ui/fluent_ui.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Color? iconColor =
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? Colors.white
            : null;

    return NavigationView(
      contentShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(double.infinity),
      ),
      pane: NavigationPane(
          selected: currentIndex,
          displayMode: PaneDisplayMode.compact,
          onChanged: (value) => setState(() => currentIndex = value),
          items: [
            PaneItem(
              icon: Icon(FluentIcons.home, color: iconColor),
              title: const Text('Home'),
            ),
            PaneItem(
              icon: Icon(FluentIcons.settings, color: iconColor),
              title: const Text('Settings'),
            ),
            PaneItem(
              icon: Icon(FluentIcons.help, color: iconColor),
              title: const Text('Help'),
            ),
          ]),
      content: NavigationBody(
        index: currentIndex,
        transitionBuilder: (child, animation) =>
            DrillInPageTransition(animation: animation, child: child),
        children: const [
          HomePage(),
          Text('Settings'),
          Text('Help'),
        ],
      ),
    );
  }
}
