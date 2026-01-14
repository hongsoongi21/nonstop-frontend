import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/university.dart';
import '../../domain/repository/university_repository.dart';
import '../api/university_api.dart';

class UniversityRepositoryImpl implements UniversityRepository {
  final UniversityApi _universityApi;

  UniversityRepositoryImpl(this._universityApi);

  @override
  Future<Either<Failure, List<University>>> getUniversities() async {
    try {
      final dtos = await _universityApi.getUniversities();
      final universities = dtos.map((dto) => dto.toDomain()).toList();
      return Right(universities);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, University>> getUniversityById(int id) async {
    try {
      final dto = await _universityApi.getUniversityById(id);
      return Right(dto.toDomain());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}