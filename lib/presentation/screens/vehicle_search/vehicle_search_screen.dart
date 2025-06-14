import 'package:cos_challenge/core/constants/app_routes.dart';
import 'package:cos_challenge/core/utils/snackbar_utils.dart';
import 'package:cos_challenge/domain/models/multiselection_vehicle_model.dart';
import 'package:cos_challenge/presentation/cubits/vehicle_search/vehicle_search_cubit.dart';
import 'package:cos_challenge/presentation/cubits/vehicle_search/vehicle_search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehicleSearchScreen extends StatefulWidget {
  const VehicleSearchScreen({super.key});

  @override
  State<VehicleSearchScreen> createState() => _VehicleSearchScreenState();
}

class _VehicleSearchScreenState extends State<VehicleSearchScreen> {
  late final _vehicleSearchCubit = context.read<VehicleSearchCubit>();
  final _vinController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late List<MultiSelectionVehicleModel> _multiSelectionVehicles;

  Future<void> _searchVehicle() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      await _vehicleSearchCubit.searchVehicle(_vinController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocConsumer<VehicleSearchCubit, VehicleSearchState>(
        bloc: _vehicleSearchCubit,
        listener: (context, state) {
          if (state is VehicleSearchSuccess) {
            Navigator.pushNamed(
              context,
              AppRoutes.vehicleDetails,
              arguments: state.vehicle,
            );
          } else if (state is VehicleSearchFailure) {
            SnackbarUtils.showError(context, state.failure.message);
          }
        },
        builder: (context, state) {
          final isLoading = state is VehicleSearchLoading;
          _multiSelectionVehicles = [];
          if (state is VehicleSearchMultiSelection) {
            _multiSelectionVehicles = state.vehicles;
          }

          return Scaffold(
            body: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      enabled: !isLoading,
                      controller: _vinController,
                      autovalidateMode: AutovalidateMode.onUnfocus,
                      decoration: InputDecoration(
                        hintText: 'Type the VIN number',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'VIN is required';
                        }
                        if (value.length != 17) {
                          return 'VIN must be 17 characters long';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: !isLoading
                            ? () async => await _searchVehicle()
                            : null,
                        child: isLoading
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: const CircularProgressIndicator(),
                              )
                            : const Text('Search'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (_multiSelectionVehicles.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _multiSelectionVehicles.length,
                        itemBuilder: (context, index) =>
                            _buildMultiSelectionCard(
                              _multiSelectionVehicles[index],
                            ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMultiSelectionCard(MultiSelectionVehicleModel vehicle) =>
      InkWell(
        onTap: () async => _searchVehicle(),
        child: Card(
          child: ListTile(
            title: Text('${vehicle.make} ${vehicle.model}'),
            trailing: Text(
              '${vehicle.similarity}%',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );

  @override
  void dispose() {
    _vinController.dispose();
    super.dispose();
  }
}
