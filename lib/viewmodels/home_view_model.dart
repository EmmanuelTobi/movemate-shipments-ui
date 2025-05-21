import 'package:flutter/material.dart';
import '../models/shipment.dart';
import '../models/vehicle.dart';

class HomeViewModel extends ChangeNotifier {

  final String _userName = "John Doe";
  final String _userLocation = "Wertheimer, Illinois";
  final String _profileImagePath = "assets/images/profile.svg";


  final Shipment _currentShipment = Shipment(
    id: "1",
    number: "NEJ20089934122231",
    sender: "Atlanta",
    senderLocation: "5243",
    receiver: "Chicago",
    receiverLocation: "6342",
    status: "Waiting to collect",
    estimatedDelivery: "2 day -3 days",
  );

  List<Vehicle> _vehicles = [
    Vehicle(
      id: "1",
      name: "Ocean freight",
      description: "International",
      iconPath: "assets/images/ocean-freight.png",
      isSelected: true,
    ),
    Vehicle(
      id: "2",
      name: "Cargo freight",
      description: "Reliable",
      iconPath: "assets/images/cargo-freight.png",
    ),
    Vehicle(
      id: "3",
      name: "Air freight",
      description: "International",
      iconPath: "assets/images/airplane-freight.png",
    ),
  ];

  String _searchQuery = "";


  String get userName => _userName;
  String get userLocation => _userLocation;
  String get profileImagePath => _profileImagePath;
  Shipment get currentShipment => _currentShipment;
  List<Vehicle> get vehicles => _vehicles;
  String get searchQuery => _searchQuery;


  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void selectVehicle(String id) {

    // int previousSelectedIndex =
    //     _vehicles.indexWhere((vehicle) => vehicle.isSelected);

    _vehicles = _vehicles.map((vehicle) {
      return vehicle.copyWith(isSelected: vehicle.id == id);
    }).toList();

    notifyListeners();
  }

  void addShipmentStop() {
    notifyListeners();
  }
}
