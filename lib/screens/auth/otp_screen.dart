import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/theme.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  final VoidCallback onVerified;
  final VoidCallback onBack;

  const OtpScreen({
    super.key,
    required this.phoneNumber,
    required this.onVerified,
    required this.onBack,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  static const int _otpLength = 6;
  int _secondsLeft = 36;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onOtpChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) => _focusNode.requestFocus());
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) { t.cancel(); return; }
      setState(() {
        if (_secondsLeft > 0) {
          _secondsLeft--;
        } else {
          t.cancel();
        }
      });
    });
  }

  void _onOtpChanged() {
    final otp = _controller.text;
    if (otp.length == _otpLength) {
      _focusNode.unfocus();
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) widget.onVerified();
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onOtpChanged);
    _controller.dispose();
    _focusNode.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CaddieColors.authBg,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Back button
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: GestureDetector(
                onTap: widget.onBack,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.chevron_left,
                    color: CaddieColors.authTitle,
                    size: 22,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // ── Title + subtitle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'OTP Verification',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: CaddieColors.authTitle,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "We've sent a verification code to",
                    style: TextStyle(fontSize: 15, color: Color(0x99001510)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.phoneNumber.isEmpty ? '+1 (555) 000-0000' : widget.phoneNumber,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: CaddieColors.authTitle,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // ── OTP boxes + hidden text field
            GestureDetector(
              onTap: () => _focusNode.requestFocus(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Stack(
                  children: [
                    // Hidden text field for keyboard input
                    Opacity(
                      opacity: 0.01,
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        keyboardType: TextInputType.number,
                        maxLength: _otpLength,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        decoration: const InputDecoration(counterText: ''),
                      ),
                    ),

                    // Visual OTP boxes
                    ValueListenableBuilder(
                      valueListenable: _controller,
                      builder: (context, value, _) {
                        return Row(
                          children: List.generate(_otpLength, (i) {
                            final digit = i < value.text.length ? value.text[i] : '';
                            final isFilled = i < value.text.length;
                            final isActive = i == value.text.length && _focusNode.hasFocus;
                            return Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: i < _otpLength - 1 ? 12 : 0),
                                child: _OtpBox(
                                  digit: digit,
                                  isFilled: isFilled,
                                  isActive: isActive,
                                ),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ── Resend text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  const Text(
                    "Didn't get the OTP? ",
                    style: TextStyle(fontSize: 14, color: Color(0x99001510)),
                  ),
                  if (_secondsLeft > 0)
                    Text(
                      'Resend OTP in 0:${_secondsLeft.toString().padLeft(2, '0')}',
                      style: const TextStyle(fontSize: 14, color: Color(0x80001510)),
                    )
                  else
                    GestureDetector(
                      onTap: () {
                        setState(() => _secondsLeft = 36);
                        _startTimer();
                      },
                      child: const Text(
                        'Resend OTP',
                        style: TextStyle(
                          fontSize: 14,
                          color: CaddieColors.btnGradientBottom,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OtpBox extends StatelessWidget {
  final String digit;
  final bool isFilled;
  final bool isActive;

  const _OtpBox({required this.digit, required this.isFilled, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isActive
              ? CaddieColors.btnGradientBottom
              : isFilled
                  ? CaddieColors.btnGradientBottom.withAlpha(128)
                  : CaddieColors.authInputBorder,
          width: isActive ? 2 : 1.5,
        ),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: CaddieColors.btnGradientBottom.withAlpha(38),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      alignment: Alignment.center,
      child: Text(
        digit,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: CaddieColors.authTitle,
        ),
      ),
    );
  }
}
