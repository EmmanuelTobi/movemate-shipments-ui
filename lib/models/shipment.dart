class Shipment {
  final String id;
  final String number;
  final String sender;
  final String senderLocation;
  final String receiver;
  final String receiverLocation;
  final String status;
  final String estimatedDelivery;

  Shipment({
    required this.id,
    required this.number,
    required this.sender,
    required this.senderLocation,
    required this.receiver,
    required this.receiverLocation,
    required this.status,
    required this.estimatedDelivery,
  });
}
