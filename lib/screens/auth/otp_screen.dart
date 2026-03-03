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
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    // Rebuild whenever controller text OR focus state changes
    _controller.addListener(_onChanged);
    _focusNode.addListener(_onFocusChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) => _focusNode.requestFocus());
    _startTimer();
  }

  void _onChanged() => setState(() {});
  void _onFocusChanged() => setState(() => _hasFocus = _focusNode.hasFocus);

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

  @override
  void dispose() {
    _controller.removeListener(_onChanged);
    _focusNode.removeListener(_onFocusChanged);
    _controller.dispose();
    _focusNode.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _onTextChanged(String text) {
    if (text.length == _otpLength) {
      _focusNode.unfocus();
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) widget.onVerified();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final otp = _controller.text;

    return Scaffold(
      backgroundColor: CaddieColors.authBg,
      // keyboard overlays — content stays at top, no resize needed
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => _focusNode.requestFocus(),
          behavior: HitTestBehavior.opaque,
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
              const SizedBox(height: 36),

              // ── Title
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'OTP Verification',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: CaddieColors.authTitle,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // ── Subtitle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0x99001510),
                      height: 1.5,
                    ),
                    children: [
                      const TextSpan(text: "We've sent a verification code to\n"),
                      TextSpan(
                        text: widget.phoneNumber.isEmpty
                            ? '+1 (555) 000-0000'
                            : widget.phoneNumber,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: CaddieColors.authTitle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // ── OTP digit boxes
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  height: 60,
                  child: Stack(
                    children: [
                      // Hidden text field drives the keyboard
                      Positioned.fill(
                        child: Opacity(
                          opacity: 0.01,
                          child: TextField(
                            controller: _controller,
                            focusNode: _focusNode,
                            keyboardType: TextInputType.number,
                            maxLength: _otpLength,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            onChanged: _onTextChanged,
                            decoration: const InputDecoration(counterText: ''),
                          ),
                        ),
                      ),

                      // Visual digit boxes on top
                      Row(
                        children: List.generate(_otpLength, (i) {
                          final digit = i < otp.length ? otp[i] : '';
                          final isFilled = i < otp.length;
                          final isActive = i == otp.length && _hasFocus;
                          return Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: i < _otpLength - 1 ? 10 : 0,
                              ),
                              child: _OtpBox(
                                digit: digit,
                                isFilled: isFilled,
                                isActive: isActive,
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ── Resend row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Wrap(
                  children: [
                    const Text(
                      "Didn't get the OTP?  ",
                      style: TextStyle(fontSize: 14, color: Color(0x80001510)),
                    ),
                    if (_secondsLeft > 0)
                      Text(
                        'Resend OTP in 0:${_secondsLeft.toString().padLeft(2, '0')}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0x66001510),
                        ),
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
                            fontWeight: FontWeight.w600,
                            color: CaddieColors.btnGradientBottom,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Single OTP digit box

class _OtpBox extends StatelessWidget {
  final String digit;
  final bool isFilled;
  final bool isActive;

  const _OtpBox({
    required this.digit,
    required this.isFilled,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isActive
              ? CaddieColors.btnGradientBottom
              : isFilled
                  ? CaddieColors.btnGradientBottom.withAlpha(130)
                  : CaddieColors.authInputBorder,
          width: isActive ? 2 : 1.5,
        ),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: CaddieColors.btnGradientBottom.withAlpha(30),
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
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: CaddieColors.authTitle,
        ),
      ),
    );
  }
}
