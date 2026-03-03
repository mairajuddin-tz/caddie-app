import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class OnboardingSlide {
  final String imagePath;
  final String heading;
  final String body;
  final bool showSkip;

  const OnboardingSlide({
    required this.imagePath,
    required this.heading,
    required this.body,
    required this.showSkip,
  });
}

const _slides = [
  OnboardingSlide(
    imagePath: 'assets/images/onboarding-slide1.jpg',
    heading: 'Golf, but make\nit competitive.',
    body: 'Play rounds with friends, talk trash, and turn every shot into a moment that matters.',
    showSkip: true,
  ),
  OnboardingSlide(
    imagePath: 'assets/images/onboarding-slide2.jpg',
    heading: 'Bet smarter with\nHootie Coins.',
    body: 'Use Hootie Coins to place friendly bets, challenge your group, and raise the stakes — without awkward money talk.',
    showSkip: true,
  ),
  OnboardingSlide(
    imagePath: 'assets/images/onboarding-slide3.jpg',
    heading: 'Play. Win.\nSettle instantly.',
    body: 'Track your rounds, see who\'s up or down, and settle scores in seconds.',
    showSkip: false,
  ),
];

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onFinish;
  const OnboardingScreen({super.key, required this.onFinish});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _skipToLast() {
    _controller.animateToPage(
      _slides.length - 1,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CaddieColors.background,
      body: Stack(
        children: [
          // ── Full-screen PageView: all content slides together
          PageView.builder(
            controller: _controller,
            itemCount: _slides.length,
            onPageChanged: (i) => setState(() => _currentIndex = i),
            itemBuilder: (context, index) {
              final slide = _slides[index];
              return _SlidePage(slide: slide, onGetStarted: widget.onFinish);
            },
          ),

          // ── Skip button (top-right overlay)
          if (_slides[_currentIndex].showSkip)
            Positioned(
              top: MediaQuery.of(context).padding.top + 16,
              right: CaddieSpacing.lg,
              child: GestureDetector(
                onTap: _skipToLast,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: CaddieColors.skipBg,
                    borderRadius: BorderRadius.circular(CaddieRadius.chip),
                  ),
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: CaddieColors.background,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ── Individual slide page (image + gradient + text + dots + button all slide as one)

class _SlidePage extends StatelessWidget {
  final OnboardingSlide slide;
  final VoidCallback onGetStarted;

  const _SlidePage({required this.slide, required this.onGetStarted});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bottomPad = MediaQuery.of(context).padding.bottom;

    return Stack(
      fit: StackFit.expand,
      children: [
        // Background image
        Image.asset(
          slide.imagePath,
          fit: BoxFit.cover,
        ),

        // Dark gradient overlay
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: size.height * 0.67,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.01, 0.34, 1.0],
                colors: [
                  CaddieColors.background.withAlpha(0),
                  CaddieColors.background.withAlpha(204),  // 80%
                  CaddieColors.background,
                ],
              ),
            ),
          ),
        ),

        // Bottom content
        Positioned(
          left: CaddieSpacing.lg,
          right: CaddieSpacing.lg,
          bottom: bottomPad + CaddieSpacing.xxl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Progress dots
              _ProgressDots(slide: slide),
              const SizedBox(height: CaddieSpacing.xl),

              // Heading
              Text(
                slide.heading,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                  color: CaddieColors.white,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 12),

              // Body
              Text(
                slide.body,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: CaddieColors.whiteSubtle,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: CaddieSpacing.xl),

              // Get Started button
              GestureDetector(
                onTap: onGetStarted,
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: CaddieColors.white,
                    borderRadius: BorderRadius.circular(CaddieRadius.button),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: CaddieColors.background,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Animated pill-shaped page indicator dots
class _ProgressDots extends StatelessWidget {
  final OnboardingSlide slide;
  const _ProgressDots({required this.slide});

  @override
  Widget build(BuildContext context) {
    final currentIndex = _slides.indexOf(slide);
    return Row(
      children: List.generate(_slides.length, (i) {
        final isActive = i == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.only(right: 6),
          width: isActive ? 44 : 12,
          height: 4,
          decoration: BoxDecoration(
            color: isActive ? CaddieColors.white : CaddieColors.whiteFaint,
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }
}
