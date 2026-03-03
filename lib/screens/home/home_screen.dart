import 'package:flutter/material.dart';
import '../../theme/theme.dart';

// Figma asset URLs (valid 7 days from generation)
const _kCalendarIcon =
    'https://www.figma.com/api/mcp/asset/5020f2ba-e2a2-4e3b-8ed4-4f960e4b0512';
const _kFlagPinIcon =
    'https://www.figma.com/api/mcp/asset/aa7ad5eb-ca83-4bf2-b0ff-8a8875a19b9d';
const _kCaddyIcon =
    'https://www.figma.com/api/mcp/asset/5efbca1f-53af-41ba-90da-8f20d74d66b5';
const _kAddUserIcon =
    'https://www.figma.com/api/mcp/asset/2163464c-7993-4898-bd2b-77ef36a0ada9';
const _kNotifIcon =
    'https://www.figma.com/api/mcp/asset/bd25b6bb-d4f0-4ab2-be2b-ba0089897e46';
const _kHamburgerIcon =
    'https://www.figma.com/api/mcp/asset/4db10f00-d132-4cbd-bd5c-8018e8224784';
const _kCaddieAvatar =
    'https://www.figma.com/api/mcp/asset/d2c0f67b-b728-4d2b-bd35-abbcd2eb689f';
const _kNemesisPhoto =
    'https://www.figma.com/api/mcp/asset/fc129555-9dc1-4683-ba2c-ad3972486fbd';
const _kUpArrowIcon =
    'https://www.figma.com/api/mcp/asset/08aac801-202d-4e8d-b9d0-f158738c4798';
const _kFlashIcon =
    'https://www.figma.com/api/mcp/asset/35c575a2-ef2c-41e7-b63b-93bfcb545376';
const _kInviteIcon =
    'https://www.figma.com/api/mcp/asset/a44f94bc-43d3-4669-b190-32766c3143ba';
const _kRivalsIcon =
    'https://www.figma.com/api/mcp/asset/ffc2a063-6fde-41da-90e7-5bb06a2626e4';
const _kFirstRoundIcon =
    'https://www.figma.com/api/mcp/asset/f5003647-e135-49ce-9e26-45ed66791f55';

// ── Root screen ────────────────────────────────────────────────────────────────

class HomeScreen extends StatelessWidget {
  final bool isFirstTimeUser;
  final String userName;

  const HomeScreen({
    super.key,
    this.isFirstTimeUser = false,
    this.userName = 'Mairajuddin',
  });

  @override
  Widget build(BuildContext context) {
    final safePad = MediaQuery.of(context).padding;
    final headerHeight = safePad.top + 182.0;

    return Scaffold(
      backgroundColor: CaddieColors.authBg,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 90),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HeroHeader(
                  height: headerHeight,
                  safePad: safePad,
                  userName: userName,
                  isFirstTimeUser: isFirstTimeUser,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: isFirstTimeUser
                        ? _ftuContent()
                        : _existingUserContent(),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 22,
            left: 0,
            right: 0,
            child: Center(child: _AICaddieBar()),
          ),
        ],
      ),
    );
  }

  List<Widget> _ftuContent() => [
        const _WelcomeBanner(),
        const SizedBox(height: 24),
        const _FirstRoundCard(),
        const SizedBox(height: 24),
        const _QuickActionsSection(),
        const SizedBox(height: 24),
        const _BankRollCard(isFTU: true),
        const SizedBox(height: 24),
        const _FindRivalsCard(),
        const SizedBox(height: 24),
        const _QuickTipCard(),
        const SizedBox(height: 24),
      ];

  List<Widget> _existingUserContent() => [
        const _UpcomingGameCard(),
        const SizedBox(height: 24),
        const _QuickActionsSection(),
        const SizedBox(height: 24),
        const _OverviewSection(),
        const SizedBox(height: 24),
        const _BankRollCard(isFTU: false),
        const SizedBox(height: 24),
        const _NemesisCard(),
        const SizedBox(height: 24),
        const _RecentRoundsCard(),
        const SizedBox(height: 24),
      ];
}

