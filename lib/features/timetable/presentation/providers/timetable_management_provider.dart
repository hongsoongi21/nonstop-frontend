import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository_impl/timetable_repository_impl.dart';
import '../../domain/entities/day_of_week.dart';
import '../../domain/entities/semester.dart';
import '../../domain/entities/timetable.dart';
import '../../domain/entities/timetable_entry.dart';
import '../../domain/repository/timetable_repository.dart';

/// State for timetable management
class TimetableManagementState {
  final bool isLoading;
  final String? error;
  final List<Semester> semesters;
  final List<Timetable> myTimetables;
  final TimetableDetail? selectedTimetable;
  final int? selectedTimetableId;

  TimetableManagementState({
    this.isLoading = false,
    this.error,
    this.semesters = const [],
    this.myTimetables = const [],
    this.selectedTimetable,
    this.selectedTimetableId,
  });

  TimetableManagementState copyWith({
    bool? isLoading,
    String? error,
    List<Semester>? semesters,
    List<Timetable>? myTimetables,
    TimetableDetail? selectedTimetable,
    int? selectedTimetableId,
    bool clearError = false,
    bool clearSelectedTimetable = false,
  }) {
    return TimetableManagementState(
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      semesters: semesters ?? this.semesters,
      myTimetables: myTimetables ?? this.myTimetables,
      selectedTimetable: clearSelectedTimetable
          ? null
          : (selectedTimetable ?? this.selectedTimetable),
      selectedTimetableId: clearSelectedTimetable
          ? null
          : (selectedTimetableId ?? this.selectedTimetableId),
    );
  }

  /// Get entries for a specific day from selected timetable
  List<TimetableEntry> entriesForDay(int weekdayNumber) {
    return selectedTimetable?.entriesForDay(weekdayNumber) ?? [];
  }

  /// Check if there are conflicts in the selected timetable
  bool get hasConflicts => selectedTimetable?.hasConflicts() ?? false;
}

