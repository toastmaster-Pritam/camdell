import 'package:camdell/meta/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/app_button.dart';
import '../../core/constants/size.dart';
import '../../meta/utils/ts.dart';

class FourDigitCodeEntry extends StatefulWidget {
  final Function(String) onCodeEntered;

  const FourDigitCodeEntry({super.key, required this.onCodeEntered});

  @override
  State<FourDigitCodeEntry> createState() => _FourDigitCodeEntryState();
}

class _FourDigitCodeEntryState extends State<FourDigitCodeEntry> {
  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onContinue() {
    final code = _controllers.map((c) => c.text).join();
    if (code.length == 4) {
      widget.onCodeEntered(code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter 4 Digits Code',
          style: Ts.bold18(color: AppColor.black),
        ),
       const Hbox(8),
        Text(
          'Enter the 4 digits code that you received on your email.',
          style: Ts.regular16(color: AppColor.black),
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(4, (index) {
            return SizedBox(
              width: 50,
              child: TextField(
                controller: _controllers[index],
                focusNode: _focusNodes[index],
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: (value) {
                  if (value.isNotEmpty && index < 3) {
                    _focusNodes[index + 1].requestFocus();
                  }
                },
              ),
            );
          }),
        ),
        const Hbox(20),
        AppButton(
          text: "Continue",
          onPressed: _onContinue,
          isFullWidth: true,
          textColor: AppColor.white,
        ),
      ],
    );
  }
}