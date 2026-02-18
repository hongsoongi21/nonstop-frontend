/// Parses a datetime string from Supabase as UTC.
/// Supabase returns timestamps without timezone suffix, which DateTime.parse
/// treats as local time. This ensures they are correctly parsed as UTC.
DateTime parseUtcDateTime(String dateTimeString) {
  final dt = DateTime.parse(dateTimeString);
  return dt.isUtc ? dt : DateTime.utc(dt.year, dt.month, dt.day, dt.hour, dt.minute, dt.second, dt.millisecond, dt.microsecond);
}

String timeAgo(DateTime dateTime) {
  final localDateTime = dateTime.toLocal();
  final duration = DateTime.now().difference(localDateTime);
  if (duration.inDays > 7) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
  }
  if (duration.inDays > 0) return '${duration.inDays}d';
  if (duration.inHours > 0) return '${duration.inHours}h';
  if (duration.inMinutes > 0) return '${duration.inMinutes}m';
  return 'now';
}
