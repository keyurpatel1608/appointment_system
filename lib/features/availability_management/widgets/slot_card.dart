import 'package:flutter/material.dart';
import 'package:appointment_system/core/models/slot_model.dart';
import 'package:appointment_system/core/utils/date_utils.dart';

class SlotCard extends StatelessWidget {
  final Slot slot;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  const SlotCard({
    super.key,
    required this.slot,
    this.onEdit,
    this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Slot ID: ${slot.id}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text('Start: ${DateUtil.formatDateTime(slot.startTime)}'),
              Text('End: ${DateUtil.formatDateTime(slot.endTime)}'),
              const SizedBox(height: 4),
              Text('Booked: ${slot.isBooked ? 'Yes' : 'No'}'),
              if (onEdit != null || onDelete != null)
                Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (onEdit != null)
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: onEdit,
                        ),
                      if (onDelete != null)
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: onDelete,
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}