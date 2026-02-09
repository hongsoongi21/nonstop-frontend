import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/supabase/supabase_provider.dart';
import '../../data/api/university_api.dart';
import '../../data/repository_impl/university_repository_impl.dart';
import '../../domain/entities/university.dart';
import '../../domain/repository/university_repository.dart';

/// UniversityApi 구현체에 대한 Provider입니다.
final universityApiProvider = Provider<UniversityApi>((ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return UniversityApiImpl(supabaseClient);
});

/// UniversityRepository 구현체에 대한 Provider입니다.
final universityRepositoryProvider = Provider<UniversityRepository>((ref) {
  final api = ref.watch(universityApiProvider);
  return UniversityRepositoryImpl(api);
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