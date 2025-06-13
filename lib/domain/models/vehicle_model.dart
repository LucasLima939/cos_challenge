import 'package:equatable/equatable.dart';

class VehicleModel extends Equatable {
  final int id;
  final String feedback;
  final DateTime valuatedAt;
  final DateTime requestedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String make;
  final String model;
  final String externalId;
  final String sellerUserId;
  final int price;
  final bool positiveCustomerFeedback;
  final String auctionId;
  final DateTime inspectorRequestedAt;
  final String origin;
  final String estimationRequestId;

  VehicleModel.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      feedback = json['feedback'],
      valuatedAt = DateTime.parse(json['valuatedAt']),
      requestedAt = DateTime.parse(json['requestedAt']),
      createdAt = DateTime.parse(json['createdAt']),
      updatedAt = DateTime.parse(json['updatedAt']),
      make = json['make'],
      model = json['model'],
      externalId = json['externalId'],
      sellerUserId = json['_fk_sellerUser'],
      price = json['price'],
      positiveCustomerFeedback = json['positiveCustomerFeedback'],
      auctionId = json['_fk_uuid_auction'],
      inspectorRequestedAt = DateTime.parse(json['inspectorRequestedAt']),
      origin = json['origin'],
      estimationRequestId = json['estimationRequestId'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'feedback': feedback,
    'valuatedAt': valuatedAt,
    'requestedAt': requestedAt,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'make': make,
    'model': model,
    'externalId': externalId,
    '_fk_sellerUser': sellerUserId,
    'price': price,
    'positiveCustomerFeedback': positiveCustomerFeedback,
    '_fk_uuid_auction': auctionId,
    'inspectorRequestedAt': inspectorRequestedAt,
    'origin': origin,
    'estimationRequestId': estimationRequestId,
  };

  @override
  List<Object?> get props => [
    id,
    feedback,
    valuatedAt,
    requestedAt,
    createdAt,
    updatedAt,
    make,
    model,
    externalId,
    sellerUserId,
    price,
    positiveCustomerFeedback,
    auctionId,
    inspectorRequestedAt,
    origin,
    estimationRequestId,
  ];
}
