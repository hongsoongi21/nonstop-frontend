import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/failures.dart';
import '../../data/api/timetable_api_mock.dart';
import '../../data/repository_impl/timetable_repository_impl.dart';
import '../../domain/entities/event.dart';
import '../../domain/repository/timetable_repository.dart';
import '../../domain/usecases/create_event_usecase.dart';
import '../../domain/usecases/delete_event_usecase.dart';
import '../../domain/usecases/get_events_for_date_usecase.dart';
import '../../domain/usecases/get_events_for_month_usecase.dart';
import '../../domain/usecases/get_events_for_week_usecase.dart';
import '../../domain/usecases/get_events_usecase.dart';
import '../../domain/usecases/get_upcoming_events_usecase.dart';
import '../../domain/usecases/search_events_usecase.dart';
import '../../domain/usecases/update_event_usecase.dart';

/// Enum for different calendar view types
enum CalendarViewType {
  month,
  week,
  day,
  schedule, // List view
}

/// State for the timetable feature
class TimetableState {
  final bool isLoading;
  final String? error;
  final List<Event> events;
  final CalendarViewType viewType;
  final DateTime selectedDate;
  final DateTime focusedDate; // For calendar navigation
  final Set<String> selectedEventIds;
  final String? searchQuery;

  TimetableState({
    this.isLoading = false,
    this.error,
    this.events = const [],
    this.viewType = CalendarViewType.month,
    DateTime? selectedDate,
    DateTime? focusedDate,
    this.selectedEventIds = const {},
    this.searchQuery,
  }) : selectedDate = selectedDate ?? DateTime.now(),
       focusedDate = focusedDate ?? DateTime.now();

  TimetableState copyWith({
    bool? isLoading,
    String? error,
    List<Event>? events,
    CalendarViewType? viewType,
    DateTime? selectedDate,
    DateTime? focusedDate,
    Set<String>? selectedEventIds,
    String? searchQuery,
  }) {
    return TimetableState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      events: events ?? this.events,
      viewType: viewType ?? this.viewType,
      selectedDate: selectedDate ?? this.selectedDate,
      focusedDate: focusedDate ?? this.focusedDate,
      selectedEventIds: selectedEventIds ?? this.selectedEventIds,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  /// Get filtered events based on current view and search
  List<Event> get filteredEvents {
    List<Event> filtered = events;

    // Filter by search query if present
    if (searchQuery != null && searchQuery!.isNotEmpty) {
      final query = searchQuery!.toLowerCase();
      filtered = filtered
          .where(
            (event) =>
                event.title.toLowerCase().contains(query) ||
                event.description.toLowerCase().contains(query) ||
                event.tags?.any((tag) => tag.toLowerCase().contains(query)) ==
                    true,
          )
          .toList();
    }

    return filtered;
  }

  /// Get events for the selected date
  List<Event> get eventsForSelectedDate {
    return filteredEvents.forDate(selectedDate);
  }

  /// Get events for the focused month
  List<Event> get eventsForFocusedMonth {
    return filteredEvents.forMonth(focusedDate.year, focusedDate.month);
  }

  /// Get events for the focused week
  List<Event> get eventsForFocusedWeek {
    final weekStart = focusedDate.subtract(
      Duration(days: focusedDate.weekday - 1),
    );
    return filteredEvents.forWeek(weekStart);
  }

  /// Get upcoming events (next 7 days)
  List<Event> get upcomingEvents {
    final now = DateTime.now();
    final weekFromNow = now.add(const Duration(days: 7));
    return filteredEvents
        .where(
          (event) =>
              event.startTime.isAfter(
                now.subtract(const Duration(seconds: 1)),
              ) &&
              event.startTime.isBefore(weekFromNow),
        )
        .toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));
  }

  /// Check if an event is selected
  bool isEventSelected(String eventId) => selectedEventIds.contains(eventId);

  /// Get selected events
  List<Event> get selectedEvents {
    return events
        .where((event) => selectedEventIds.contains(event.id))
        .toList();
  }
}

