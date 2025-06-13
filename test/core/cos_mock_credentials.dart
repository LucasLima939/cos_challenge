import 'dart:math';

class CosMockCredentials {
  CosMockCredentials._();
  static const email = 'test@test.com';
  static const password = '123456';
  static const vin = '1YVWB32R5CU123456';
  static const errorMessage = 'Please try again in 111 seconds';

  static String get errorJson =>
      '''
  {
  "msgKey": "maintenance",
  "params": { "delaySeconds": "111" },
  "message": "$errorMessage"
  }
  ''';

  static String get vehicleJson =>
      '''
    {
      "id": ${Random().nextInt(1000000)},
      "feedback": "Please modify the price.",
      "valuatedAt": "2023-01-05T14:08:40.456Z",
      "requestedAt": "2023-01-05T14:08:40.456Z",
      "createdAt": "2023-01-05T14:08:40.456Z",
      "updatedAt": "2023-01-05T14:08:42.153Z",
      "make": "Toyota",
      "model": "GT 86 Basis",
      "externalId": "DE003-018601450020008",
      "_fk_sellerUser": "25475e37-6973-483b-9b15-cfee721fc29f",
      "price": ${Random().nextInt(1000)},
      "positiveCustomerFeedback": ${Random().nextBool()},
      "_fk_uuid_auction": "3e255ad2-36d4-4048-a962-5e84e27bfa6e",
      "inspectorRequestedAt": "2023-01-05T14:08:40.456Z",
      "origin": "AUCTION",
      "estimationRequestId": "3a295387d07f"
    }
''';
}
