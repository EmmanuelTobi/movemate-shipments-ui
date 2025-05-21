import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/constants.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final VoidCallback onScanPressed;
  final Function? onTap;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onScanPressed,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusXL),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: AppSizes.paddingM),
          SvgPicture.asset(
            'assets/icons/search.svg',
            height: 24,
            width: 24,
            colorFilter: const ColorFilter.mode(
              AppColors.primary,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: AppSizes.paddingM),
          Expanded(
            child: GestureDetector(
              onTap: () {
                onTap?.call();
              },
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                enabled: onTap != null ? false : true,
                decoration: InputDecoration(
                  hintText: 'Enter the receipt number ...',
                  hintStyle: AppTextStyles.body2,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: AppSizes.paddingM,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.all(AppSizes.paddingS),
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusXL),
            ),
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/icons/scan.svg',
                height: 24,
                width: 24,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
              onPressed: onScanPressed,
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}
