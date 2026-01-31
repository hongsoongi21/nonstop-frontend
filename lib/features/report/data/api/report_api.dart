import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/exceptions.dart';
import '../dto/report_dto.dart';

/// Abstract interface for report API operations
abstract class ReportApi {
  /// Report a post
  /// Returns Either with ApiException on error, void on success
  Future<Either<ApiException, void>> reportPost({
    required int postId,
    required ReportRequestDto request,
  });

  /// Report a comment
  /// Returns Either with ApiException on error, void on success
  Future<Either<ApiException, void>> reportComment({
    required int commentId,
    required ReportRequestDto request,
  });

  /// Report a user
  /// Returns Either with ApiException on error, void on success
  Future<Either<ApiException, void>> reportUser({
    required int userId,
    required ReportRequestDto request,
  });

  /// Report a chat message
  /// Returns Either with ApiException on error, void on success
  Future<Either<ApiException, void>> reportChatMessage({
    required int messageId,
    required ReportRequestDto request,
  });
}
