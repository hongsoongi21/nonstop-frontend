import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/exceptions.dart';
import '../dto/university_response_dto.dart';

abstract class UniversityApi {
  Future<UniversityListResponseDto> getUniversities({
    String? keyword,
    String? region,
    int? limit,
    int? offset,
  });

  Future<UniversityResponseDto> getUniversityById(int id);
}

class UniversityApiImpl implements UniversityApi {
  final SupabaseClient _supabase;

  UniversityApiImpl(this._supabase);

  @override
  Future<UniversityListResponseDto> getUniversities({
    String? keyword,
    String? region,
    int? limit,
    int? offset,
  }) async {
    try {
      var query = _supabase.from('universities').select();

      if (keyword != null && keyword.isNotEmpty) {
        query = query.ilike('name', '%$keyword%');
      }
      if (region != null && region.isNotEmpty) {
        query = query.eq('region', region);
      }

      final effectiveLimit = limit ?? 50;
      final effectiveOffset = offset ?? 0;

      final data = await query
          .order('name')
          .range(effectiveOffset, effectiveOffset + effectiveLimit - 1);

      final items = (data as List)
          .map((json) => UniversityResponseDto(
                id: json['id'] as int,
                name: json['name'] as String,
                region: json['region'] as String?,
                logoImageUrl: json['logo_image_url'] as String?,
              ))
          .toList();

      return UniversityListResponseDto(
        items: items,
        totalCount: items.length,
        hasMore: items.length >= effectiveLimit,
        limit: effectiveLimit,
        offset: effectiveOffset,
      );
    } catch (e) {
      throw ServerException(
        message: '대학교 목록을 불러오는데 실패했습니다: $e',
        statusCode: 500,
      );
    }
  }

  @override
  Future<UniversityResponseDto> getUniversityById(int id) async {
    try {
      final data = await _supabase
          .from('universities')
          .select()
          .eq('id', id)
          .single();

      return UniversityResponseDto(
        id: data['id'] as int,
        name: data['name'] as String,
        region: data['region'] as String?,
        logoImageUrl: data['logo_image_url'] as String?,
      );
    } catch (e) {
      throw ServerException(
        message: '대학교 정보를 불러오는데 실패했습니다: $e',
        statusCode: 500,
      );
    }
  }
}
