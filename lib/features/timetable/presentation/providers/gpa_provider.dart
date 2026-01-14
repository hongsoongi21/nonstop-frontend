import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nonstop/features/timetable/domain/entities/event.dart';
import 'package:nonstop/features/timetable/domain/entities/gpa_course.dart';

class GpaState {
  final List<GpaCourse> courses;
  
  GpaState({this.courses = const []});

  double get totalCredits => courses.fold(0, (sum, course) => sum + course.credits);
  
  double get totalGpa {
    double totalPoints = 0;
    double calculatedCredits = 0;
    
    for (var course in courses) {
      if (course.includeInCalc && course.isGraded) {
        totalPoints += course.gradePoints * course.credits;
        calculatedCredits += course.credits;
      }
    }
    
    if (calculatedCredits == 0) return 0.0;
    return totalPoints / calculatedCredits;
  }

  double get majorGpa {
    double totalPoints = 0;
    double calculatedCredits = 0;
    
    for (var course in courses) {
      if (course.isMajor && course.includeInCalc && course.isGraded) {
        totalPoints += course.gradePoints * course.credits;
        calculatedCredits += course.credits;
      }
    }
    
    if (calculatedCredits == 0) return 0.0;
    return totalPoints / calculatedCredits;
  }
}

class GpaNotifier extends StateNotifier<GpaState> {
  GpaNotifier() : super(GpaState());

  void addCourse(GpaCourse course) {
    state = GpaState(courses: [...state.courses, course]);
  }

  void removeCourse(String id) {
    state = GpaState(courses: state.courses.where((c) => c.id != id).toList());
  }

  void updateCourse(GpaCourse updatedCourse) {
    state = GpaState(
      courses: state.courses.map((c) => c.id == updatedCourse.id ? updatedCourse : c).toList(),
    );
  }

  void clearAll() {
    state = GpaState(courses: []);
  }

  void importCourses(List<Event> events) {
    final newCourses = <GpaCourse>[];
    
    // Filter for course events only
    final courseEvents = events.where((e) => e.type == EventType.course).toList();
    
    for (final event in courseEvents) {
      // Check if course with same name already exists
      if (state.courses.any((c) => c.name == event.title)) {
        continue;
      }
      
      newCourses.add(GpaCourse.create(
        name: event.title,
        credits: 3.0, // Default to 3 credits as events might not have credit info
        grade: 'A+',  // Default grade
      ));
    }
    
    if (newCourses.isNotEmpty) {
      state = GpaState(courses: [...state.courses, ...newCourses]);
    }
  }
}

final gpaProvider = StateNotifierProvider<GpaNotifier, GpaState>((ref) {
  return GpaNotifier();
});
