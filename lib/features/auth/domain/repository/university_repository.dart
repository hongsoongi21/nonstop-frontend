import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/university.dart';

/// Repository interface for university-related operations
abstract class UniversityRepository {
  /// Get the list of all available universities
  Future<Either<Failure, List<University>>> getUniversities();

  /// Get details for a specific university by its ID
  Future<Either<Failure, University>> getUniversityById(int id);
}
