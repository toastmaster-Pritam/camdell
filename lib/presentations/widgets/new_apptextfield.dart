import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';

class SmartTextField extends StatefulWidget {
  final String label;
  final String? Function(String?) validator;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;
  final ValueChanged<String>? onSubmitted;
  final TextEditingController? controller;
  final String? errorText;
  final String initialCountryCode;

  const SmartTextField({
    super.key,
    this.errorText,
    required this.label,
    required this.validator,
    this.textInputAction = TextInputAction.done,
    this.focusNode,
    this.onSubmitted,
    this.controller,
    this.initialCountryCode = 'Nigeria',
  });

  @override
  State<SmartTextField> createState() => _SmartTextFieldState();
}

class _SmartTextFieldState extends State<SmartTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  String? _errorText;
  bool _isDirty = false;
  bool _isFocused = false;
  bool _isPhoneMode = false;
  CountryCode? _selectedCountry;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _controller.addListener(_onInputChanged);
    _focusNode.addListener(_onFocusChange);
  }

  bool _isNumeric(String str) {
    return str.contains(RegExp(r'[0-9]'));
  }

  void _onInputChanged() {
    final text = _controller.text;
    setState(() {
      _errorText = widget.validator(text);
      _isDirty = text.isNotEmpty;
      _isPhoneMode = _isNumeric(text);
    });
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _onCountryChange(CountryCode countryCode) {
    setState(() {
      _selectedCountry = countryCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: _isFocused ? Colors.blue : Colors.grey,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
          const BoxShadow(
            color: Colors.white,
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, -4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: Row(
        children: [
          if (_isPhoneMode) ...[
            CountryCodePicker(
              onChanged: _onCountryChange,
              initialSelection: widget.initialCountryCode,
              // favorite: const ['US', 'GB', 'IN', 'CA'],
              showCountryOnly: false,
              showOnlyCountryWhenClosed: false,
              alignLeft: false,
              showFlag: true,
              showFlagDialog: true,
              hideMainText: false,
              showFlagMain: true,
              flagWidth: 25,
              padding: const EdgeInsets.all(0),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              height: 24,
              width: 1,
              color: Colors.grey[300],
            ),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: TextFormField(
              cursorHeight: 20,
              onFieldSubmitted: widget.onSubmitted,
              controller: _controller,
              focusNode: _focusNode,
              keyboardType: _isPhoneMode ? TextInputType.phone : TextInputType.emailAddress,
              textInputAction: widget.textInputAction,
              decoration: InputDecoration(
                prefixIcon: _isPhoneMode ? null : const Icon(Icons.email, size: 24, color: Colors.grey),
                labelText: widget.label,
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
                errorText: widget.errorText,
                suffixIcon: _buildSuffixIcon(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuffixIcon() {
    if (!_isDirty) return const SizedBox.shrink();
    
    return Icon(
      _errorText == null ? Icons.check_circle_outline : Icons.error_outline,
      color: _errorText == null ? Colors.green : Colors.red,
      size: 20,
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_onInputChanged);
    _focusNode.removeListener(_onFocusChange);
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }
}