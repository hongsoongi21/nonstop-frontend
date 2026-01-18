import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../data/api/timetable_api_impl.dart';
import '../../data/dto/timetable_dto.dart';
import '../../data/dto/timetable_entry_dto.dart';
import '../../domain/entities/semester.dart';
import '../../domain/entities/timetable.dart';
import '../../domain/entities/timetable_entry.dart';

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
  final TimetableApi _api;

  TimetableManagementNotifier(this._api) : super(TimetableManagementState());

  /// Load semesters (for creating new timetables)
  Future<void> loadSemesters() async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _api.getSemesters();

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: 'Failed to load semesters',
      ),
      (semesterDtos) {
        final semesters = semesterDtos
            .map((dto) => Semester.fromDto(dto))
            .toList();
        state = state.copyWith(isLoading: false, semesters: semesters);
      },
    );
  }

  /// Load user's timetables
  Future<void> loadMyTimetables() async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _api.getMyTimetables();

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: 'Failed to load timetables',
      ),
      (timetableDtos) {
        final timetables = timetableDtos
            .map((dto) => Timetable.fromDto(dto))
            .toList();
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

    final request = TimetableRequestDto(
      semesterId: semesterId,
      title: title,
      isPublic: isPublic,
    );

    final result = await _api.createTimetable(request);

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: 'Failed to create timetable',
        );
        return false;
      },
      (timetableDto) {
        final newTimetable = Timetable.fromDto(timetableDto);
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

    final result = await _api.getTimetableDetail(timetableId);

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: 'Failed to load timetable details',
      ),
      (detailDto) {
        final detail = TimetableDetail.fromDto(detailDto);
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

    final request = TimetableRequestDto(title: title, isPublic: isPublic);

    final result = await _api.updateTimetable(timetableId, request);

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: 'Failed to update timetable',
        );
        return false;
      },
      (updatedDto) {
        final updated = Timetable.fromDto(updatedDto);
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

    final result = await _api.deleteTimetable(timetableId);

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

    final request = TimetableEntryRequestDto(
      subjectName: subjectName,
      professor: professor,
      dayOfWeek: dayOfWeek,
      startTime: startTime,
      endTime: endTime,
      place: place,
      color: color,
    );

    final result = await _api.addEntry(state.selectedTimetableId!, request);

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

    final request = TimetableEntryRequestDto(
      subjectName: subjectName,
      professor: professor,
      dayOfWeek: dayOfWeek,
      startTime: startTime,
      endTime: endTime,
      place: place,
      color: color,
    );

    final result = await _api.updateEntry(entryId, request);

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

    final result = await _api.deleteEntry(entryId);

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
    final semResult = await _api.getSemesters();
    if (semResult.isLeft()) {
      state = state.copyWith(
        isLoading: false,
        error: 'Semesters loading failed',
      );
      return;
    }

    final semesterDtos = semResult.getOrElse((_) => []);
    final semesters = semesterDtos.map((dto) => Semester.fromDto(dto)).toList();

    // 2. Find "Current" Semester using backend flag
    // If multiple are marked current (shouldn't happen), take first.
    // If none, fallback to first in list.
    final currentSemester =
        semesters.where((s) => s.isCurrent).firstOrNull ??
        semesters.firstOrNull;

    // 3. Load User Timetables
    final ttResult = await _api.getMyTimetables();
    final timetableDtos = ttResult.getOrElse((_) => []);
    final timetables = timetableDtos
        .map((dto) => Timetable.fromDto(dto))
        .toList();

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
      final api = ref.watch(timetableApiProvider);
      return TimetableManagementNotifier(api);
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
