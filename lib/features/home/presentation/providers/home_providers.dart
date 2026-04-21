import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/supabase/supabase_provider.dart';
import '../../data/api/home_api_impl.dart';
import '../../data/repository_impl/home_repository_impl.dart';
import '../../domain/repositories/home_repository.dart';
import '../../domain/usecases/get_home_dashboard.dart';

final homeApiProvider = Provider<HomeApiImpl>((ref) {
  return HomeApiImpl(ref.watch(supabaseClientProvider));
});

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepositoryImpl(ref.watch(homeApiProvider));
});

final getHomeDashboardProvider = Provider<GetHomeDashboard>((ref) {
  return GetHomeDashboard(ref.watch(homeRepositoryProvider));
});
