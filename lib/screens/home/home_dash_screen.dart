import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movemateshipmentsui/screens/shared/home_header.dart';
import 'package:movemateshipmentsui/screens/shared/shipment_tracking_card.dart';
import 'package:movemateshipmentsui/utils/constants.dart';
import 'package:movemateshipmentsui/viewmodels/home_view_model.dart';
import 'package:movemateshipmentsui/widgets/animated_list_view.dart';
import 'package:movemateshipmentsui/widgets/vehicle_card.dart';
import 'package:stacked/stacked.dart';

class HomeDashScreen extends StatefulWidget {
  const HomeDashScreen({super.key, this.homeViewModel});

  final HomeViewModel? homeViewModel;

  @override
  State<HomeDashScreen> createState() => _HomeDashScreenState();
}

class _HomeDashScreenState extends State<HomeDashScreen> {

  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isCollapsed = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 80 && !_isCollapsed) {
      setState(() {
        _isCollapsed = true;
      });
    } else if (_scrollController.offset <= 80 && _isCollapsed) {
      setState(() {
        _isCollapsed = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => widget.homeViewModel ?? HomeViewModel(),
        disposeViewModel: false,
        onViewModelReady:(model) async {

        },
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: AppColors.textSecondary.withOpacity(0),
            body: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 165.0,
                  floating: false,
                  pinned: true,
                  backgroundColor: AppColors.primary,
                  elevation: 0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: HomeHeader(
                      onSearchChange: (s) {
                        viewModel.updateSearchQuery(s!);
                      },
                      searchController: _searchController,
                      imageIcon: viewModel.profileImagePath,
                      currentUserLocation: viewModel.userLocation,
                    ),
                    titlePadding: EdgeInsets.zero,
                    title: _isCollapsed
                        ? Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.paddingM,
                        vertical: AppSizes.paddingS,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            viewModel.profileImagePath,
                            height: 32,
                            width: 32,
                          ),
                          const SizedBox(width: AppSizes.paddingM),
                          Text(
                            viewModel.userLocation,
                            style: AppTextStyles.subtitle2.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(AppSizes.paddingXS),
                            child: SvgPicture.asset(
                              'assets/icons/notification.svg',
                              height: 20,
                              width: 20,
                              colorFilter: const ColorFilter.mode(
                                AppColors.primary,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ) : const SizedBox.shrink(),
                  ),
                ),
              ];
            },
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSizes.paddingM),
              child: Container(
                height: 700,
                child: AnimatedListView(
                  scrollDirection: Axis.vertical,
                  staggerDuration: const Duration(milliseconds: 200),
                  physics: const BouncingScrollPhysics(),
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
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Tracking',
                          style: AppTextStyles.heading3.copyWith(
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        const SizedBox(height: AppSizes.paddingM),
                        ShipmentTrackingCard(
                          shipment: viewModel.currentShipment,
                          onAddStop: viewModel.addShipmentStop,
                        ),
                        const SizedBox(height: AppSizes.paddingL),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Available vehicles',
                              style: AppTextStyles.heading3.copyWith(
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSizes.paddingM),
                        SizedBox(
                          height: 200,
                          child: AnimatedListView(
                            scrollDirection: Axis.horizontal,
                            staggerDuration: const Duration(milliseconds: 400),
                            animationDuration: const Duration(milliseconds: 800),
                            itemBuilder: (context, child, animation) {
                              return SlideTransition(
                                position: animation.drive(Tween(
                                  begin: const Offset(0.0, 0.5),
                                  end: const Offset(0.0, 0.0),
                                ).chain(CurveTween(curve: Curves.elasticOut))),
                                child: ScaleTransition(
                                  scale: animation.drive(
                                    Tween(begin: 0.5, end: 1.0)
                                        .chain(CurveTween(curve: Curves.easeOutBack)),
                                  ),
                                  child: child,
                                ),
                              );
                            },
                            children: viewModel.vehicles.map((vehicle) {
                              return VehicleCard(
                                vehicle: vehicle,
                                onTap: () {
                                  if (!vehicle.isSelected) {
                                    viewModel.selectVehicle(vehicle.id);
                                  }
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSizes.paddingXL),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}