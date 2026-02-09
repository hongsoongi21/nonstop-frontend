import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/supabase/supabase_provider.dart';
import '../dto/report_dto.dart';
import 'report_api.dart';

final reportApiProvider = Provider<ReportApi>((ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return ReportApiImpl(supabaseClient);
});

class ReportApiImpl implements ReportApi {
  final SupabaseClient _supabase;

  ReportApiImpl(this._supabase);

  Future<int> _getCurrentUserId() async {
    final authUser = _supabase.auth.currentUser;
    if (authUser == null) throw const ApiException('Not authenticated');
    final data = await _supabase
        .from('users')
        .select('id')
        .eq('auth_id', authUser.id)
        .single();
    return data['id'] as int;
  }

  String _reasonToDbString(ReportReasonType reason) {
    switch (reason) {
      case ReportReasonType.spam:
        return 'SPAM';
      case ReportReasonType.abuse:
        return 'ABUSE';
      case ReportReasonType.sexual:
        return 'SEXUAL';
      case ReportReasonType.hate:
        return 'HATE';
      case ReportReasonType.illegal:
        return 'ILLEGAL';
      case ReportReasonType.privacy:
        return 'PRIVACY';
      case ReportReasonType.impersonation:
        return 'IMPERSONATION';
      case ReportReasonType.etc:
        return 'ETC';
    }
  }

  Future<Either<ApiException, void>> _report({
    required String targetType,
    required int targetId,
    required ReportRequestDto request,
  }) async {
    try {
      final currentUserId = await _getCurrentUserId();

      await _supabase.from('reports').insert({
        'reporter_id': currentUserId,
        'target_type': targetType,
        'target_id': targetId,
        'reason': _reasonToDbString(request.reason),
        if (request.description != null) 'description': request.description,
        'status': 'PENDING',
      });

      return right(null);
    } catch (e) {
      return left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, void>> reportPost({
    required int postId,
    required ReportRequestDto request,
  }) =>
      _report(targetType: 'POST', targetId: postId, request: request);

  @override
  Future<Either<ApiException, void>> reportComment({
    required int commentId,
    required ReportRequestDto request,
  }) =>
      _report(targetType: 'COMMENT', targetId: commentId, request: request);

  @override
  Future<Either<ApiException, void>> reportUser({
    required int userId,
    required ReportRequestDto request,
  }) =>
      _report(targetType: 'USER', targetId: userId, request: request);

  @override
  Future<Either<ApiException, void>> reportChatMessage({
    required int messageId,
    required ReportRequestDto request,
  }) =>
      _report(
          targetType: 'CHAT_MESSAGE', targetId: messageId, request: request);
}
