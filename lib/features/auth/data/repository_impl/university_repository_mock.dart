import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/university.dart';
import '../../domain/repository/university_repository.dart';

/// 개발 및 테스트를 위한 UniversityRepository의 Mock 구현체입니다.
class UniversityRepositoryMock implements UniversityRepository {
  // 요구사항 및 일반적인 우즈베키스탄 대학교 목록을 기반으로 한 하드코딩된 Mock 데이터
  final List<University> _mockUniversities = [
    const University(id: 1, name: 'Tashkent State University of Economics', region: 'Tashkent'),
    const University(id: 2, name: 'National University of Uzbekistan', region: 'Tashkent'),
    const University(id: 3, name: 'Westminster International University in Tashkent', region: 'Tashkent'),
    const University(id: 4, name: 'Inha University in Tashkent', region: 'Tashkent'),
    const University(id: 5, name: 'Turin Polytechnic University in Tashkent', region: 'Tashkent'),
    const University(id: 6, name: 'Management Development Institute of Singapore in Tashkent', region: 'Tashkent'),
    const University(id: 7, name: 'Tashkent University of Information Technologies', region: 'Tashkent'),
    const University(id: 8, name: 'Tashkent State Technical University', region: 'Tashkent'),
  ];

  @override
  Future<Either<Failure, List<University>>> getUniversities() async {
    // 짧은 네트워크 지연을 시뮬레이션합니다.
    await Future.delayed(const Duration(milliseconds: 500));
    
    return Right(_mockUniversities);
  }

  @override
  Future<Either<Failure, University>> getUniversityById(int id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    try {
      final university = _mockUniversities.firstWhere((u) => u.id == id);
      return Right(university);
    } catch (e) {
      return Left(Failure.server(
        message: 'University with id $id not found in mock data',
        statusCode: 404,
      ));
    }
  }
}
