import 'package:calc/ui/title_bar/title_bar.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart' as bw;
import 'package:flutter_acrylic/flutter_acrylic.dart' as fa;
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import 'bridge.dart';
import 'controllers/standard_keypad_controller.dart';
import 'pages/settings_page.dart';
import 'pages/standard_page.dart';
import 'ui/menu_button/menu_button.dart';
import 'ui/navigation_panel/navigation_panel.dart';

fa.WindowEffect windowEffect = fa.WindowEffect.disabled;
Color getScaffoldColor(fa.WindowEffect windowEffect) {
  Color color;
  switch (windowEffect) {
    case fa.WindowEffect.mica:
    case fa.WindowEffect.tabbed:
      color = Colors.transparent;
      break;
    case fa.WindowEffect.acrylic:
      color = const Color.fromRGBO(32, 32, 32, .75);
      break;
    default:
      color = const Color.fromRGBO(32, 32, 32, 1);
      break;
  }
  return color;
}

Future<void> reflectDeviceCapabilities() async {
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  WindowsDeviceInfo windowsInfo = await deviceInfoPlugin.windowsInfo;
  int buildNumber = windowsInfo.buildNumber;

  // Windows 10 [1803] or higher
  if (buildNumber >= 17134) {
    windowEffect = fa.WindowEffect.acrylic;
  }

  // Windows 11 [21H2] or higher
  if (buildNumber >= 22000) {
    windowEffect = fa.WindowEffect.mica;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await fa.Window.initialize();
  await reflectDeviceCapabilities();
  await fa.Window.setEffect(
    effect: windowEffect,
    dark: true,
  );
  await fa.Window.hideWindowControls();
  Get.lazyPut(() => StandardKeypadController());
  runApp(const GetApp());

  bw.doWhenWindowReady(() {
    const compactSize = Size(320, 518);
    bw.appWindow.minSize = compactSize;
    bw.appWindow.maxSize = compactSize;
    bw.appWindow.size = compactSize;
    MatematikFFI.initialize();
    bw.appWindow.show();
  });
}

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/standard',
  routes: [
    ShellRoute(
      //navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return ScaffoldWithNavBar(state: state, child: child);
      },
      routes: [
        GoRoute(
          path: '/standard',
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            child: const StandardPage(),
          ),
        ),
        GoRoute(
          path: '/settings',
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            child: const SettingsPage(),
          ),
        ),
        GoRoute(
          path: '/hov',
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            child: FractionallySizedBox(
                widthFactor: .8,
                child: NavigationPanel(
                  close: (String settings) {},
                )),
          ),
        ),
      ],
    ),
  ],
);

class ScaffoldWithNavBar extends StatefulWidget {
  final Widget child;
  final GoRouterState state;
  const ScaffoldWithNavBar(
      {super.key, required this.child, required this.state});

  @override
  State<StatefulWidget> createState() {
    return _SWNBS();
  }
}

class _SWNBS extends State<ScaffoldWithNavBar> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getScaffoldColor(windowEffect),
      body: Column(
        children: [
          const TitleBar(),
          Expanded(
            child: Stack(
              children: [
                widget.child,
                isOpen
                    ? FractionallySizedBox(
                        widthFactor: .8,
                        child: NavigationPanel(close: (value) {
                          context.go(value);
                          setState(() {
                            isOpen = !isOpen;
                          });
                        }),
                      )
                    : Container(),
                MenuButton(() {
                  setState(() {
                    isOpen = !isOpen;
                  });
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GetApp extends StatefulWidget {
  const GetApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return GetAppState();
  }
}

var standardPage = const StandardPage();
var settingsPage = const SettingsPage();

class GetAppState extends State<GetApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(primarySwatch: Colors.purple, useMaterial3: true),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
