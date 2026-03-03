import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class LoginScreen extends StatefulWidget {
  final void Function(String phone) onContinue;
  final VoidCallback onBack;
  const LoginScreen({super.key, required this.onContinue, required this.onBack});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() => setState(() => _isFocused = _focusNode.hasFocus));
    WidgetsBinding.instance.addPostFrameCallback((_) => _focusNode.requestFocus());
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final topPad = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: CaddieColors.authBg,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ── Top photo section with logo
            SizedBox(
              height: 280,
              width: size.width,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Golf background photo (flipped horizontally)
                  Transform.flip(
                    flipX: true,
                    child: Image.asset(
                      'assets/images/splash-bg.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Bottom fade to white
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 150,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0, 1],
                          colors: [Colors.transparent, Colors.white],
                        ),
                      ),
                    ),
                  ),

                  // Caddie logo (white, top-center)
                  Positioned(
                    top: topPad + 48,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ColorFiltered(
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                          child: Image.asset(
                            'assets/images/caddie-icon.png',
                            width: 40,
                            height: 40,
                          ),
                        ),
                        const SizedBox(width: 11),
                        ColorFiltered(
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                          child: Image.asset(
                            'assets/images/caddie-wordmark.png',
                            height: 34,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ── White card content
            Transform.translate(
              offset: const Offset(0, -24),
              child: Container(
              width: size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(CaddieRadius.card),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  const Text(
                    'Welcome to Caddie',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: CaddieColors.authTitle,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Log in / Create an account to manage your games',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0x99001510),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Label
                  const Text(
                    'Mobile number',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xB3001510),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Phone input row
                  Row(
                    children: [
                      // Country code selector
                      Container(
                        height: 52,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: CaddieColors.authInput,
                          border: Border.all(color: CaddieColors.authInputBorder),
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(12),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('🇺🇸', style: TextStyle(fontSize: 18)),
                            SizedBox(width: 4),
                            Text(
                              '+1',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: CaddieColors.authTitle,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.keyboard_arrow_down,
                              size: 18,
                              color: Color(0x80001510),
                            ),
                          ],
                        ),
                      ),

                      // Divider
                      Container(
                        width: 1,
                        height: 52,
                        color: CaddieColors.authInputBorder,
                      ),

                      // Phone number field
                      Expanded(
                        child: Container(
                          height: 52,
                          decoration: BoxDecoration(
                            color: _isFocused ? Colors.white : CaddieColors.authInput,
                            border: Border.all(
                              color: _isFocused
                                  ? CaddieColors.btnGradientBottom
                                  : CaddieColors.authInputBorder,
                              width: _isFocused ? 2 : 1,
                            ),
                            borderRadius: const BorderRadius.horizontal(
                              right: Radius.circular(12),
                            ),
                          ),
                          child: TextField(
                            controller: _phoneController,
                            focusNode: _focusNode,
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(
                              fontSize: 16,
                              color: CaddieColors.authTitle,
                            ),
                            decoration: const InputDecoration(
                              hintText: '(555) 000-0000',
                              hintStyle: TextStyle(color: Color(0x4D001510)),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Continue button
                  GestureDetector(
                    onTap: () {
                      _focusNode.unfocus();
                      widget.onContinue(_phoneController.text);
                    },
                    child: Container(
                      height: 54,
                      decoration: BoxDecoration(
                        gradient: greenGradient,
                        borderRadius: BorderRadius.circular(CaddieRadius.button),
                        border: Border.all(color: CaddieColors.btnBorder),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // "or" divider
                  Row(
                    children: [
                      Expanded(child: Divider(color: CaddieColors.authBorder)),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'or',
                          style: TextStyle(fontSize: 13, color: Color(0x66001510)),
                        ),
                      ),
                      Expanded(child: Divider(color: CaddieColors.authBorder)),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Social buttons
                  Row(
                    children: [
                      Expanded(child: _SocialButton(label: 'Apple', isApple: true)),
                      const SizedBox(width: 12),
                      Expanded(child: _SocialButton(label: 'Google', isApple: false)),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Terms
                  Center(
                    child: Text.rich(
                      TextSpan(
                        style: const TextStyle(fontSize: 12, color: Color(0x73001510)),
                        children: [
                          const TextSpan(text: 'By continuing, you agree to our '),
                          TextSpan(
                            text: 'Terms of Service',
                            style: const TextStyle(
                              color: Color(0xBF001510),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          const TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: const TextStyle(
                              color: Color(0xBF001510),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            ), // Transform.translate
          ],
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final bool isApple;
  const _SocialButton({required this.label, required this.isApple});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: CaddieColors.authBorder, width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isApple)
            const Icon(Icons.apple, size: 20, color: CaddieColors.authTitle)
          else
            const Text(
              'G',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Color(0xFF4285F4),
              ),
            ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: CaddieColors.authTitle,
            ),
          ),
        ],
      ),
    );
  }
}
