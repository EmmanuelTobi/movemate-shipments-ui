import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movemateshipmentsui/screens/shipping_track/shipping_track_search_screen.dart';
import 'package:movemateshipmentsui/utils/constants.dart';
import 'package:movemateshipmentsui/widgets/search_bar_widget.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader(
      {super.key,
      this.searchController,
      this.onSearchChange,
      this.imageIcon,
      this.currentUserLocation});

  final TextEditingController? searchController;
  final Function(String? e)? onSearchChange;
  final String? imageIcon;
  final String? currentUserLocation;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      padding: const EdgeInsets.fromLTRB(
        AppSizes.paddingM,
        AppSizes.paddingXL + 20,
        AppSizes.paddingM,
        AppSizes.paddingM,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                imageIcon!,
                height: 40,
                width: 40,
              ),
              const SizedBox(width: AppSizes.paddingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.send_rounded,
                          size: 16,
                          color: Colors.white.withOpacity(0.8),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Your location',
                          style: AppTextStyles.caption.copyWith(
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          currentUserLocation ?? "",
                          style: AppTextStyles.subtitle1.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(AppSizes.paddingS),
                child: SvgPicture.asset(
                  'assets/icons/notification.svg',
                  height: 24,
                  width: 24,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.paddingL),
          SearchBarWidget(
            controller: searchController!,
            onChanged: onSearchChange!,
            onScanPressed: () {},
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ShippingTrackSearchScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
