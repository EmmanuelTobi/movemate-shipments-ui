import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/shipment.dart';
import '../../utils/constants.dart';
import '../../viewmodels/shipping_track_search_view_model.dart';
import '../../widgets/animated_list_view.dart';
import '../../widgets/search_bar_widget.dart';

class ShippingTrackSearchScreen extends StatelessWidget {
  const ShippingTrackSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ShippingTrackSearchViewModel(),
      child: const ShippingTrackSearchView(),
    );
  }
}

class ShippingTrackSearchView extends StatelessWidget {
  const ShippingTrackSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ShippingTrackSearchViewModel>();

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: SearchBarWidget(
                      controller: viewModel.searchController,
                      onChanged: (_) => viewModel.onSearchChanged(),
                      onScanPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: AnimatedListView(
                  scrollDirection: Axis.vertical,
                  staggerDuration: const Duration(milliseconds: 200),
                  animationDuration: const Duration(milliseconds: 500),
                  itemBuilder: (context, child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: animation.drive(Tween(
                          begin: const Offset(0.0, 1.0),
                          end: const Offset(0.0, 0.0),
                        ).chain(CurveTween(curve: Curves.easeOutCubic))),
                        child: child,
                      ),
                    );
                  },
                  children: viewModel.filteredShipments
                      .map((shipment) => _buildShipmentItem(shipment))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShipmentItem(Shipment shipment) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusXL),
          ),
          child: Image.asset(
            "assets/images/box.png",
            height: 20,
            width: 20,
            fit: BoxFit.contain,
          ),
        ),
        title: Text(
          shipment.sender,
          style: AppTextStyles.subtitle1.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Row(
          children: [
            Text(
              '#${shipment.number}',
              style: AppTextStyles.caption.copyWith(color: Colors.grey),
            ),
            Text(' • ', style: AppTextStyles.caption.copyWith(color: Colors.grey),),
            Text(
              '${shipment.senderLocation} → ${shipment.receiverLocation}',
              style: AppTextStyles.caption.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
