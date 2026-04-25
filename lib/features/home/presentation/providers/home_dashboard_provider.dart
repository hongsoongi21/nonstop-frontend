import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/home_dashboard.dart';
import 'home_providers.dart';

/// Home dashboard provider.
///
/// Not `autoDispose` because the in-memory 5-minute TTL cache
/// (PRD §4.2) must survive tab switches. The notifier state is
/// retained for the app lifetime; `refresh()` bypasses the cache.
final homeDashboardProvider =
    AsyncNotifierProvider<HomeDashboardNotifier, HomeDashboard>(
  HomeDashboardNotifier.new,
);

class HomeDashboardNotifier extends AsyncNotifier<HomeDashboard> {
  DateTime? _lastFetchedAt;
  HomeDashboard? _cached;

  static const _cacheDuration = Duration(minutes: 5);

  @override
  Future<HomeDashboard> build() async {
    return _fetchWithCache();
  }

  Future<HomeDashboard> _fetchWithCache() async {
    final now = DateTime.now();
    if (_cached != null &&
        _lastFetchedAt != null &&
        now.difference(_lastFetchedAt!) < _cacheDuration) {
      return _cached!;
    }
    return _fetch();
  }

  Future<HomeDashboard> _fetch() async {
    final useCase = ref.read(getHomeDashboardProvider);
    final result = await useCase(weekday: _weekdayName(DateTime.now()));
    return result.fold(
      (failure) => throw failure,
      (dashboard) {
        _cached = dashboard;
        _lastFetchedAt = DateTime.now();
        return dashboard;
      },
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetch());
  }

  String _weekdayName(DateTime date) {
    const days = [
      'MONDAY',
      'TUESDAY',
      'WEDNESDAY',
      'THURSDAY',
      'FRIDAY',
      'SATURDAY',
      'SUNDAY',
    ];
    // DateTime.weekday: 1=Monday ... 7=Sunday
    return days[date.weekday - 1];
  }
}