// ── Hero header ────────────────────────────────────────────────────────────────

class _HeroHeader extends StatelessWidget {
  final double height;
  final EdgeInsets safePad;
  final String userName;
  final bool isFirstTimeUser;

  const _HeroHeader({
    required this.height,
    required this.safePad,
    required this.userName,
    required this.isFirstTimeUser,
  });

  @override
  Widget build(BuildContext context) {
    final whiteStart = height - 52.0;

    return SizedBox(
      height: height,
      child: Stack(
        children: [
          // Dark base
          Positioned.fill(
            child: Container(color: const Color(0xFF162D26)),
          ),
          // Golf photo at 40% opacity
          Positioned.fill(
            child: Opacity(
              opacity: 0.4,
              child: Image.asset(
                'assets/images/splash-bg.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Radial gradient overlay
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0, -0.4),
                  radius: 1.3,
                  colors: [
                    const Color(0xFF122821).withAlpha(77),
                    const Color(0xFF122821),
                  ],
                  stops: const [0.002, 1.0],
                ),
              ),
            ),
          ),
          // White rounded tab at bottom
          Positioned(
            top: whiteStart,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: CaddieColors.authBg,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
            ),
          ),
          // Header bar
          Positioned(
            top: safePad.top + 6,
            left: 20,
            right: 20,
            child: _HeaderBar(userName: userName),
          ),
          // AI message
          Positioned(
            top: safePad.top + 68,
            left: 20,
            right: 20,
            child: _AIMessage(isFirstTimeUser: isFirstTimeUser),
          ),
        ],
      ),
    );
  }
}

class _HeaderBar extends StatelessWidget {
  final String userName;

  const _HeaderBar({required this.userName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello,',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withAlpha(128),
                  height: 1.43,
                ),
              ),
              Text(
                userName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            _CircleIconBtn(networkSrc: _kNotifIcon, fallback: Icons.notifications_outlined, showBadge: true),
            const SizedBox(width: 20),
            _CircleIconBtn(networkSrc: _kHamburgerIcon, fallback: Icons.menu),
          ],
        ),
      ],
    );
  }
}

class _CircleIconBtn extends StatelessWidget {
  final String networkSrc;
  final IconData fallback;
  final bool showBadge;

  const _CircleIconBtn({
    required this.networkSrc,
    required this.fallback,
    this.showBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(26),
        shape: BoxShape.circle,
      ),
      child: Stack(
        children: [
          Center(
            child: Image.network(
              networkSrc,
              width: 20,
              height: 20,
              errorBuilder: (_, __, ___) =>
                  Icon(fallback, size: 20, color: Colors.white),
            ),
          ),
          if (showBadge)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: const Color(0xFFBE123C),
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: const Color(0xFF013334), width: 0.55),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _AIMessage extends StatelessWidget {
  final bool isFirstTimeUser;

  const _AIMessage({required this.isFirstTimeUser});

  @override
  Widget build(BuildContext context) {
    if (isFirstTimeUser) {
      return RichText(
        text: const TextSpan(
          style: TextStyle(
              fontSize: 14, color: Color(0xFFF5F5F5), height: 1.71),
          children: [
            TextSpan(text: "I'm your "),
            TextSpan(
              text: 'AI Caddie',
              style: TextStyle(color: Color(0xFF7FF472)),
            ),
            TextSpan(
                text:
                    " — I'll track your game and help you win smarter."),
          ],
        ),
      );
    }
    return RichText(
      text: const TextSpan(
        style:
            TextStyle(fontSize: 14, color: Color(0xFFF5F5F5), height: 1.71),
        children: [
          TextSpan(text: 'Your putting '),
          TextSpan(
            text: 'average is',
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Color(0xFF7FF472)),
          ),
          TextSpan(text: ' '),
          TextSpan(
            text: '2.4',
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Color(0xFF7FF472)),
          ),
          TextSpan(
              text:
                  ". I've seen better touches from a sledgehammer. Try aiming for the hole this time."),
        ],
      ),
    );
  }
}

// ── Floating AI Caddie bar ─────────────────────────────────────────────────────

class _AICaddieBar extends StatelessWidget {
  const _AICaddieBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(204),
        borderRadius: BorderRadius.circular(76),
        border: Border.all(color: Colors.white),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 34,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: Image.network(
              _kCaddieAvatar,
              width: 36,
              height: 36,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  gradient: greenGradient,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.sports_golf,
                    size: 18, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'Say Anything...',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF001510),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Shared: Quick Actions ──────────────────────────────────────────────────────

class _QuickActionsSection extends StatelessWidget {
  const _QuickActionsSection();

