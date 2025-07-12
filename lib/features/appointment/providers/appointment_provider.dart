import 'package:flutter/material.dart';
import 'package:appointment_system/core/providers/appointment_provider.dart'; // Re-exporting core AppointmentProvider

// This file can be used to extend or combine AppointmentProvider functionalities
// specific to the 'appointment' feature, if needed. For now, it simply re-exports
// the core AppointmentProvider.

class FeatureAppointmentProvider extends AppointmentProvider {
  FeatureAppointmentProvider() : super();

  // You can add feature-specific appointment logic here if necessary
  // For example, handling complex booking flows, specific filters, etc.
}