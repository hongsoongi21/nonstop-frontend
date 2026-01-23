import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/policy.dart';
import 'auth_provider.dart';

/// 정책 목록을 관리하는 Provider
final policiesProvider = FutureProvider.autoDispose<List<Policy>>((ref) async {
  final repository = ref.watch(authRepositoryProvider);
  final result = await repository.getPolicies();
  
  return result.fold(
    (failure) => throw failure,
    (policies) {
      // id 순으로 정렬
      final sortedPolicies = List<Policy>.from(policies)
        ..sort((a, b) => a.id.compareTo(b.id));
      return sortedPolicies;
    },
  );
});
