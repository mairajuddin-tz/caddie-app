import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/otp_screen.dart';
import 'screens/auth/name_entry_screen.dart';
import 'screens/home/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const CaddieApp());
}

class CaddieApp extends StatelessWidget {
  const CaddieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caddie',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const _RootView(),
    );
  }
}

// ── App navigation state

enum _Screen { splash, onboarding, login, otp, nameEntry, home }

class _RootViewState extends State<_RootView> {
  _Screen _screen = _Screen.splash;
  String _phone = '';
  String _name = '';

  void _navigate(_Screen next, {String phone = '', String name = ''}) {
    setState(() {
      _screen = next;
      if (phone.isNotEmpty) _phone = phone;
      if (name.isNotEmpty) _name = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      transitionBuilder: (child, animation) {
        switch (_screen) {
          case _Screen.splash:
          case _Screen.onboarding:
            return FadeTransition(opacity: animation, child: child);
          default:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: child,
            );
        }
      },
      child: _buildScreen(),
    );
  }

  Widget _buildScreen() {
    switch (_screen) {
      case _Screen.splash:
        return SplashScreen(
          key: const ValueKey('splash'),
          onFinish: () => _navigate(_Screen.onboarding),
        );
      case _Screen.onboarding:
        return OnboardingScreen(
          key: const ValueKey('onboarding'),
          onFinish: () => _navigate(_Screen.login),
        );
      case _Screen.login:
        return LoginScreen(
          key: const ValueKey('login'),
          onContinue: (phone) => _navigate(_Screen.otp, phone: phone),
          onBack: () => _navigate(_Screen.onboarding),
        );
      case _Screen.otp:
        return OtpScreen(
          key: const ValueKey('otp'),
          phoneNumber: _phone.isEmpty ? '+1 (555) 000-0000' : _phone,
          onVerified: () => _navigate(_Screen.nameEntry),
          onBack: () => _navigate(_Screen.login),
        );
      case _Screen.nameEntry:
        return NameEntryScreen(
          key: const ValueKey('nameEntry'),
          onContinue: (name) => _navigate(_Screen.home, name: name),
          onBack: () => _navigate(_Screen.otp),
        );
      case _Screen.home:
        return HomeScreen(
          key: const ValueKey('home'),
          isFirstTimeUser: true,
          userName: _name.isEmpty ? 'Golfer' : _name,
        );
    }
  }
}

class _RootView extends StatefulWidget {
  const _RootView();

  @override
  State<_RootView> createState() => _RootViewState();
}
