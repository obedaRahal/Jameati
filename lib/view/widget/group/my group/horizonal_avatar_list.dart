import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_manag_ite/core/constant/image_asset.dart';

class HorizontalAvatarList extends StatelessWidget {
  final List<String> listAvatar;
  final double borderRadius;

  final double? width;
  final double avatarSize;
  final double spacing;

  const HorizontalAvatarList({
    super.key,
    required this.listAvatar,
    required this.borderRadius,
    this.width,
    this.avatarSize = 35,
    this.spacing = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      width: width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: listAvatar
              .map(
                (avatarPath) => Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(borderRadius),
                      child: Image.asset(avatarPath,
                          height: avatarSize.h,
                          errorBuilder: (_, __, ___) => SvgPicture.asset(
                              MyImageAsset.profileNoPic,
                              height: 35.h,
                              width: 35.h,
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(width: spacing.w),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
