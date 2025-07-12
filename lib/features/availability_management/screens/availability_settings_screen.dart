import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appointment_system/features/availability_management/providers/availability_provider.dart';
import 'package:appointment_system/core/models/slot_model.dart';
import 'package:appointment_system/core/utils/date_utils.dart';

class AvailabilitySettingsScreen extends StatefulWidget {
  const AvailabilitySettingsScreen({super.key});

  @override
  State<AvailabilitySettingsScreen> createState() => _AvailabilitySettingsScreenState();
}

class _AvailabilitySettingsScreenState extends State<AvailabilitySettingsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<AvailabilityProvider>(context, listen: false).fetchAvailabilitySlots();
  }

  void _addSlot() {
    Navigator.of(context).pushNamed('/add_slot');
  }

  void _editSlot(Slot slot) {
    Navigator.of(context).pushNamed('/edit_slot', arguments: slot);
  }

  void _deleteSlot(String slotId) {
    Provider.of<AvailabilityProvider>(context, listen: false).deleteAvailabilitySlot(slotId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Availability Settings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addSlot,
          ),
        ],
      ),
      body: Consumer<AvailabilityProvider>(
        builder: (context, availabilityProvider, child) {
          if (availabilityProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (availabilityProvider.availabilitySlots.isEmpty) {
            return const Center(child: Text('No availability slots found.'));
          } else {
            return ListView.builder(
              itemCount: availabilityProvider.availabilitySlots.length,
              itemBuilder: (context, index) {
                final slot = availabilityProvider.availabilitySlots[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text('Slot ID: ${slot.id}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Start: ${DateUtil.formatDateTime(slot.startTime)}'),
                        Text('End: ${DateUtil.formatDateTime(slot.endTime)}'),
                        Text('Booked: ${slot.isBooked ? 'Yes' : 'No'}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _editSlot(slot),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text('Confirm Delete'),
                                content: const Text('Do you want to delete this slot?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      _deleteSlot(slot.id);
                                      Navigator.of(ctx).pop();
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}