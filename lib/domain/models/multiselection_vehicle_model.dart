class MultiSelectionVehicleModel {
  final String make;
  final String model;
  final String containerName;
  final int similarity;
  final String externalId;

  MultiSelectionVehicleModel.fromJson(Map<String, dynamic> json)
    : make = json['make'],
      model = json['model'],
      containerName = json['containerName'],
      similarity = json['similarity'],
      externalId = json['externalId'];
}
