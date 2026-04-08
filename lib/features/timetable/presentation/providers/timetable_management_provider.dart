import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/logger.dart';
import '../../data/dto/semester_dto.dart';
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
    required int year,
    required SemesterType semesterType,
    String? title,
    bool isPublic = false,
    TimetableKind kind = TimetableKind.backup,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _repository.createTimetable(
      year: year,
      semesterType: semesterType,
      title: title,
      isPublic: isPublic,
      kind: kind,
    );

    if (result.isLeft()) {
      final errorMsg = result.fold(
        (failure) => failure.maybeWhen(
          server: (message, _, __) => message,
          orElse: () => 'Failed to create timetable',
        ),
        (_) => 'Failed to create timetable',
      );
      state = state.copyWith(
        isLoading: false,
        error: errorMsg,
      );
      return false;
    }

    final newTimetable = result.getOrElse((_) => throw StateError('Unreachable'));
    final updatedList = [...state.myTimetables, newTimetable];
    state = state.copyWith(isLoading: false, myTimetables: updatedList);

    // Auto-select the new timetable (must await to ensure state is set)
    await selectTimetable(newTimetable.id);
    AppLogger.d('[TIMETABLE] createTimetable completed. selectedTimetableId: ${state.selectedTimetableId}');
    return true;
  }

  /// Select and load a specific timetable with its entries
  Future<void> selectTimetable(int timetableId) async {
    AppLogger.d('[TIMETABLE] selectTimetable called with id: $timetableId');
    state = state.copyWith(
      isLoading: true,
      clearError: true,
      selectedTimetableId: timetableId,
    );
    AppLogger.d('[TIMETABLE] selectedTimetableId set to: ${state.selectedTimetableId}');

    final result = await _repository.getTimetableDetail(timetableId);

    result.fold(
      (failure) {
        AppLogger.w('[TIMETABLE] ERROR: Failed to load timetable details');
        state = state.copyWith(
          isLoading: false,
          error: 'Failed to load timetable details',
        );
      },
      (detail) {
        AppLogger.d('[TIMETABLE] Timetable detail loaded successfully');
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
        final wasSelected = state.selectedTimetableId == timetableId;
        final updatedList = state.myTimetables
            .where((t) => t.id != timetableId)
            .toList();
        state = state.copyWith(
          isLoading: false,
          myTimetables: updatedList,
          clearSelectedTimetable: wasSelected,
        );

        // Auto-select first timetable if we deleted the selected one
        if (wasSelected && updatedList.isNotEmpty) {
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
    int? credit,
  }) async {
    AppLogger.d('[TIMETABLE] addEntry called. selectedTimetableId: ${state.selectedTimetableId}');

    // If no timetable selected, try to initialize first
    if (state.selectedTimetableId == null) {
      AppLogger.d('[TIMETABLE] No timetable selected, calling initializeTimetable...');
      await initializeTimetable();
      AppLogger.d('[TIMETABLE] After initialization, selectedTimetableId: ${state.selectedTimetableId}');

      // If still no timetable after initialization, return error
      if (state.selectedTimetableId == null) {
        AppLogger.w('[TIMETABLE] ERROR: Still no timetable after initialization');
        // Keep the existing error if set (e.g., "No semesters available")
        // or set a generic one
        if (state.error == null) {
          state = state.copyWith(error: 'No timetable available. Please create a timetable first.');
        }
        return false;
      }
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
      credit: credit,
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
    int? credit,
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
      credit: credit,
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
  /// - Loads semesters and user's timetables
  /// - Determines current semester from local date (not DB isCurrent flag)
  /// - Auto-creates or auto-selects the appropriate timetable
  Future<void> initializeTimetable() async {
    AppLogger.d('[TIMETABLE] initializeTimetable started');
    state = state.copyWith(isLoading: true, clearError: true);

    // 1. Load Semesters + Timetables in parallel
    final results = await Future.wait([
      _repository.getSemesters(),
      _repository.getMyTimetables(),
    ]);

    final semResult = results[0] as dynamic;
    final ttResult = results[1] as dynamic;

    if (semResult.isLeft()) {
      AppLogger.w('[TIMETABLE] ERROR: Semesters loading failed');
      state = state.copyWith(
        isLoading: false,
        error: 'Semesters loading failed',
      );
      return;
    }

    final semesters = semResult.getOrElse((_) => <Semester>[]) as List<Semester>;
    final timetables = ttResult.getOrElse((_) => <Timetable>[]) as List<Timetable>;
    AppLogger.d('[TIMETABLE] Loaded ${semesters.length} semesters, ${timetables.length} timetables');

    state = state.copyWith(semesters: semesters, myTimetables: timetables);

    // 2. Determine current semester from local date
    final now = DateTime.now();
    final currentYear = now.month <= 2 ? now.year - 1 : now.year;
    final SemesterType currentType;
    if (now.month >= 3 && now.month <= 8) {
      currentType = SemesterType.first;
    } else {
      currentType = SemesterType.second;
    }
    AppLogger.d('[TIMETABLE] Current semester: year=$currentYear, type=$currentType');

    // 3. Filter timetables by year + semesterType (not by semesterId/isCurrent)
    final currentTimetables = timetables
        .where((t) => t.year == currentYear && t.semesterType == currentType)
        .toList();
    AppLogger.d('[TIMETABLE] Timetables for current semester: ${currentTimetables.length}');

    // 4. Auto-Setup Logic
    if (currentTimetables.isNotEmpty) {
      // Prefer the `main` timetable, otherwise fallback to the first entry.
      final defaultTt = currentTimetables.firstWhere(
        (t) => t.kind == TimetableKind.main,
        orElse: () => currentTimetables.first,
      );
      AppLogger.d('[TIMETABLE] Selecting existing timetable: ${defaultTt.id}');
      await selectTimetable(defaultTt.id);
    } else {
      // No timetable for current semester - auto-create the main timetable.
      AppLogger.d('[TIMETABLE] Auto-creating main timetable for year=$currentYear, type=$currentType');
      await createTimetable(
        year: currentYear,
        semesterType: currentType,
        kind: TimetableKind.main,
      );
    }

    AppLogger.d('[TIMETABLE] initializeTimetable finished. selectedTimetableId: ${state.selectedTimetableId}');
    if (state.isLoading) {
      state = state.copyWith(isLoading: false);
    }
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
