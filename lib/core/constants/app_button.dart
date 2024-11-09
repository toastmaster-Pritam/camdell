import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


import '../../meta/utils/app_color.dart';
import '../../meta/utils/ts.dart';
import 'app_text.dart';
import 'size.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {super.key,
      this.text,
      this.onPressed,
      this.isDisabled = false,
      this.isInProgress = false,
      this.isFullWidth = true,
      this.elevation = 1.0,
      this.textColor,
      this.bgColor,
      this.borderColor,
      this.borderWidth,
      this.icon,
      this.textStyle,
      this.svg,
      this.height = 50,
      this.borderRadius = 10,
      this.horizontalPadding = 10,
      this.isLoading = false});
  final String? text;
  final VoidCallback? onPressed;
  final bool isDisabled;
  final double? height;
  final bool isInProgress;
  final double elevation;
  final Color? textColor;
  final Color? bgColor;
  final Color? borderColor;
  final double? borderWidth;
  final bool isFullWidth;
  final IconData? icon;
  final SvgPicture? svg;
  final double borderRadius;
  final bool isLoading;
  final TextStyle? textStyle;
  final double? horizontalPadding;

  double? get _buttonHeight {
    return height;
  }

  double get _padHor {
    return horizontalPadding ?? 0;
  }

  Color get _borderColor {
    if (isDisabled && !isInProgress) {
      return AppColor.gray300;
    }

    return borderColor != null ? borderColor! : bgColor ?? AppColor.primary;
  }

  double get _borderWidth => borderWidth ?? 1;

  Color get _bgColor {
    return (isDisabled && !isInProgress) ? (bgColor ?? AppColor.primary).withOpacity(0.5) : bgColor ?? AppColor.primary;
  }

  Color? get _textColor => textColor ?? Colors.black;

  ButtonStyle get buttonStyle {
    return ButtonStyle(
      overlayColor: WidgetStateProperty.all<Color>(Colors.grey.withOpacity(0.2)),
      elevation: WidgetStateProperty.all<double>(elevation),
      backgroundColor: WidgetStateProperty.all<Color>(_bgColor),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
      shape: WidgetStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(width: _borderWidth, color: _borderColor),
        ),
      ),
    );
  }

  Widget _wChild() {
    if (isLoading) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: _padHor),
        child: CupertinoActivityIndicator(color: textStyle?.color ?? _textColor),
      );
    }

    if (svg != null) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: _padHor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            svg!,
            const Wbox(10),
            AppText(
              text,
              style: textStyle ?? Ts.semiBold17(color: _textColor),
              maxLines: 1,
              isAutoSize: true,
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _padHor),
      child: AppText(
        text,
        style: textStyle ?? Ts.semiBold17(color: _textColor),
        isAutoSize: true,
        maxLines: 1,
      ),
    );
  }

  Widget _wButton() {
    if (icon != null) {
      return SizedBox(
        width: isFullWidth ? double.maxFinite : null,
        height: _buttonHeight,
        child: ElevatedButton.icon(
          style: buttonStyle,
          label: _wChild(),
          icon: Icon(icon, color: textStyle?.color ?? _textColor),
          onPressed: !isDisabled ? onPressed : null,
        ),
      );
    }

    return SizedBox(
      width: isFullWidth ? double.maxFinite : null,
      height: _buttonHeight,
      child: ElevatedButton(
        style: buttonStyle,
        onPressed: !isDisabled ? onPressed : null,
        child: _wChild(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isInProgress) {
      return Opacity(
        opacity: 0.4,
        child: _wButton(),
      );
    }

    return _wButton();
  }
}