  static const _actions = [
    _QuickAction(icon: _kCalendarIcon, label: 'Plan a Game', fallback: Icons.calendar_today_outlined),
    _QuickAction(icon: _kFlagPinIcon, label: 'Golf Courses', fallback: Icons.golf_course),
    _QuickAction(icon: _kCaddyIcon, label: 'Caddy Booking', fallback: Icons.sports_golf),
    _QuickAction(icon: _kAddUserIcon, label: 'Invite Friends', fallback: Icons.person_add_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Quick Actions',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF001510),
                    height: 1.5)),
            Text('View All',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: CaddieColors.btnGradientBottom)),
          ],
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _actions
                .map((a) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: _QuickActionTile(action: a),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _QuickAction {
  final String icon;
  final String label;
  final IconData fallback;

  const _QuickAction(
      {required this.icon, required this.label, required this.fallback});
}

class _QuickActionTile extends StatelessWidget {
  final _QuickAction action;

  const _QuickActionTile({required this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(204),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            action.icon,
            width: 24,
            height: 24,
            errorBuilder: (_, __, ___) =>
                Icon(action.fallback, size: 24, color: const Color(0xFF325A4E)),
          ),
          const SizedBox(height: 16),
          Text(
            action.label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF001510),
              height: 1.23,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Shared: Bank Roll ──────────────────────────────────────────────────────────

class _BankRollCard extends StatelessWidget {
  final bool isFTU;

  const _BankRollCard({required this.isFTU});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(204),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Bank Roll',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xB3001510),
                          height: 1.43)),
                  Text(
                    isFTU ? '\$100.00' : '\$1,850.00',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF001510),
                      height: 1.25,
                    ),
                  ),
                  if (isFTU)
                    const Text('Start with \$100 in free credits',
                        style: TextStyle(
                            fontSize: 12,
                            color: Color(0xB3001510),
                            height: 1.33)),
                ],
              ),
              if (isFTU)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                  decoration: BoxDecoration(
                    color: const Color(0xFFCCF4D8),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Text('FREE CREDITS',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF16A34A),
                          height: 1.33)),
                )
              else
                Container(
                  padding: const EdgeInsets.fromLTRB(8, 4, 6, 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFCCF4D8),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.network(_kUpArrowIcon,
                          width: 12,
                          height: 12,
                          errorBuilder: (_, __, ___) => const Icon(
                              Icons.arrow_upward,
                              size: 12,
                              color: Color(0xFF16A34A))),
                      const SizedBox(width: 2),
                      const Text('+15%',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF16A34A))),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 104,
            width: double.infinity,
            child: CustomPaint(
              painter: _AreaChartPainter(flat: isFTU),
            ),
          ),
        ],
      ),
    );
  }
}

// ── FTU-specific ───────────────────────────────────────────────────────────────

class _WelcomeBanner extends StatelessWidget {
  const _WelcomeBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(204),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFF325A4E).withAlpha(26),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.network(_kUpArrowIcon,
                  width: 16,
                  height: 16,
                  errorBuilder: (_, __, ___) => const Icon(
                      Icons.emoji_events_outlined,
                      size: 16,
                      color: Color(0xFF325A4E))),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome to the Caddie!',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF001510),
                        height: 1.14)),
                SizedBox(height: 2),
                Text(
                    "Start your first round and I'll automatically track your stats and progress.",
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF001510),
                        height: 1.67)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: const Color(0xFFE5E7EB).withAlpha(128),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.close, size: 14, color: Color(0xFF6B7280)),
          ),
        ],
      ),
    );
  }
}

