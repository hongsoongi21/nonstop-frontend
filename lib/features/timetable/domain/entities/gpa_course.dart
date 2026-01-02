import 'dart:math';

class GpaCourse {
  final String id;
  final String name;
  final double credits;
  final String grade; // "A+", "A0", etc.
  final bool isMajor;
  final bool includeInCalc; // For P/F courses that count for credits but not GPA

  const GpaCourse({
    required this.id,
    required this.name,
    required this.credits,
    required this.grade,
    this.isMajor = false,
    this.includeInCalc = true,
  });

  factory GpaCourse.create({
    required String name,
    double credits = 3.0,
    String grade = 'A+',
    bool isMajor = false,
  }) {
    return GpaCourse(
      id: DateTime.now().millisecondsSinceEpoch.toString() +
          Random().nextInt(1000).toString(),
      name: name,
      credits: credits,
      grade: grade,
      isMajor: isMajor,
    );
  }

  GpaCourse copyWith({
    String? id,
    String? name,
    double? credits,
    String? grade,
    bool? isMajor,
    bool? includeInCalc,
  }) {
    return GpaCourse(
      id: id ?? this.id,
      name: name ?? this.name,
      credits: credits ?? this.credits,
      grade: grade ?? this.grade,
      isMajor: isMajor ?? this.isMajor,
      includeInCalc: includeInCalc ?? this.includeInCalc,
    );
  }

  double get gradePoints {
    switch (grade) {
      case 'A+':
        return 4.5;
      case 'A0':
        return 4.0;
      case 'B+':
        return 3.5;
      case 'B0':
        return 3.0;
      case 'C+':
        return 2.5;
      case 'C0':
        return 2.0;
      case 'D+':
        return 1.5;
      case 'D0':
        return 1.0;
      case 'F':
        return 0.0;
      case 'P':
        return 0.0; // Pass usually doesn't affect GPA
      case 'NP':
        return 0.0; // No Pass usually doesn't affect GPA
      default:
        return 0.0;
    }
  }

  bool get isGraded {
    return grade != 'P' && grade != 'NP';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GpaCourse &&
        other.id == id &&
        other.name == name &&
        other.credits == credits &&
        other.grade == grade &&
        other.isMajor == isMajor &&
        other.includeInCalc == includeInCalc;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        credits.hashCode ^
        grade.hashCode ^
        isMajor.hashCode ^
        includeInCalc.hashCode;
  }
}

