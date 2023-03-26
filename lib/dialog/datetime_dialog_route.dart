import 'package:flutter/material.dart';

class DatetimeDialogRoute {
  /// [selectDate] Info
  /// [selectedDate] This highlights the selected date
  /// [currentDate] This outlined the preset/default date
  /// [startDate] This determine first available date for user to pick from
  /// [lastDate] This determine last available date for user to pick from
  /// [lastDate] This determine last available date for user to pick from
  static Future<DateTime?> selectDate(final BuildContext context, {
    final DateTime? selectedDate,
    final DateTime? currentDate,
    final DateTime? firstDate,
    final DateTime? lastDate,
  }) {
    return showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(1950),
      lastDate: lastDate ?? DateTime(2150),
      currentDate: currentDate,
    );
  }

  /// [selectTime] Info
  /// [selectedTime] This highlights the selected time
  static Future<TimeOfDay?> selectTime(final BuildContext context, {
    final TimeOfDay? selectedTime,
  }) {
    return showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
  }

  const DatetimeDialogRoute._();
}