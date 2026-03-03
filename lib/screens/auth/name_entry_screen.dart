import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class NameEntryScreen extends StatefulWidget {
  final void Function(String name) onContinue;
  final VoidCallback onBack;

  const NameEntryScreen({
    super.key,
    required this.onContinue,
    required this.onBack,
  });

  @override
  State<NameEntryScreen> createState() => _NameEntryScreenState();
}

class _NameEntryScreenState extends State<NameEntryScreen> {
  final _nameController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() => setState(() {}));
    _focusNode.addListener(() => setState(() => _isFocused = _focusNode.hasFocus));
    WidgetsBinding.instance.addPostFrameCallback((_) => _focusNode.requestFocus());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  bool get _canContinue => _nameController.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final safePad = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: CaddieColors.authBg,
      // resizeToAvoidBottomInset: true (default) — body shrinks with keyboard;
      // button pinned at the bottom of the body stays just above the keyboard.
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Back button (respects status bar)
          Padding(
            padding: EdgeInsets.fromLTRB(24, safePad.top + 16, 24, 0),
            child: Align(
              alignment: Alignment.centerLeft,
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
          ),

          // ── Centre area: title + input
          const Spacer(),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Tell us your name',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: CaddieColors.authTitle,
              ),
            ),
          ),
          const SizedBox(height: 28),

          // ── Name input field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: _isFocused
                      ? CaddieColors.btnGradientBottom
                      : CaddieColors.authInputBorder,
                  width: _isFocused ? 2 : 1.5,
                ),
              ),
              child: TextField(
                controller: _nameController,
                focusNode: _focusNode,
                textCapitalization: TextCapitalization.words,
                autocorrect: false,
                style: const TextStyle(
                  fontSize: 18,
                  color: CaddieColors.authTitle,
                ),
                decoration: const InputDecoration(
                  hintText: 'Enter your full name',
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Color(0x4D001510),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                ),
              ),
            ),
          ),

          const Spacer(),

          // ── Continue button — stays at bottom as body shrinks with keyboard
          Padding(
            padding: EdgeInsets.fromLTRB(24, 12, 24, safePad.bottom + 24),
            child: GestureDetector(
              onTap: _canContinue
                  ? () {
                      _focusNode.unfocus();
                      widget.onContinue(_nameController.text.trim());
                    }
                  : null,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                height: 54,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      CaddieColors.btnGradientTop
                          .withAlpha(_canContinue ? 255 : 100),
                      CaddieColors.btnGradientBottom
                          .withAlpha(_canContinue ? 255 : 100),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(CaddieRadius.button),
                  border: Border.all(
                    color: CaddieColors.btnBorder
                        .withAlpha(_canContinue ? 255 : 100),
                  ),
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
          ),
        ],
      ),
    );
  }
}
