import 'package:camdell/meta/utils/app_color.dart';
import 'package:flutter/material.dart';

class AppTextfield extends StatefulWidget {
  
  final String label;
  final bool isPassword;
  final IconData? prefixIcon;
  final String? Function(String?) validator;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;
  final ValueChanged<String>? onSubmitted;
  final TextEditingController? controller; // Added controller

  const AppTextfield({
    super.key,
    required this.label,
    required this.prefixIcon,
    this.isPassword = false,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.focusNode,
    this.onSubmitted,
    this.controller, // Added to constructor
  });

  @override
  State<AppTextfield> createState() => _AppTextfieldState();
}

class _AppTextfieldState extends State<AppTextfield> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  String? _errorText;
  bool _obscureText = true;
  bool _isDirty = false;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController(); // Use the provided controller or create a new one
    _focusNode = widget.focusNode ?? FocusNode();
    _controller.addListener(_onInputChanged);
    _focusNode.addListener(_onFocusChange);
  }

  void _onInputChanged() {
    setState(() {
      _errorText = widget.validator(_controller.text);
      _isDirty = _controller.text.isNotEmpty;
    });
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        border: Border.all(
          color: _isFocused ? AppColor.primary : Colors.grey,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: TextFormField(
        cursorHeight: 20,
        onFieldSubmitted: widget.onSubmitted,
        controller: _controller, // Using the controller here
        focusNode: _focusNode,
        obscureText: widget.isPassword && _obscureText,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon == null ? null : Icon(widget.prefixIcon, size: 24, color: AppColor.textcolor),
          labelText: widget.label,
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          isDense: true,
          suffixIcon: _buildSuffixIconRow(),
        ),
      ),
    );
  }

  Widget _buildSuffixIconRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_isDirty)
          Icon(
            _errorText == null ? Icons.check_circle_outline : Icons.error_outline,
            color: _errorText == null ? Colors.green : Colors.red,
            size: 20,
          ),
        if (widget.isPassword) ...[
          if (_isDirty) const SizedBox(width: 8),
          IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              size: 20,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ],
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
