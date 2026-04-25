import '../dto/home_dashboard_dto.dart';

abstract class HomeApi {
  Future<HomeDashboardDto> getDashboard({
    String? weekday,
    int noticeLimit = 5,
    int popularLimit = 5,
  });
}
