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
