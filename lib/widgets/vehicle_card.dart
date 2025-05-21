import 'package:flutter/material.dart';
import '../models/vehicle.dart';
import '../utils/constants.dart';

class VehicleCard extends StatelessWidget {
  final Vehicle vehicle;
  final VoidCallback onTap;

  const VehicleCard({
    super.key,
    required this.vehicle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: 190,
        margin: const EdgeInsets.only(right: AppSizes.paddingM),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusL),
          border: vehicle.isSelected
              ? Border.all(color: AppColors.primary, width: 2)
              : null,
          boxShadow: vehicle.isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSizes.paddingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vehicle.name,
                    style: AppTextStyles.subtitle1.copyWith(
                      fontWeight: FontWeight.w600,
                      color: vehicle.isSelected
                          ? AppColors.primary
                          : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSizes.paddingXS),
                  Text(
                    vehicle.description,
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                const Expanded(child: SizedBox(width: 30,)),
                Image.asset(
                  vehicle.iconPath,
                  height: 120,
                  width: 120,
                  fit: BoxFit.fitWidth,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