/// Timetable provider for managing calendar and events state
class TimetableNotifier extends StateNotifier<TimetableState> {
  final GetEventsUseCase getEventsUseCase;
  final GetEventsForDateUseCase getEventsForDateUseCase;
  final GetEventsForWeekUseCase getEventsForWeekUseCase;
  final GetEventsForMonthUseCase getEventsForMonthUseCase;
  final GetUpcomingEventsUseCase getUpcomingEventsUseCase;
  final SearchEventsUseCase searchEventsUseCase;
  final CreateEventUseCase createEventUseCase;
  final UpdateEventUseCase updateEventUseCase;
  final DeleteEventUseCase deleteEventUseCase;

  static const String _currentUserId = '1'; // Mock current user

  TimetableNotifier({
    required this.getEventsUseCase,
    required this.getEventsForDateUseCase,
    required this.getEventsForWeekUseCase,
    required this.getEventsForMonthUseCase,
    required this.getUpcomingEventsUseCase,
    required this.searchEventsUseCase,
    required this.createEventUseCase,
    required this.updateEventUseCase,
    required this.deleteEventUseCase,
  }) : super(TimetableState()) {
    loadEvents();
  }

  /// Load all events for the current user
  Future<void> loadEvents() async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await getEventsUseCase(
      GetEventsParams(userId: _currentUserId),
    );

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: _mapFailureToMessage(failure),
      ),
      (events) => state = state.copyWith(isLoading: false, events: events),
    );
  }

  /// Load events for a specific date
  Future<void> loadEventsForDate(DateTime date) async {
    final result = await getEventsForDateUseCase(
      GetEventsForDateParams(userId: _currentUserId, date: date),
    );

    result.fold(
      (failure) => state = state.copyWith(error: _mapFailureToMessage(failure)),
      (events) {
        // Update the events list with fresh data for this date
        final updatedEvents = List<Event>.from(state.events);
        // Remove existing events for this date and add new ones
        updatedEvents.removeWhere(
          (event) =>
              event.startTime.year == date.year &&
              event.startTime.month == date.month &&
              event.startTime.day == date.day,
        );
        updatedEvents.addAll(events);
        state = state.copyWith(events: updatedEvents);
      },
    );
  }

  /// Change calendar view type
  void changeViewType(CalendarViewType viewType) {
    state = state.copyWith(viewType: viewType);
  }

  /// Select a date in the calendar
  void selectDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
  }

  /// Change focused date (for navigation)
  void changeFocusedDate(DateTime date) {
    state = state.copyWith(focusedDate: date);
  }

  /// Navigate to previous period (month/week/day)
  void navigatePrevious() {
    switch (state.viewType) {
      case CalendarViewType.month:
        final newDate = DateTime(
          state.focusedDate.year,
          state.focusedDate.month - 1,
          1,
        );
        state = state.copyWith(focusedDate: newDate);
        break;
      case CalendarViewType.week:
        final newDate = state.focusedDate.subtract(const Duration(days: 7));
        state = state.copyWith(focusedDate: newDate);
        break;
      case CalendarViewType.day:
        final newDate = state.focusedDate.subtract(const Duration(days: 1));
        state = state.copyWith(focusedDate: newDate, selectedDate: newDate);
        break;
      case CalendarViewType.schedule:
        // For schedule view, maybe navigate by week
        final newDate = state.focusedDate.subtract(const Duration(days: 7));
        state = state.copyWith(focusedDate: newDate);
        break;
    }
  }

  /// Navigate to next period (month/week/day)
  void navigateNext() {
    switch (state.viewType) {
      case CalendarViewType.month:
        final newDate = DateTime(
          state.focusedDate.year,
          state.focusedDate.month + 1,
          1,
        );
        state = state.copyWith(focusedDate: newDate);
        break;
      case CalendarViewType.week:
        final newDate = state.focusedDate.add(const Duration(days: 7));
        state = state.copyWith(focusedDate: newDate);
        break;
      case CalendarViewType.day:
        final newDate = state.focusedDate.add(const Duration(days: 1));
        state = state.copyWith(focusedDate: newDate, selectedDate: newDate);
        break;
      case CalendarViewType.schedule:
        // For schedule view, maybe navigate by week
        final newDate = state.focusedDate.add(const Duration(days: 7));
        state = state.copyWith(focusedDate: newDate);
        break;
    }
  }

  /// Navigate to today
  void navigateToToday() {
    final today = DateTime.now();
    state = state.copyWith(focusedDate: today, selectedDate: today);
  }

  /// Create a new event
  Future<bool> createEvent(Event event) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await createEventUseCase(
      CreateEventParams(
        event: event.copyWith(userId: _currentUserId),
        allowConflicts: false,
      ),
    );

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: _mapFailureToMessage(failure),
        );
        return false;
      },
      (createdEvent) {
        final updatedEvents = [...state.events, createdEvent];
        state = state.copyWith(isLoading: false, events: updatedEvents);
        return true;
      },
    );
  }

  /// Update an existing event
  Future<bool> updateEvent(String eventId, Event event) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await updateEventUseCase(
      UpdateEventParams(eventId: eventId, event: event, allowConflicts: false),
    );

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: _mapFailureToMessage(failure),
        );
        return false;
      },
      (updatedEvent) {
        final updatedEvents = state.events
            .map((e) => e.id == eventId ? updatedEvent : e)
            .toList();
        state = state.copyWith(isLoading: false, events: updatedEvents);
        return true;
      },
    );
  }

  /// Delete an event
  Future<bool> deleteEvent(String eventId) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await deleteEventUseCase(
      DeleteEventParams(eventId: eventId),
    );

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: _mapFailureToMessage(failure),
        );
        return false;
      },
      (_) {
        final updatedEvents = state.events
            .where((e) => e.id != eventId)
            .toList();
        state = state.copyWith(isLoading: false, events: updatedEvents);
        return true;
      },
    );
  }

  /// Toggle event selection
  void toggleEventSelection(String eventId) {
    final selectedIds = Set<String>.from(state.selectedEventIds);
    if (selectedIds.contains(eventId)) {
      selectedIds.remove(eventId);
    } else {
      selectedIds.add(eventId);
    }
    state = state.copyWith(selectedEventIds: selectedIds);
  }

  /// Clear all event selections
  void clearEventSelection() {
    state = state.copyWith(selectedEventIds: const {});
  }

  /// Search events
  void searchEvents(String query) {
    state = state.copyWith(searchQuery: query.isEmpty ? null : query);
  }

  /// Clear search
  void clearSearch() {
    state = state.copyWith(searchQuery: null);
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// Map failure to user-friendly message
  String _mapFailureToMessage(Failure failure) {
    return failure.when(
      network: (message, code) =>
          'Network connection failed. Please check your internet connection.',
      server: (message, statusCode, code) =>
          'Server error occurred. Please try again later.',
      validation: (message, errors) => message,
      authentication: (message, code) =>
          'Authentication failed. Please log in again.',
      authorization: (message, code) =>
          'You do not have permission to perform this action.',
      timeout: (message) => 'Request timed out. Please try again.',
      websocket: (message, code) =>
          'Connection error. Please check your internet connection.',
      cache: (message, code) => 'Cache error occurred.',
      storage: (message, code) => 'Storage error occurred.',
      unknown: (message, error, stackTrace) => message,
    );
  }
}

