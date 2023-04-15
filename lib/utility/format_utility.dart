class FormatUtility {
  static const validate = _Validation();

  static String date(final DateTime? dateTime) {
    if (dateTime == null) return '';

    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
  }

  static String time(final DateTime? dateTime) {
    if (dateTime == null) return '';

    return '${dateTime.hour > 12 ? dateTime.hour % 12 : dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')} ${dateTime.hour > 11 ? 'PM' : 'AM'}';
  }

  static String datetime(final DateTime? dateTime) {
    if (dateTime == null) return '';

    return '${date(dateTime)} | ${time(dateTime)}';
  }

  const FormatUtility._();
}

class _Validation {
  final valid = 0;
  final invalidEmpty = 1;

  const _Validation();

  int check(final String? text, {
    final bool checkContent = false,
  }) {
    if (checkContent) {
      if (text?.isEmpty ?? true) {
        return invalidEmpty;
      }
    }

    return valid;
  }
}