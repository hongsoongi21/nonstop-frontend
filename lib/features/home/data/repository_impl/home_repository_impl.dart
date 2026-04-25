import 'dart:developer';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/home_dashboard.dart';
import '../../domain/repositories/home_repository.dart';
import '../api/home_api.dart';
import '../dto/home_dashboard_dto.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeApi _api;

  HomeRepositoryImpl(this._api);

  @override
  Future<Either<Failure, HomeDashboard>> getDashboard({
    String? weekday,
    int noticeLimit = 5,
    int popularLimit = 5,
  }) async {
    try {
      final dto = await _api.getDashboard(
        weekday: weekday,
        noticeLimit: noticeLimit,
        popularLimit: popularLimit,
      );
      return Right(dto.toDomain());
    } on PostgrestException catch (e, st) {
      log('getDashboard PostgrestException: $e', name: 'HomeRepository', stackTrace: st);
      return Left(
        Failure.server(
          message: e.message,
          statusCode: int.tryParse(e.code ?? '') ?? 500,
          code: e.code,
        ),
      );
    } on SocketException catch (e, st) {
      log('getDashboard SocketException: $e', name: 'HomeRepository', stackTrace: st);
      return Left(Failure.network(message: e.message));
    } catch (e, st) {
      log('getDashboard unknown error: $e', name: 'HomeRepository', stackTrace: st);
      return Left(Failure.unknown(message: e.toString(), error: e, stackTrace: st));
    }
  }
}
