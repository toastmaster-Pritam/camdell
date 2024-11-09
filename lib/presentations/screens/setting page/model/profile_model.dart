import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/core/constants/size.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/app_switch.dart';
import 'package:camdell/meta/utils/image_constant.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:flutter/material.dart';

class UserProfileCard extends StatelessWidget {
  final String name;
  final String email;
  final String id;
  final bool isVerified;
  final VoidCallback? onTap;

  const UserProfileCard({
    super.key,
    this.onTap,
    required this.name,
    required this.email,
    required this.id,
    this.isVerified = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 2.5,
        color: AppColor.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            children: [
              const SizedBox(width: 16),
              Expanded(
                flex: 1, 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Hbox(10),
                    Row(
                      children: [
                        Image.asset(AppImage.avatar,height: 40,width: 40,),
                        const Wbox(10),
                        Column(
                          children: [
                            AppText(
                              name,
                              style: Ts.bold18(color: AppColor.black),
                            ),
                            const Hbox(10),
                             AppText(
                          email,
                          style: Ts.medium16(color: AppColor.gray600),
                        ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        AppText(
                          "ID $id",
                          style: Ts.medium16(color: AppColor.grey),
                        ),
                        const Wbox(8),
                        Icon(Icons.copy, color: Colors.grey[400], size: 16),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                      padding: const EdgeInsets.all(10),
                      decoration:  BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        color: Colors.green.withOpacity(0.5)
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle_outline,color: Colors.green,),
                          const Wbox(4),
                          AppText("Verified",style: Ts.regular16(),)
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






class CardWidget extends StatelessWidget {
  final IconData? icon;
  final VoidCallback onPressed;
  final String title;
  final String? subtitle;
  final ShapeBorder shape;
  final bool iconVisible;
  final bool switchVisible;
  final bool switchValue;
  final ValueChanged<bool>? onSwitchChanged;
  final String? trailingText; // New parameter for the text before the arrow

  const CardWidget({
    super.key,
    this.icon,
    required this.onPressed,
    required this.title,
    this.subtitle,
    this.iconVisible = true,
    this.switchVisible = false,
    this.switchValue = false,
    this.onSwitchChanged,
    this.trailingText, // Add this line
    this.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.zero,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;
       
        return Card(
          elevation: 1,
          color: AppColor.white,
          shape: shape,
          margin: EdgeInsets.zero,
          child: InkWell(
            onTap: onPressed,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 8 : 16,
                vertical: isSmallScreen ? 8 : 12,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    if (iconVisible && icon != null) ...[
                      Icon(icon, size: isSmallScreen ? 20 : 24, color: AppColor.grey),
                      SizedBox(width: isSmallScreen ? 8 : 16),
                    ],
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppText(
                            title,
                            style: isSmallScreen
                              ? Ts.regular14(color: AppColor.black)
                              : Ts.regular16(color: AppColor.black),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (subtitle != null && subtitle!.isNotEmpty)
                            AppText(
                              subtitle!,
                              style: isSmallScreen
                                ? Ts.regular12(color: AppColor.grey)
                                : Ts.regular14(color: AppColor.grey),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                    SizedBox(width: isSmallScreen ? 4 : 8),
                    if (switchVisible)
                      CustomSwitch(
                        value: switchValue,
                        onChanged: onSwitchChanged ?? (_) {},
                      )
                    else
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (trailingText != null)
                            Padding(
                              padding: EdgeInsets.only(right: isSmallScreen ? 4 : 8),
                              child: AppText(
                                trailingText!,
                                style: isSmallScreen
                                  ? Ts.regular12(color: AppColor.grey)
                                  : Ts.regular14(color: AppColor.grey),
                              ),
                            ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: isSmallScreen ? 16 : 20,
                            color: AppColor.grey,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}