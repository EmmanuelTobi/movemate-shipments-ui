import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../models/shipment.dart';
import '../../utils/constants.dart';

class ShipmentTrackingCard extends StatelessWidget {
  final Shipment shipment;
  final VoidCallback onAddStop;

  const ShipmentTrackingCard({
    super.key,
    required this.shipment,
    required this.onAddStop,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusL),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shipment number section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Shipment Number',
                      style: AppTextStyles.body2,
                    ),
                    const SizedBox(height: AppSizes.paddingXS),
                    Text(
                      shipment.number,
                      style: AppTextStyles.subtitle1.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SvgPicture.asset(
                  'assets/icons/forklift.svg',
                  height: 40,
                  width: 40,
                ),
              ],
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Divider(
                thickness: 0.5,
                color: AppColors.divider,
              ),
            ),

            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(AppSizes.paddingS),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE6F7EC),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/unboxing.png',
                                height: 24,
                                width: 24,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSizes.paddingS),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sender',
                                  style: AppTextStyles.caption,
                                ),
                                const SizedBox(height: AppSizes.paddingXS),
                                Text(
                                  '${shipment.sender}, ${shipment.senderLocation}',
                                  style: AppTextStyles.body2.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 120,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Time',
                            style: AppTextStyles.caption,
                          ),
                          const SizedBox(height: AppSizes.paddingXS),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: AppColors.success,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: AppSizes.paddingXS),
                              Text(
                                shipment.estimatedDelivery,
                                style: AppTextStyles.body2.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppSizes.paddingXL,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(AppSizes.paddingS),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE6F7EC),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/unboxing.png',
                                height: 24,
                                width: 24,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSizes.paddingS),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Receiver',
                                  style: AppTextStyles.caption,
                                ),
                                const SizedBox(height: AppSizes.paddingXS),
                                Text(
                                  '${shipment.receiver}, ${shipment.receiverLocation}',
                                  style: AppTextStyles.body2.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 120,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Status',
                            style: AppTextStyles.caption,
                          ),
                          const SizedBox(height: AppSizes.paddingXS),
                          Text(
                            shipment.status,
                            style: AppTextStyles.body2.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Divider(
                thickness: 0.5,
                color: AppColors.divider,
              ),
            ),

            // Add stop button
            GestureDetector(
              onTap: onAddStop,
              child: Container(
                width: double.infinity,
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.add,
                        color: AppColors.accent,
                        size: 18,
                      ),
                      const SizedBox(width: AppSizes.paddingXS),
                      Text(
                        'Add Stop',
                        style: AppTextStyles.button.copyWith(
                          color: AppColors.accent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
