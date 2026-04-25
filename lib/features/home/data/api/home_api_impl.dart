import 'package:supabase_flutter/supabase_flutter.dart';

import '../dto/home_dashboard_dto.dart';
import 'home_api.dart';

class HomeApiImpl implements HomeApi {
  final SupabaseClient _client;

  HomeApiImpl(this._client);

  @override
  Future<HomeDashboardDto> getDashboard({
    String? weekday,
    int noticeLimit = 5,
    int popularLimit = 5,
  }) async {
    final response = await _client.rpc(
      'get_home_dashboard',
      params: {
        'p_weekday': weekday,
        'p_notice_limit': noticeLimit,
        'p_popular_limit': popularLimit,
      },
    );

    return HomeDashboardDto.fromJson(response as Map<String, dynamic>);
  }
}