class _FirstRoundCard extends StatelessWidget {
  const _FirstRoundCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF193129), Color(0xFF0D1B17)],
          stops: [0.363, 0.977],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFF128A6D).withAlpha(26),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF2AC9A3).withAlpha(51),
                width: 0.55,
              ),
            ),
            child: Center(
              child: Image.network(_kFirstRoundIcon,
                  width: 28,
                  height: 28,
                  errorBuilder: (_, __, ___) => const Icon(Icons.sports_golf,
                      size: 28, color: Color(0xFF2AC9A3))),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Your first round is waiting',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFFF5F5F5),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Ready to tee off? Hit the button below\nto get started.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF9DC3B8),
              height: 1.43,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(26),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withAlpha(51),
                width: 0.55,
              ),
            ),
            child: const Text(
              'Start Your First Round',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                height: 1.71,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FindRivalsCard extends StatelessWidget {
  const _FindRivalsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(204),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('Find Your Rivals',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF001510),
                    height: 1.5)),
          ),
          const SizedBox(height: 12),
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFF325A4E).withAlpha(26),
              shape: BoxShape.circle,
              border: Border.all(
                  color: const Color(0xFF325A4E).withAlpha(51), width: 0.55),
            ),
            child: Center(
              child: Image.network(_kRivalsIcon,
                  width: 28,
                  height: 28,
                  errorBuilder: (_, __, ___) => const Icon(
                      Icons.person_add_outlined,
                      size: 28,
                      color: Color(0xFF325A4E))),
            ),
          ),
          const SizedBox(height: 12),
          const Text('Golf is better with friends',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF013334),
                  height: 1.5)),
          const SizedBox(height: 6),
          const Text(
              'Invite your buddies and see who really has bragging rights',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12, color: Color(0xFF6A7282), height: 1.33)),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(26),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                  color: const Color(0xFF013334).withAlpha(51), width: 0.55),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(_kInviteIcon,
                    width: 16,
                    height: 16,
                    errorBuilder: (_, __, ___) => const Icon(
                        Icons.people_outline,
                        size: 16,
                        color: Color(0xFF013334))),
                const SizedBox(width: 8),
                const Text('Invite friends',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF013334),
                        height: 1.43)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickTipCard extends StatelessWidget {
  const _QuickTipCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(128),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFF325A4E).withAlpha(26),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.network(_kFlashIcon,
                  width: 16,
                  height: 16,
                  errorBuilder: (_, __, ___) => const Icon(Icons.bolt,
                      size: 16, color: Color(0xFF325A4E))),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Quick Tip',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF001510),
                        height: 1.14)),
                SizedBox(height: 2),
                Text(
                    "Start by playing a round to build your stats. I'll track everything and give you insights along the way!",
                    style: TextStyle(
                        fontSize: 12, color: Color(0xFF001510), height: 1.67)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Existing user: Upcoming Game ───────────────────────────────────────────────

class _UpcomingGameCard extends StatelessWidget {
  const _UpcomingGameCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF325A4E), Color(0xFF243A3A), Color(0xFF193129)],
          stops: [0.0, 0.555, 1.0],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Tomorrow, 8:00 AM',
                        style: TextStyle(
                            fontSize: 12,
                            color: Color(0x99001510),
                            height: 1.33)),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 1),
                      decoration: BoxDecoration(
                        color: const Color(0xFF009568),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text('Scheduled',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              height: 1.4)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text('Friendly',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF001510),
                        height: 1.67)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.location_on_outlined,
                            size: 16, color: Color(0xFF001510)),
                        SizedBox(width: 4),
                        Text('Pebble Beach Golf Links',
                            style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF001510),
                                height: 1.33)),
                      ],
                    ),
                    Row(
                      children: [
                        _PlayerAvatar(label: 'A'),
                        Transform.translate(
                          offset: const Offset(-6, 0),
                          child: _PlayerAvatar(label: 'B'),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Text('View Game',
              style: TextStyle(
                  fontSize: 14, color: Colors.white, height: 1.14)),
        ],
      ),
    );
  }
}

