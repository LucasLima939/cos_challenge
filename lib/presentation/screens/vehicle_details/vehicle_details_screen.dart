import 'package:cos_challenge/domain/models/vehicle_model.dart';
import 'package:flutter/material.dart';

class VehicleDetailsScreen extends StatelessWidget {
  const VehicleDetailsScreen({super.key, required this.vehicle});
  final VehicleModel vehicle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vehicle Details')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Card(
            child: ListTile(
              title: Text('${vehicle.make} ${vehicle.model}'),
              subtitle: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('€ ${vehicle.price.toStringAsFixed(2)}'),
                  Text(vehicle.auctionId),
                ],
              ),
              trailing: vehicle.positiveCustomerFeedback
                  ? const Icon(Icons.thumb_up, color: Colors.green)
                  : const Icon(Icons.thumb_down, color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}
