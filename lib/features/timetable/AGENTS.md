<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-03-08 | Updated: 2026-03-08 -->

# timetable

## Purpose
Provides a weekly class schedule manager where students can create multiple timetables per semester, add course entries (subject, professor, day, start/end time, room, color, credit), and detect scheduling conflicts. Users choose a semester from a dropdown, create/rename/delete timetables, and view entries on a weekly time-grid. A separate GPA calculator screen (`gpa_calculator_screen.dart`) tracks grades and computes weighted GPA. The feature supports public timetable sharing via `getPublicTimetables()`. Color-coded entries are rendered in `WeeklyTimeGrid` as positioned blocks.

## Key Files
| File | Description |
|------|-------------|
| `presentation/providers/timetable_management_provider.dart` | `TimetableManagementNotifier` / `TimetableManagementState` — semester list, my timetables, selected timetable detail |
| `presentation/providers/gpa_provider.dart` | GPA calculation state (courses + grades) |
| `presentation/screens/timetable_screen.dart` | Main screen: semester picker, timetable list/switcher, weekly grid |
| `presentation/screens/add_timetable_entry_screen.dart` | Form to add/edit a course entry |
| `presentation/screens/gpa_calculator_screen.dart` | GPA calculator with course/grade input |
| `presentation/screens/timetable_test_screen.dart` | Development test screen (not production) |
| `presentation/widgets/weekly_time_grid.dart` | Visual weekly timetable grid with color-coded course blocks |
| `presentation/widgets/calendar_header.dart` | Day-of-week header for the grid |
| `domain/entities/timetable_entry.dart` | `TimetableEntry` with conflict detection (`conflictsWith()`), duration, `displayColor` |
| `domain/entities/timetable.dart` | `Timetable` entity + `TimetableDetail` with `entriesForDay()`, `hasConflicts()` |
| `domain/entities/semester.dart` | `Semester` entity |
| `domain/entities/day_of_week.dart` | `DayOfWeek` enum (MON–SUN) |
| `domain/entities/gpa_course.dart` | `GpaCourse` entity for GPA calculator |
| `domain/repository/timetable_repository.dart` | Repository interface — semesters, timetable CRUD, entry CRUD, public timetables |
| `data/api/timetable_api_impl.dart` | Supabase implementation + `timetableRepositoryProvider` |
| `data/repository_impl/timetable_repository_impl.dart` | Repository implementation |
| `data/dto/` | `SemesterDto`, `TimetableDto`, `TimetableEntryDto` with `SemesterType` enum |

## Subdirectories
| Directory | Purpose |
|-----------|---------|
| `data/` | API implementation, 3 DTOs, repository implementation |
| `domain/` | 5 entities (Timetable, TimetableEntry, Semester, DayOfWeek, GpaCourse), repository interface |
| `presentation/` | 4 screens (1 test), 2 providers, 2 widgets |

## For AI Agents

### Working In This Directory
- `TimetableEntry.conflictsWith(other)` checks same-day time overlaps — use this before adding a new entry, not custom logic.
- `TimetableDetail.hasConflicts()` checks the full timetable for any conflicts — shown as a warning badge in the UI.
- `displayColor` on `TimetableEntry` parses hex string (with or without `#`) to ARGB int; default is `0xFF2563EB` (blue) on parse failure.
- Time strings are `"HH:mm"` format — always validate and store in this format, not timestamps.
- `DayOfWeek` enum maps to weekday numbers (1=MON...7=SUN) matching Dart's `DateTime.weekday` convention.
- The repository `migration 018` supports multiple timetables per semester — do not enforce a 1-per-semester constraint client-side.
- `timetable_test_screen.dart` is a development-only screen and should not appear in production navigation.
- `gpa_provider.dart` is independent of the timetable management provider — GPA courses are not linked to timetable entries.

### Key Providers
| Provider | Type | Purpose |
|----------|------|---------|
| `timetableManagementProvider` | `StateNotifierProvider<TimetableManagementNotifier, TimetableManagementState>` | Semester list, timetable list, selected detail |
| `gpaProvider` | (see gpa_provider.dart) | GPA course/grade tracking |
| `timetableRepositoryProvider` | `Provider<TimetableRepository>` | Repository singleton |

### API Endpoints
Backed by Supabase via `timetable_api_impl.dart`:
- `GET /semesters` — list available semesters
- `GET /timetables?user_id=` — my timetables
- `POST /timetables` — create timetable (`year`, `semester_type`, `title`, `is_public`)
- `GET /timetables/{id}` — timetable detail with entries
- `PUT /timetables/{id}` — update title/visibility
- `DELETE /timetables/{id}` — delete timetable
- `POST /timetable_entries` — add course entry
- `PUT /timetable_entries/{id}` — update entry
- `DELETE /timetable_entries/{id}` — delete entry
- `GET /timetables?is_public=true` — public timetables

### SemesterType Values
| Enum | Meaning |
|------|---------|
| `spring` | Spring semester |
| `summer` | Summer session |
| `fall` | Fall semester |
| `winter` | Winter session |

## Dependencies

### Internal
- `core/errors/failures.dart` — `Failure` typed errors
- `core/supabase/supabase_provider.dart` — Supabase client

### External
- `flutter_riverpod` — State management
- `supabase_flutter` — Backend queries
- `fpdart` — `Either<Failure, T>` and `Unit`
- `freezed_annotation` — Immutable entities and DTOs

<!-- MANUAL: -->
