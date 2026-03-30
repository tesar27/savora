/// Opening-hours entry for one day of the week.
class OpeningHours {
  const OpeningHours({
    required this.day,
    this.open,
    this.close,
  });

  /// Day name, e.g. "Monday".
  final String day;

  /// Opening time in "HH:MM" format; null if closed all day.
  final String? open;

  /// Closing time in "HH:MM" format; null if closed all day.
  final String? close;

  bool get isClosed => open == null || close == null;
}