/// Repository provider
final timetableRepositoryProvider = Provider<TimetableRepository>((ref) {
  final api = TimetableApiMock();
  return TimetableRepositoryImpl(api);
});

/// Use case providers
final getEventsUseCaseProvider = Provider<GetEventsUseCase>((ref) {
  final repository = ref.watch(timetableRepositoryProvider);
  return GetEventsUseCase(repository);
});

final getEventsForDateUseCaseProvider = Provider<GetEventsForDateUseCase>((
  ref,
) {
  final repository = ref.watch(timetableRepositoryProvider);
  return GetEventsForDateUseCase(repository);
});

final getEventsForWeekUseCaseProvider = Provider<GetEventsForWeekUseCase>((
  ref,
) {
  final repository = ref.watch(timetableRepositoryProvider);
  return GetEventsForWeekUseCase(repository);
});

final getEventsForMonthUseCaseProvider = Provider<GetEventsForMonthUseCase>((
  ref,
) {
  final repository = ref.watch(timetableRepositoryProvider);
  return GetEventsForMonthUseCase(repository);
});

final getUpcomingEventsUseCaseProvider = Provider<GetUpcomingEventsUseCase>((
  ref,
) {
  final repository = ref.watch(timetableRepositoryProvider);
  return GetUpcomingEventsUseCase(repository);
});

