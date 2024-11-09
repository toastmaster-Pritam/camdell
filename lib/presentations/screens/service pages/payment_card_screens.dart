import 'package:camdell/core/constants/size.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_button.dart';
import '../../../core/constants/app_text.dart';
import '../../../meta/utils/responsive.dart';
import '../../widgets/app_scaffold.dart';

class CardInputPage extends StatelessWidget {
  const CardInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
       title: AppText(
        "Add Card Details",
        style: Ts.semiBold20(color: AppColor.white),
      ),
      chat: true,
      backIcon: Icons.arrow_back,
      onBackPressed: () => Get.back(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Hbox(20),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),

              height: 120,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(15),
              ),
              
            ),
             const Text(
              'Add Card Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Hbox(16),
            const CardNumberInput(),
            const Hbox(16),
            const Row(
              children: [
                Expanded(child: ExpiryDateInput()),
                SizedBox(width: 16),
                Expanded(child: CVVInput()),
              ],
            ),
           const Hbox(24),
            _waddpayment(),
            const Hbox(24),
             AppButton(
                  bgColor: AppColor.blue900,
                  onPressed: () {
                    Navigator.pop(context);
                  
                  },
                  text: 'Add Card',
                  elevation: 0,
                  horizontalPadding: Responsive.doubleR(context, mobile: 80, desktop: 100, tablet: 80),
                  isFullWidth: false,
                  borderRadius: 40,
                  textColor: AppColor.white,
                ),
          ],
        ),
      ),
    );
  }
}

 Widget _waddpayment() {
    return DottedBorder(
      dashPattern: const [6, 6],
      strokeWidth: 1.5,
      color: Colors.black,
      borderType: BorderType.RRect,
      radius: const Radius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        child: AppText(
          '+ Add Payment Method',
          style: Ts.semiBold16()
        ),
      ),
    );
  }

class CardNumberInput extends StatelessWidget {
  const CardNumberInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Add Card No:',
        hintText: 'Enter your card no',
        suffixIcon: Icon(Icons.credit_card),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.grey),
        )
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(16),
        _CardNumberFormatter(),
      ],
    );
  }
}

class ExpiryDateInput extends StatelessWidget {
  const ExpiryDateInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Add Expiry Date:',
        hintText: 'MM/YY',
        suffixIcon: Icon(Icons.calendar_today),
         border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.grey),
        )
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
        _ExpiryDateFormatter(),
      ],
    );
  }
}

class CVVInput extends StatelessWidget {
  const CVVInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Add CVV:',
        hintText: 'CVV',
        suffixIcon: Icon(Icons.lock_outline),
         border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.grey),
        )
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(3),
      ],
    );
  }
}

class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    if (text.length > 19) return oldValue;
    final newString = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) newString.write(' ');
      newString.write(text[i]);
    }
    return TextEditingValue(
      text: newString.toString(),
      selection: TextSelection.collapsed(offset: newString.length),
    );
  }
}

class _ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    if (text.length > 5) return oldValue;
    final newString = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i == 2) newString.write('/');
      newString.write(text[i]);
    }
    return TextEditingValue(
      text: newString.toString(),
      selection: TextSelection.collapsed(offset: newString.length),
    );
  }
}