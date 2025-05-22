import 'package:flutter/material.dart';
import 'package:movemateshipmentsui/widgets/animated_list_view.dart';
import '../../utils/constants.dart';
import '../../models/shipment.dart';

class ShipmentHistoryScreen extends StatefulWidget {
  const ShipmentHistoryScreen({Key? key}) : super(key: key);

  @override
  State<ShipmentHistoryScreen> createState() => _ShipmentHistoryScreenState();
}

class _ShipmentHistoryScreenState extends State<ShipmentHistoryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Shipment> _shipments = [
    Shipment(
      id: '1',
      number: 'NEJ20089934122231',
      sender: 'Atlanta',
      senderLocation: 'Atlanta',
      receiver: 'Chicago',
      receiverLocation: 'Chicago',
      status: 'in-progress',
      estimatedDelivery: DateTime.now().toString(),
      amount: 1400,
    ),
    Shipment(
      id: '2',
      number: 'NEJ20089934122231',
      sender: 'Atlanta',
      senderLocation: 'Atlanta',
      receiver: 'Chicago',
      receiverLocation: 'Chicago',
      status: 'in-progress',
      estimatedDelivery: DateTime.now().toString(),
      amount: 370,
    ),
    Shipment(
      id: '3',
      number: 'NEJ20089934122231',
      sender: 'Atlanta',
      senderLocation: 'Atlanta',
      receiver: 'Chicago',
      receiverLocation: 'Chicago',
      status: 'pending',
      estimatedDelivery: DateTime.now().toString(),
      amount: 3570,
    ),
    Shipment(
      id: '3',
      number: 'NEJ20089934122231',
      sender: 'Atlanta',
      senderLocation: 'Atlanta',
      receiver: 'Chicago',
      receiverLocation: 'Chicago',
      status: 'pending',
      estimatedDelivery: DateTime.now().toString(),
      amount: 3570,
    ),
    Shipment(
      id: '3',
      number: 'NEJ20089934122231',
      sender: 'Atlanta',
      senderLocation: 'Atlanta',
      receiver: 'Chicago',
      receiverLocation: 'Chicago',
      status: 'pending',
      estimatedDelivery: DateTime.now().toString(),
      amount: 3570,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.1),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: const Text(
          'Shipment history',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.green,
          indicatorWeight: 5,
          labelColor: Colors.white,
          physics: const BouncingScrollPhysics(),
          unselectedLabelColor: Colors.white70,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w600
          ),
          tabs: [
            Tab(text: 'All (${_shipments.length})'),
            Tab(text: 'In progress (${_shipments.where((s) => s.status == 'in-progress').length})'),
            Tab(text: 'Pending order (${_shipments.where((s) => s.status == 'pending').length})'),
            Tab(text: 'Cancelled (${_shipments.where((s) => s.status == 'cancelled').length})'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildShipmentList(_shipments),
          _buildShipmentList(_shipments.where((s) => s.status == 'in-progress').toList()),
          _buildShipmentList(_shipments.where((s) => s.status == 'pending').toList()),
          _buildShipmentList(_shipments.where((s) => s.status == 'cancelled').toList()),
        ],
      ),
    );
  }

  Widget _buildShipmentList(List<Shipment> shipments) {

    return Padding(
      padding: const EdgeInsets.all(16.0),
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
        children: shipments.map((shipment) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.sync, size: 16, color: Colors.green[400]),
                                const SizedBox(width: 4),
                                Text(
                                  shipment.status,
                                  style: TextStyle(color: Colors.green[400], fontSize: 12, fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Arriving today!',
                        style: AppTextStyles.heading3,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Your delivery, #${shipment.number}\nfrom ${shipment.sender}, is arriving today!',
                        style: AppTextStyles.body2.copyWith(color: Colors.grey, fontSize: 13),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            '\$${shipment.amount} USD',
                            style: AppTextStyles.heading3.copyWith(color: AppColors.primary, fontSize: 16),
                          ),
                          Text(' • ', style: AppTextStyles.caption.copyWith(color: Colors.grey),),
                          Text(
                            'Sep 20, 2023',
                            style: AppTextStyles.body2.copyWith(
                                color: AppColors.textDark.withOpacity(0.8)
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Image.asset('assets/images/box.png', width: 50, height: 50),
                  const SizedBox(width: 10,)
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );

  }
}