final searchEventsUseCaseProvider = Provider<SearchEventsUseCase>((ref) {
  final repository = ref.watch(timetableRepositoryProvider);
  return SearchEventsUseCase(repository);
});

final createEventUseCaseProvider = Provider<CreateEventUseCase>((ref) {
  final repository = ref.watch(timetableRepositoryProvider);
  return CreateEventUseCase(repository);
});

final updateEventUseCaseProvider = Provider<UpdateEventUseCase>((ref) {
  final repository = ref.watch(timetableRepositoryProvider);
  return UpdateEventUseCase(repository);
});

final deleteEventUseCaseProvider = Provider<DeleteEventUseCase>((ref) {
  final repository = ref.watch(timetableRepositoryProvider);
  return DeleteEventUseCase(repository);
});

/// Main timetable provider
final timetableProvider =
    StateNotifierProvider<TimetableNotifier, TimetableState>((ref) {
      final getEventsUseCase = ref.watch(getEventsUseCaseProvider);
      final getEventsForDateUseCase = ref.watch(
        getEventsForDateUseCaseProvider,
      );
      final getEventsForWeekUseCase = ref.watch(
        getEventsForWeekUseCaseProvider,
      );
      final getEventsForMonthUseCase = ref.watch(
        getEventsForMonthUseCaseProvider,
      );
      final getUpcomingEventsUseCase = ref.watch(
        getUpcomingEventsUseCaseProvider,
      );
      final searchEventsUseCase = ref.watch(searchEventsUseCaseProvider);
      final createEventUseCase = ref.watch(createEventUseCaseProvider);
      final updateEventUseCase = ref.watch(updateEventUseCaseProvider);
      final deleteEventUseCase = ref.watch(deleteEventUseCaseProvider);

      return TimetableNotifier(
        getEventsUseCase: getEventsUseCase,
        getEventsForDateUseCase: getEventsForDateUseCase,
        getEventsForWeekUseCase: getEventsForWeekUseCase,
        getEventsForMonthUseCase: getEventsForMonthUseCase,
        getUpcomingEventsUseCase: getUpcomingEventsUseCase,
        searchEventsUseCase: searchEventsUseCase,
        createEventUseCase: createEventUseCase,
        updateEventUseCase: updateEventUseCase,
        deleteEventUseCase: deleteEventUseCase,
      );
    });

/// Convenience providers for specific state slices
final timetableLoadingProvider = Provider<bool>((ref) {
  return ref.watch(timetableProvider).isLoading;
});

final timetableErrorProvider = Provider<String?>((ref) {
  return ref.watch(timetableProvider).error;
});

final timetableViewTypeProvider = Provider<CalendarViewType>((ref) {
  return ref.watch(timetableProvider).viewType;
});

final timetableSelectedDateProvider = Provider<DateTime>((ref) {
  return ref.watch(timetableProvider).selectedDate;
});

final timetableFocusedDateProvider = Provider<DateTime>((ref) {
  return ref.watch(timetableProvider).focusedDate;
});

final timetableEventsProvider = Provider<List<Event>>((ref) {
  return ref.watch(timetableProvider).filteredEvents;
});

final timetableEventsForSelectedDateProvider = Provider<List<Event>>((ref) {
  return ref.watch(timetableProvider).eventsForSelectedDate;
});

final timetableEventsForFocusedMonthProvider = Provider<List<Event>>((ref) {
  return ref.watch(timetableProvider).eventsForFocusedMonth;
});

final timetableUpcomingEventsProvider = Provider<List<Event>>((ref) {
  return ref.watch(timetableProvider).upcomingEvents;
});
