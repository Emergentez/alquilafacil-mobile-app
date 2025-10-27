import 'package:flutter/material.dart';

class ReservationDetails {
  final String owner;
  final String spaceName;
  final DateTime selectedDay;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String voucherImageUrl;

  const ReservationDetails({
    required this.owner,
    required this.spaceName,
    required this.selectedDay,
    required this.startTime,
    required this.endTime,
    this.voucherImageUrl = "",
  });

}