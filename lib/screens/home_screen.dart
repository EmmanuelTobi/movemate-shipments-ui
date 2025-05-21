import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movemateshipmentsui/screens/shared/home_header.dart';
import 'package:provider/provider.dart';
import '../utils/constants.dart';
import '../viewmodels/home_view_model.dart';
import 'shared/shipment_tracking_card.dart';
import '../widgets/vehicle_card.dart';
import '../widgets/animated_list_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          body: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 200.0,
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
                                  padding:
                                      const EdgeInsets.all(AppSizes.paddingXS),
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
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
              ];
            },
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSizes.paddingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tracking section
                  Text(
                    'Tracking',
                    style: AppTextStyles.heading2,
                  ),
                  const SizedBox(height: AppSizes.paddingM),
                  ShipmentTrackingCard(
                    shipment: viewModel.currentShipment,
                    onAddStop: viewModel.addShipmentStop,
                  ),
                  const SizedBox(height: AppSizes.paddingL),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Available vehicles',
                        style: AppTextStyles.heading2,
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
                            // Only animate if selecting a different vehicle
                            if (!vehicle.isSelected) {
                              viewModel.selectVehicle(vehicle.id);
                            }
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: AppSizes.paddingXL),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            currentIndex: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calculate_outlined),
                label: 'Calculate',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.av_timer_rounded),
                label: 'Shipment',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
