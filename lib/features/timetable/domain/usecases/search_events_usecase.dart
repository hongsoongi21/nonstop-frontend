import 'package:fpdart/fpdart.dart';

import 'package:nonstop/core/errors/failures.dart';
import 'package:nonstop/core/usecases/usecase.dart';
import '../entities/event.dart';
import '../repository/timetable_repository.dart';

/// Use case for searching events
class SearchEventsUseCase implements UseCase<List<Event>, SearchEventsParams> {
  final TimetableRepository repository;

  SearchEventsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Event>>> call(SearchEventsParams params) {
    return repository.searchEvents(
      userId: params.userId,
      query: params.query,
    );
  }
}

/// Parameters for SearchEventsUseCase
class SearchEventsParams {
  final String userId;
  final String query;

  const SearchEventsParams({
    required this.userId,
    required this.query,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchEventsParams &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          query == other.query;

  @override
  int get hashCode => userId.hashCode ^ query.hashCode;
}