class _PlayerAvatar extends StatelessWidget {
  final String label;

  const _PlayerAvatar({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: const Color(0xFFCCF4D8),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1.5),
      ),
      alignment: Alignment.center,
      child: Text(label,
          style: const TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.w700,
              color: Color(0xFF16A34A))),
    );
  }
}

// ── Existing user: Overview ────────────────────────────────────────────────────

class _OverviewSection extends StatelessWidget {
  const _OverviewSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Overview',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF001510),
                    height: 1.5)),
            Text('View All',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: CaddieColors.btnGradientBottom)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: const [
            Expanded(
              child: _StatCard(
                icon: Icons.adjust,
                label: 'Handicap',
                value: '12.4',
                badge: '+0.4',
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _StatCard(
                icon: Icons.flag_outlined,
                label: 'Rounds',
                value: '2',
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: const [
            Expanded(
              child: _StatCard(
                icon: Icons.attach_money,
                label: 'Total Won',
                value: '1450',
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _StatCard(
                icon: Icons.sports_score,
                label: 'Avg Score',
                value: '84',
                badge: '+1.2',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String? badge;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(204),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, size: 16, color: const Color(0xB3001510)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(label,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xB3001510),
                              height: 1.43)),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(value,
                        style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF001510),
                            height: 1.25)),
                    if (badge != null) ...[
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.fromLTRB(8, 4, 6, 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFCCF4D8),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.arrow_upward,
                                size: 12, color: Color(0xFF16A34A)),
                            const SizedBox(width: 2),
                            Text(badge!,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF16A34A))),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            child: Opacity(
              opacity: 0.45,
              child: SizedBox(
                height: 68,
                width: double.infinity,
                child: CustomPaint(painter: _MiniChartPainter()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Existing user: Nemesis ─────────────────────────────────────────────────────

class _NemesisCard extends StatelessWidget {
  const _NemesisCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(204),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Your Nemesis',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF001510),
                      height: 1.5)),
              Text('Last 5 matches',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xB3001510))),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              // Nemesis photo with RIVAL badge
              SizedBox(
                width: 60,
                height: 60,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        _kNemesisPhoto,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFFBE123C).withAlpha(26),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          alignment: Alignment.center,
                          child: const Text('JK',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFBE123C))),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: const Color(0xFFBE123C), width: 1.5),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 17,
                        decoration: const BoxDecoration(
                          color: Color(0xFFBE123C),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(14),
                            bottomRight: Radius.circular(14),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: const Text('RIVAL',
                            style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: 0.5)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('James K.',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF013334),
                            height: 1.56)),
                    Text("You're down \$450",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFBE123C),
                            height: 1.43)),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  gradient: greenGradient,
                  borderRadius: BorderRadius.circular(16),
                  border:
                      Border.all(color: const Color(0xFF325B4F)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x22345D51),
                      blurRadius: 6,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Text('Revenge',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        height: 1.43)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Existing user: Recent Rounds ───────────────────────────────────────────────

class _RecentRoundsCard extends StatelessWidget {
  const _RecentRoundsCard();

  static const _rounds = [
    _RoundData(score: '82', course: 'Pebble Beach', date: 'Oct 12', amount: '+\$150', isWin: true),
    _RoundData(score: '89', course: 'Spyglass Hill', date: 'Oct 08', amount: '-\$50', isWin: false),
    _RoundData(score: '85', course: 'Spanish Bay', date: 'Oct 01', amount: '+\$20', isWin: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(204),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Recent Rounds',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF001510),
                      height: 1.5)),
              Text('View All',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: CaddieColors.btnGradientBottom)),
            ],
          ),
          const SizedBox(height: 4),
          ..._rounds.asMap().entries.map((e) => Column(
                children: [
                  _RoundRow(data: e.value),
                  if (e.key < _rounds.length - 1)
                    const Divider(
                        color: Color(0xFFE5E7EB),
                        thickness: 0.55,
                        height: 0),
                ],
              )),
        ],
      ),
    );
  }
}

