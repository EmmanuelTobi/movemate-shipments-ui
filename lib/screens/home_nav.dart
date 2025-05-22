import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movemateshipmentsui/screens/calculate/calculate_screen.dart';
import 'package:movemateshipmentsui/screens/home/home_dash_screen.dart';
import 'package:movemateshipmentsui/screens/shared/home_header.dart';
import 'package:provider/provider.dart';
import '../utils/constants.dart';
import '../viewmodels/home_view_model.dart';
import 'shared/shipment_tracking_card.dart';
import '../widgets/vehicle_card.dart';
import '../widgets/animated_list_view.dart';
import 'shipping_track/shippment_history.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          body: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: [
              HomeDashScreen(homeViewModel: viewModel),
              const CalculateScreen(),
              const ShipmentHistoryScreen(),
              Container(color: Colors.white, child: const Center(child: Text('Profile'))),
            ],
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Stack(
              children: [
                ////changing indicator bottomnavitem
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  top: 0,
                  left: 0,
                  right: 0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    height: 4,
                    margin: EdgeInsets.only(
                      left: (MediaQuery.of(context).size.width / 4) * _currentIndex + 16,
                      right: (MediaQuery.of(context).size.width / 4) * (3 - _currentIndex) + 16,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(4),
                      ),
                    ),
                  ),
                ),
                BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  selectedItemColor: AppColors.primary,
                  unselectedItemColor: Colors.grey,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  currentIndex: _currentIndex,
                  onTap: (index) {
                    setState(() {
                      _currentIndex = index;
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    });
                  },
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
                      icon: Icon(Icons.history),
                      label: 'Shipment',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline),
                      label: 'Profile',
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
