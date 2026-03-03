import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onFinish;
  const SplashScreen({super.key, required this.onFinish});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Transition to onboarding after 2.4 seconds
    Future.delayed(const Duration(milliseconds: 2400), () {
      if (mounted) widget.onFinish();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: Stack(
        children: [
          // ── Sky/cloud background (top, 65% height)
          Positioned(
            top: 0,
            left: -(size.width * 0.1),
            right: -(size.width * 0.1),
            height: size.height * 0.65,
            child: Image.asset(
              'assets/images/splash-bg.jpg',
              fit: BoxFit.cover,
            )
            .animate()
            .fadeIn(duration: 600.ms, curve: Curves.easeOut),
          ),

          // ── White fade band (center)
          Positioned.fill(
            child: Center(
              child: Container(
                height: size.height * 0.45,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0, 0.31, 0.69, 1.0],
                    colors: [
                      Colors.transparent,
                      Colors.white,
                      Colors.white,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Golf club + ball (bottom, slides up)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Image.asset(
              'assets/images/splash-golf.png',
              fit: BoxFit.fitWidth,
            )
            .animate()
            .slideY(
              begin: 0.3,
              end: 0,
              delay: 200.ms,
              duration: 800.ms,
              curve: Curves.easeOut,
            )
            .fadeIn(delay: 200.ms, duration: 400.ms),
          ),

          // ── Caddie logo (icon + wordmark), centred
          Positioned.fill(
            child: Align(
              alignment: const Alignment(0, -0.16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/caddie-icon.png',
                    width: 48,
                    height: 48,
                  ),
                  const SizedBox(width: 11),
                  Image.asset(
                    'assets/images/caddie-wordmark.png',
                    height: 41,
                  )
                  .animate()
                  .slideX(
                    begin: 0.3,
                    end: 0,
                    delay: 850.ms,
                    duration: 350.ms,
                    curve: Curves.easeOut,
                  )
                  .fadeIn(delay: 850.ms, duration: 350.ms),
                ],
              )
              .animate()
              .scaleXY(
                begin: 0.7,
                end: 1.0,
                delay: 600.ms,
                duration: 500.ms,
                curve: Curves.easeOut,
              )
              .fadeIn(delay: 600.ms, duration: 400.ms),
            ),
          ),
        ],
      ),
    );
  }
}
