import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'pages/dashboard_page.dart';
import 'pages/login_page.dart';
import 'pages/learning_hub_page.dart';
import 'pages/challenges_page.dart';
import 'pages/forum_page.dart';
import 'pages/projects_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  bool get useLightMode {
    switch (_themeMode) {
      case ThemeMode.system:
        return SchedulerBinding.instance.window.platformBrightness ==
            Brightness.light;
      case ThemeMode.light:
        return true;
      case ThemeMode.dark:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GTech RCPIT',
      theme: ThemeData(
        tabBarTheme: const TabBarTheme(
          labelColor: Color(0xFF001A66),
          unselectedLabelColor: Colors.grey,
          indicatorColor: Color(0xFF001A66),
        ),
        useMaterial3: true,
        brightness: Brightness.light,
        fontFamily: 'Rubik',
      ),
      darkTheme: ThemeData(
        tabBarTheme: const TabBarTheme(
          labelColor: Color(0xFF001A66),
          unselectedLabelColor: Colors.grey,
          indicatorColor: Color(0xFF001A66),
        ),
        useMaterial3: true,
        brightness: Brightness.dark,
        fontFamily: 'Rubik',
      ),
      themeMode: _themeMode,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => MyHomePage(
              title: 'GTech RCPIT',
              useLightMode: useLightMode,
              handleBrightnessChange: (value) {
                setState(() {
                  _themeMode = value ? ThemeMode.light : ThemeMode.dark;
                });
              },
            ),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLight =
        SchedulerBinding.instance.window.platformBrightness == Brightness.light;

    return Scaffold(
      backgroundColor: isLight ? Colors.white : Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 120,
              height: 120,
            ),
            const SizedBox(height: 24),
            const Text(
              'GTech RCPIT',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF001A66),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.handleBrightnessChange,
    required this.useLightMode,
  });

  final String title;
  final bool useLightMode;
  final void Function(bool useLightMode) handleBrightnessChange;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  int _counter = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List<Widget> _pages = <Widget>[
    const ForumPage(),
    const ProjectsPage(),
    const ChallengesPage(),
    const LearningHubPage(),
    Center(child: Text("Profile")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          _BrightnessButton(
            handleBrightnessChange: widget.handleBrightnessChange,
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF001A66),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/home.svg',
              width: 24,
              height: 24,
              colorFilter:
                  const ColorFilter.mode(Color(0xFF001A66), BlendMode.srcIn),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/projects.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/projects.svg',
              width: 24,
              height: 24,
              colorFilter:
                  const ColorFilter.mode(Color(0xFF001A66), BlendMode.srcIn),
            ),
            label: 'Projects',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/challenges.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/challenges.svg',
              width: 24,
              height: 24,
              colorFilter:
                  const ColorFilter.mode(Color(0xFF001A66), BlendMode.srcIn),
            ),
            label: 'Challenges',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/learning.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/learning.svg',
              width: 24,
              height: 24,
              colorFilter:
                  const ColorFilter.mode(Color(0xFF001A66), BlendMode.srcIn),
            ),
            label: 'Learning',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/profile.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/profile.svg',
              width: 24,
              height: 24,
              colorFilter:
                  const ColorFilter.mode(Color(0xFF001A66), BlendMode.srcIn),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _BrightnessButton extends StatelessWidget {
  const _BrightnessButton({
    required this.handleBrightnessChange,
    this.showTooltipBelow = true,
  });

  final void Function(bool) handleBrightnessChange;
  final bool showTooltipBelow;

  @override
  Widget build(BuildContext context) {
    final isBright = Theme.of(context).brightness == Brightness.light;
    return Tooltip(
      preferBelow: showTooltipBelow,
      message: 'Toggle brightness',
      child: IconButton(
        icon: isBright
            ? const Icon(Icons.dark_mode_outlined)
            : const Icon(Icons.light_mode_outlined),
        onPressed: () => handleBrightnessChange(!isBright),
      ),
    );
  }
}
