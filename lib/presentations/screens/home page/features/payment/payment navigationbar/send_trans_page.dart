import 'package:camdell/core/constants/app_button.dart';
import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/image_constant.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:camdell/presentations/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SendTransPage extends StatefulWidget {
  const SendTransPage({super.key});

  @override
  State<SendTransPage> createState() => _SendTransPageState();
}

class _SendTransPageState extends State<SendTransPage> {
  final TextEditingController _amountController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_formatAmount);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _formatAmount() {
    String text = _amountController.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (text.isEmpty) {
      _amountController.text = '';
      return;
    }
    double value = double.parse(text) / 100;
    String formattedValue = NumberFormat.currency(symbol: '\$', decimalDigits: 2).format(value);
    _amountController.value = TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backIcon: Icons.arrow_back,
      onBackPressed: () => Get.back(),
      title: AppText(
        "Transfer",
        style: Ts.semiBold20(color: AppColor.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildUserInfo(),
                      const SizedBox(height: 30),
                      _buildAmountInput(),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: _buildSendButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 24,
          backgroundImage: AssetImage(AppImage.tprofile),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText('Emmanuel Chase', style: Ts.semiBold16()),
              AppText('+1 234 5678 9000', style: Ts.regular14()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAmountInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        // color: AppColor.gray600.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: _amountController,
        focusNode: _focusNode,
        style: Ts.semiBold24(),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '\$0.00',
          hintStyle: Ts.semiBold24(),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        onTap: () {
          if (_amountController.text.isEmpty) {
            _amountController.text = '\$0.00';
            _amountController.selection = TextSelection.fromPosition(
              TextPosition(offset: _amountController.text.length - 3),
            );
          }
        },
      ),
    );
  }

  Widget _buildSendButton() {
    return AppButton(
      onPressed: () {
        String amount = _amountController.text;
        Get.snackbar('Send', 'Sending $amount to Emmanuel Chase'
          , snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColor.secondary,
          colorText: AppColor.white,
          duration: const Duration(seconds: 1),
        );
      },
      text: 'Send',
      textStyle: Ts.semiBold16(color: AppColor.white),
      // Add any additional properties that AppButton accepts
    );
  }
}