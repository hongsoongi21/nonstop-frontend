/// The kind of a timetable — replaces display-string-based type detection
/// ('Asosiy jadval', '예비N'). See GitHub issue #2.
enum TimetableKind {
  main,
  backup;

  /// Wire value sent to and received from the backend (matches DB CHECK constraint).
  String get wireValue => name; // 'main' / 'backup'

  /// Parse a wire value from the backend. Defaults to [backup] for unknown /
  /// null values so old rows and old responses remain parseable.
  static TimetableKind fromWire(String? value) {
    switch (value) {
      case 'main':
        return TimetableKind.main;
      case 'backup':
        return TimetableKind.backup;
      default:
        return TimetableKind.backup;
    }
  }
}