class _RoundData {
  final String score, course, date, amount;
  final bool isWin;

  const _RoundData({
    required this.score,
    required this.course,
    required this.date,
    required this.amount,
    required this.isWin,
  });
}

class _RoundRow extends StatelessWidget {
  final _RoundData data;

  const _RoundRow({required this.data});

  @override
  Widget build(BuildContext context) {
    final winColor = data.isWin ? const Color(0xFF15803D) : const Color(0xFFE7000B);
    final bgColor = data.isWin
        ? const Color(0xFF7FF472).withAlpha(51)
        : const Color(0xFFFFE2E2);

    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration:
                    BoxDecoration(color: bgColor, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Text(data.score,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: winColor)),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(data.course,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF013334),
                          height: 1.43)),
                  Text(data.date,
                      style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF99A1AF),
                          height: 1.33)),
                ],
              ),
            ],
          ),
          Text(data.amount,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: winColor,
                  height: 1.5)),
        ],
      ),
    );
  }
}

// ── Custom painters ────────────────────────────────────────────────────────────

class _AreaChartPainter extends CustomPainter {
  final bool flat;

  const _AreaChartPainter({this.flat = false});

  @override
  void paint(Canvas canvas, Size size) {
    if (flat) {
      // Dashed flat line for FTU (no data)
      final paint = Paint()
        ..color = const Color(0xFF325A4E).withAlpha(60)
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke;
      final y = size.height * 0.75;
      for (double x = 0; x < size.width; x += 14) {
        canvas.drawLine(Offset(x, y), Offset((x + 9).clamp(0, size.width), y), paint);
      }
      return;
    }

    final pts = [
      Offset(0, size.height * 0.72),
      Offset(size.width * 0.12, size.height * 0.62),
      Offset(size.width * 0.28, size.height * 0.70),
      Offset(size.width * 0.44, size.height * 0.48),
      Offset(size.width * 0.60, size.height * 0.52),
      Offset(size.width * 0.76, size.height * 0.32),
      Offset(size.width * 0.88, size.height * 0.28),
      Offset(size.width, size.height * 0.16),
    ];

    final linePath = Path()..moveTo(pts[0].dx, pts[0].dy);
    for (int i = 1; i < pts.length; i++) {
      final p = pts[i - 1], c = pts[i];
      final midX = p.dx + (c.dx - p.dx) * 0.5;
      linePath.cubicTo(midX, p.dy, midX, c.dy, c.dx, c.dy);
    }

    final areaPath = Path.from(linePath)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(
      areaPath,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF325A4E).withAlpha(40),
            const Color(0xFF325A4E).withAlpha(0),
          ],
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
        ..style = PaintingStyle.fill,
    );

    canvas.drawPath(
      linePath,
      Paint()
        ..color = const Color(0xFF325A4E)
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

class _MiniChartPainter extends CustomPainter {
  const _MiniChartPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final pts = [
      Offset(0, size.height * 0.82),
      Offset(size.width * 0.2, size.height * 0.62),
      Offset(size.width * 0.38, size.height * 0.72),
      Offset(size.width * 0.58, size.height * 0.44),
      Offset(size.width * 0.76, size.height * 0.38),
      Offset(size.width, size.height * 0.20),
    ];

    final path = Path()..moveTo(pts[0].dx, pts[0].dy);
    for (int i = 1; i < pts.length; i++) {
      final p = pts[i - 1], c = pts[i];
      final mx = p.dx + (c.dx - p.dx) * 0.5;
      path.cubicTo(mx, p.dy, mx, c.dy, c.dx, c.dy);
    }

    final area = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(
      area,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF325A4E).withAlpha(90),
            const Color(0xFF325A4E).withAlpha(0),
          ],
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
        ..style = PaintingStyle.fill,
    );

    canvas.drawPath(
      path,
      Paint()
        ..color = const Color(0xFF325A4E)
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
