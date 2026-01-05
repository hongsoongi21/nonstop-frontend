import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository_impl/university_repository_mock.dart';
import '../../domain/entities/university.dart';
import '../../domain/repository/university_repository.dart';

/// UniversityRepository 구현체에 대한 Provider입니다.
final universityRepositoryProvider = Provider<UniversityRepository>((ref) {
  // 계획된 대로 현재는 Mock 구현체를 사용합니다.
  return UniversityRepositoryMock();
});

/// 대학교 목록을 가져오는 FutureProvider입니다.
final universitiesProvider = FutureProvider<List<University>>((ref) async {
  final repository = ref.watch(universityRepositoryProvider);
  final result = await repository.getUniversities();
  
  return result.fold(
    (failure) => throw Exception(failure.message),
    (universities) => universities,
  );
});

/// 회원가입 폼에서 현재 선택된 대학교 ID를 관리하는 Provider입니다.
final selectedUniversityIdProvider = StateProvider<int?>((ref) => null);
