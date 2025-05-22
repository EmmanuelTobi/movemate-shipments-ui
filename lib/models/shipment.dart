class Shipment {
  final String id;
  final String number;
  final String sender;
  final String senderLocation;
  final String receiver;
  final String receiverLocation;
  final String status;
  final int? amount;
  final String estimatedDelivery;

  Shipment({
    required this.id,
    required this.number,
    required this.sender,
    required this.senderLocation,
    required this.receiver,
    required this.receiverLocation,
    this.amount,
    required this.status,
    required this.estimatedDelivery,
  });
}
