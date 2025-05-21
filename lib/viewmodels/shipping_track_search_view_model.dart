import 'package:flutter/material.dart';
import '../models/shipment.dart';

class ShippingTrackSearchViewModel extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  final List<Shipment> _shipments = [
    Shipment(
      id: '1',
      number: 'NE4385734085790',
      sender: 'Macbook pro M2',
      senderLocation: 'Paris',
      receiver: '',
      receiverLocation: 'Morocco',
      status: 'In Transit',
      estimatedDelivery: '',
    ),
    Shipment(
      id: '2',
      number: 'NEJ2008993412231',
      sender: 'Summer linen jacket',
      senderLocation: 'Barcelona',
      receiver: '',
      receiverLocation: 'Paris',
      status: 'In Transit',
      estimatedDelivery: '',
    ),
    Shipment(
      id: '3',
      number: 'NEJ3587026497865',
      sender: 'Tapered-fit jeans AW',
      senderLocation: 'Colombia',
      receiver: '',
      receiverLocation: 'Paris',
      status: 'In Transit',
      estimatedDelivery: '',
    ),
    Shipment(
      id: '4',
      number: 'NEJ3587026497865',
      sender: 'Slim fit jeans AW',
      senderLocation: 'Bogota',
      receiver: '',
      receiverLocation: 'Dhaka',
      status: 'In Transit',
      estimatedDelivery: '',
    ),
    Shipment(
      id: '5',
      number: 'NEJ2348157075496',
      sender: 'Office setup desk',
      senderLocation: 'France',
      receiver: '',
      receiverLocation: 'German',
      status: 'In Transit',
      estimatedDelivery: '',
    ),
  ];

  List<Shipment> get filteredShipments {
    final query = searchController.text.toLowerCase();
    if (query.isEmpty) return _shipments;

    return _shipments
        .where((shipment) =>
            shipment.sender.toLowerCase().contains(query) ||
            shipment.number.toLowerCase().contains(query) ||
            shipment.senderLocation.toLowerCase().contains(query) ||
            shipment.receiverLocation.toLowerCase().contains(query))
        .toList();
  }

  void onSearchChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