/// Provider for Timetable Management
class TimetableManagementNotifier
    extends StateNotifier<TimetableManagementState> {
  final TimetableRepository _repository;

  TimetableManagementNotifier(this._repository)
    : super(TimetableManagementState());

  /// Load semesters (for creating new timetables)
  Future<void> loadSemesters() async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _repository.getSemesters();

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: 'Failed to load semesters',
      ),
      (semesters) {
        state = state.copyWith(isLoading: false, semesters: semesters);
      },
    );
  }

  /// Load user's timetables
  Future<void> loadMyTimetables() async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _repository.getMyTimetables();

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: 'Failed to load timetables',
      ),
      (timetables) {
        state = state.copyWith(isLoading: false, myTimetables: timetables);

        // Auto-select first timetable if none selected
        if (state.selectedTimetableId == null && timetables.isNotEmpty) {
          selectTimetable(timetables.first.id);
        }
      },
    );
  }

  /// Create a new timetable
  Future<bool> createTimetable({
    required int semesterId,
    String? title,
    bool isPublic = false,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _repository.createTimetable(
      semesterId: semesterId,
      title: title,
      isPublic: isPublic,
    );

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: 'Failed to create timetable',
        );
        return false;
      },
      (newTimetable) {
        final updatedList = [...state.myTimetables, newTimetable];
        state = state.copyWith(isLoading: false, myTimetables: updatedList);

        // Auto-select the new timetable
        selectTimetable(newTimetable.id);
        return true;
      },
    );
  }

  /// Select and load a specific timetable with its entries
  Future<void> selectTimetable(int timetableId) async {
    state = state.copyWith(
      isLoading: true,
      clearError: true,
      selectedTimetableId: timetableId,
    );

    final result = await _repository.getTimetableDetail(timetableId);

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: 'Failed to load timetable details',
      ),
      (detail) {
        state = state.copyWith(isLoading: false, selectedTimetable: detail);
      },
    );
  }

  /// Update timetable name or public status
  Future<bool> updateTimetable({
    required int timetableId,
    String? title,
    bool? isPublic,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _repository.updateTimetable(
      id: timetableId,
      title: title,
      isPublic: isPublic,
    );

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: 'Failed to update timetable',
        );
        return false;
      },
      (updated) {
        final updatedList = state.myTimetables
            .map((t) => t.id == timetableId ? updated : t)
            .toList();
        state = state.copyWith(isLoading: false, myTimetables: updatedList);

        // Reload detail if this is the selected timetable
        if (state.selectedTimetableId == timetableId) {
          selectTimetable(timetableId);
        }
        return true;
      },
    );
  }

  /// Delete a timetable
  Future<bool> deleteTimetable(int timetableId) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _repository.deleteTimetable(timetableId);

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: 'Failed to delete timetable',
        );
        return false;
      },
      (_) {
        final updatedList = state.myTimetables
            .where((t) => t.id != timetableId)
            .toList();
        state = state.copyWith(
          isLoading: false,
          myTimetables: updatedList,
          clearSelectedTimetable: state.selectedTimetableId == timetableId,
        );

        // Auto-select first timetable if we deleted the selected one
        if (state.selectedTimetableId == timetableId &&
            updatedList.isNotEmpty) {
          selectTimetable(updatedList.first.id);
        }
        return true;
      },
    );
  }

  /// Add an entry to the selected timetable
  Future<bool> addEntry({
    required String subjectName,
    String? professor,
    required DayOfWeek dayOfWeek,
    required String startTime,
    required String endTime,
    String? place,
    String? color,
  }) async {
    if (state.selectedTimetableId == null) {
      state = state.copyWith(error: 'No timetable selected');
      return false;
    }

    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _repository.addEntry(
      timetableId: state.selectedTimetableId!,
      subjectName: subjectName,
      professor: professor,
      dayOfWeek: dayOfWeek,
      startTime: startTime,
      endTime: endTime,
      place: place,
      color: color,
    );

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: 'Failed to add class (check for time conflicts)',
        );
        return false;
      },
      (_) {
        // Reload the timetable detail to get the updated entries
        selectTimetable(state.selectedTimetableId!);
        return true;
      },
    );
  }

  /// Update an entry
  Future<bool> updateEntry({
    required int entryId,
    required String subjectName,
    String? professor,
    required DayOfWeek dayOfWeek,
    required String startTime,
    required String endTime,
    String? place,
    String? color,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _repository.updateEntry(
      entryId: entryId,
      subjectName: subjectName,
      professor: professor,
      dayOfWeek: dayOfWeek,
      startTime: startTime,
      endTime: endTime,
      place: place,
      color: color,
    );

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: 'Failed to update class',
        );
        return false;
      },
      (_) {
        // Reload the timetable detail
        if (state.selectedTimetableId != null) {
          selectTimetable(state.selectedTimetableId!);
        }
        return true;
      },
    );
  }

  /// Delete an entry
  Future<bool> deleteEntry(int entryId) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _repository.deleteEntry(entryId);

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: 'Failed to delete class',
        );
        return false;
      },
      (_) {
        // Reload the timetable detail
        if (state.selectedTimetableId != null) {
          selectTimetable(state.selectedTimetableId!);
        }
        return true;
      },
    );
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(clearError: true);
  }

  /// Load everything with "Smart Defaults" logic
  /// - Loads semesters and finding current one via backend flag
  /// - Loads user's timetables
  /// - Auto-creates or auto-selects the appropriate timetable
  Future<void> initializeTimetable() async {
    state = state.copyWith(isLoading: true, clearError: true);

    // 1. Load Semesters
    final semResult = await _repository.getSemesters();
    if (semResult.isLeft()) {
      state = state.copyWith(
        isLoading: false,
        error: 'Semesters loading failed',
      );
      return;
    }

    final semesters = semResult.getOrElse((_) => []);

    // 2. Find "Current" Semester using backend flag
    // If multiple are marked current (shouldn't happen), take first.
    // If none, fallback to first in list.
    final currentSemester =
        semesters.where((s) => s.isCurrent).firstOrNull ??
        semesters.firstOrNull;

    // 3. Load User Timetables
    final ttResult = await _repository.getMyTimetables();
    final timetables = ttResult.getOrElse((_) => []);

    state = state.copyWith(semesters: semesters, myTimetables: timetables);

    // 4. Auto-Setup Logic
    if (currentSemester != null) {
      final currentTimetables = timetables
          .where((t) => t.semesterId == currentSemester.id)
          .toList();

      if (currentTimetables.isEmpty) {
        // Automatically create a default one if none exists for current semester
        await createTimetable(
          semesterId: currentSemester.id,
          title: 'Asosiy jadval',
        );
      } else if (state.selectedTimetableId == null) {
        // Auto-select the first one of the current semester
        await selectTimetable(currentTimetables.first.id);
      }
    } else if (timetables.isNotEmpty && state.selectedTimetableId == null) {
      // Fallback: just select any existing timetable
      await selectTimetable(timetables.first.id);
    }

    state = state.copyWith(isLoading: false);
  }
}

/// Main provider for timetable management
final timetableManagementProvider =
    StateNotifierProvider<
      TimetableManagementNotifier,
      TimetableManagementState
    >((ref) {
      final repository = ref.watch(timetableRepositoryProvider);
      return TimetableManagementNotifier(repository);
    });

/// Convenience providers for specific state slices
final timetableLoadingProvider = Provider<bool>((ref) {
  return ref.watch(timetableManagementProvider).isLoading;
});

final timetableErrorProvider = Provider<String?>((ref) {
  return ref.watch(timetableManagementProvider).error;
});

final myTimetablesProvider = Provider<List<Timetable>>((ref) {
  return ref.watch(timetableManagementProvider).myTimetables;
});

final selectedTimetableProvider = Provider<TimetableDetail?>((ref) {
  return ref.watch(timetableManagementProvider).selectedTimetable;
});

final semestersProvider = Provider<List<Semester>>((ref) {
  return ref.watch(timetableManagementProvider).semesters;
});

/// Provider to get entries for a specific weekday
final entriesForDayProvider = Provider.family<List<TimetableEntry>, int>((
  ref,
  weekdayNumber,
) {
  return ref.watch(timetableManagementProvider).entriesForDay(weekdayNumber);
});
