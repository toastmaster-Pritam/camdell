import 'package:camdell/core/constants/size.dart';
import 'package:camdell/meta/utils/image_constant.dart';
import 'package:flutter/material.dart';

class SocialLoginWidget extends StatelessWidget {
  final VoidCallback? onFacebookTap;
  final VoidCallback? onAppleTap;
  final VoidCallback? onGoogleTap;
  final Color dividerColor;
  final Color textColor;
  final String dividerText;

  const SocialLoginWidget({
    super.key,
    this.onFacebookTap,
    this.onAppleTap,
    this.onGoogleTap,
    this.dividerColor = Colors.grey,
    this.textColor = Colors.black,
    this.dividerText = 'or continue with',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDivider(),
       const Hbox(15),
        _buildSocialButtons(),
      ],
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(thickness: 1, color: dividerColor)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(dividerText, style: TextStyle(color: textColor)),
        ),
        Expanded(child: Divider(thickness: 1, color: dividerColor)),
      ],
    );
  }

  Widget _buildSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialButton(
          image: AppImage.facebook,
          onTap: onFacebookTap,
        ),
       const Wbox(15),
        _SocialButton(
          image: AppImage.apple,
          onTap: onAppleTap,
        ),
       const Wbox(15),
        _SocialButton(
          image: AppImage.google,
          onTap: onGoogleTap,
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String image;
  final VoidCallback? onTap;

  const _SocialButton({
    super.key,
    required this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset(image, height: 24),
      ),
    );
  }
}