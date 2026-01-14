import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/university.dart';

part 'university_response_dto.freezed.dart';
part 'university_response_dto.g.dart';

@freezed
class UniversityResponseDto with _$UniversityResponseDto {
  const factory UniversityResponseDto({
    required int id,
    required String name,
    String? region,
    String? logoImageUrl,
  }) = _UniversityResponseDto;

  factory UniversityResponseDto.fromJson(Map<String, dynamic> json) =>
      _$UniversityResponseDtoFromJson(json);

  const UniversityResponseDto._();

  University toDomain() {
    return University(
      id: id,
      name: name,
      region: region,
      logoImageUrl: logoImageUrl,
    );
  }
}
